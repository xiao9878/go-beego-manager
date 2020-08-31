package controllers

import (
	"fmt"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"github.com/google/uuid"
	"github.com/tealeg/xlsx"
	"manager/common"
	"manager/models"
	"manager/utils"
	"math"
	"os"
	"path"
	"strconv"
	"time"
)

type FinanceDataController struct {
	beego.Controller
}

func (this *FinanceDataController) Get() {
	month := this.GetString("month")
	pageSize, _ := this.GetInt("pageSize", 10)
	currentPage, _ := this.GetInt("page", 1)
	var data []models.FinanceData
	o := orm.NewOrm()
	qs := o.QueryTable(new(models.FinanceData))
	if month != "" {
		qs = qs.Filter("finance_date", month)
	}
	qs.Limit(pageSize).Offset((currentPage - 1) * pageSize).All(&data)
	count, _ := qs.Count()
	countPage := int(math.Ceil(float64(count) / float64(pageSize)))
	pageMap := utils.Paginator(currentPage, pageSize, count)
	prePage := 1
	if currentPage == 1 {
		prePage = currentPage
	} else if currentPage > 1 {
		prePage = currentPage - 1
	}
	nextPage := 1
	if currentPage < countPage {
		nextPage = currentPage + 1
	} else {
		nextPage = currentPage
	}
	this.Data["month"] = month
	this.Data["data"] = data
	this.Data["prePage"] = prePage
	this.Data["nextPage"] = nextPage
	this.Data["currentPage"] = currentPage
	this.Data["countPage"] = countPage
	this.Data["count"] = count
	this.Data["pageMap"] = pageMap

	this.TplName = "finance/finance-list.html"
}
func (this *FinanceDataController) ToImport() {
	this.TplName = "finance/import-finance.html"
}
func (this *FinanceDataController) DoImport() {
	res := make(map[string]interface{})

	var errs []error
	_, header, err := this.GetFile("file")

	ext := path.Ext(header.Filename)
	//校验文件的合法性
	var AllowExtMap map[string]bool = map[string]bool{
		".xlsx": true,
		".xls":  true,
	}
	if _, ok := AllowExtMap[ext]; !ok {
		res = common.ResClientErr("请检查文件格式！！!")
	} else {
		fileDir := "upload/" + time.Now().Format("2006/01/02") + "/"
		err = os.MkdirAll(fileDir, 777)
		if err != nil {
			fmt.Println(err)
			return
		}
		fileName := fileDir + uuid.New().String() + path.Ext(header.Filename)

		err2 := this.SaveToFile("file", fileName)
		if err2 != nil {
			fmt.Println(err2)
		}

		//读取文件数据并插入
		excel, err := xlsx.OpenFile(fileName)
		//阅后即焚
		defer os.Remove(fileName)
		if err != nil {
			fmt.Println(err)
		}
		o := orm.NewOrm()
		del, _ := o.Raw("delete from sys_finance where finance_date = ?").Prepare()
		prepare, _ := o.Raw("insert into sys_finance (finance_date,sales_volume,student_increase,boot_num,cloud_num,vue_num,react_num,create_time) values(?,?,?,?,?,?,?,?)").Prepare()
		//存放存在已有数据的工号
		var repeat []string
		for i, row := range excel.Sheets[0].Rows {
			if i == 0 {
				continue
			}
			financeDate := row.Cells[0].Value
			salesVolume := row.Cells[1].Value
			studentIncrease, _ := strconv.ParseFloat(row.Cells[2].Value, 64)
			bootNum, _ := strconv.ParseFloat(row.Cells[3].Value, 64)
			cloudNum, _ := strconv.ParseFloat(row.Cells[4].Value, 64)
			vueNum, _ := strconv.ParseFloat(row.Cells[5].Value, 64)
			reactNum, _ := strconv.ParseFloat(row.Cells[6].Value, 64)
			exec, _ := del.Exec(financeDate)
			if n, _ := exec.RowsAffected(); n != 0 {
				repeat = append(repeat, " 月份:"+financeDate)
			}
			_, err1 := prepare.Exec(financeDate, salesVolume, studentIncrease, bootNum, cloudNum, vueNum, reactNum, time.Now().Format("2006-01-02 15:04:05"))
			if err1 != nil {
				errs = append(errs, err1)
			}
		}
		prepare.Close()
		del.Close()
		if len(repeat) > 0 {
			res = common.ResOk("", repeat)
		} else {
			res = common.ResOk("")
		}
	}

	this.Data["json"] = res
	this.ServeJSON()
}
