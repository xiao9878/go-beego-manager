package controllers

import (
	"fmt"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"github.com/google/uuid"
	"github.com/tealeg/xlsx"
	"manager/common"
	models "manager/models"
	"manager/utils"
	"math"
	"os"
	"path"
	"strconv"
	"time"
)

type FinanceController struct {
	beego.Controller
}

func (this *FinanceController) Get() {
	pageSize := 10
	currentPage, _ := this.GetInt("page", 1)

	month := this.GetString("month", time.Now().Format("2006-01"))
	var salary []models.Salary
	qs := orm.NewOrm().QueryTable(new(models.Salary))
	qs.Limit(pageSize).Offset((currentPage-1)*pageSize).Filter("pay_date", month).All(&salary)
	count, _ := qs.Filter("pay_date", month).Count()
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

	this.Data["salary"] = salary
	this.Data["month"] = month
	this.Data["prePage"] = prePage
	this.Data["nextPage"] = nextPage
	this.Data["currentPage"] = currentPage
	this.Data["countPage"] = countPage
	this.Data["count"] = count
	this.Data["pageMap"] = pageMap
	this.TplName = "user/finance-list.html"
}

func (this *FinanceController) Detail() {
	id, _ := this.GetInt("id")
	var salary models.Salary
	orm.NewOrm().QueryTable(new(models.Salary)).Filter("id", id).One(&salary)
	this.Data["salary"] = salary
	this.TplName = "user/salary-detail.html"
}

func (this *FinanceController) ToImportExcel() {
	this.TplName = "finance/import-excel.html"
}
func (this *FinanceController) DoImportExcel() {
	file, header, err := this.GetFile("file")
	defer file.Close()
	res := make(map[string]interface{})
	if err != nil {
		res = common.ResServerErr("出现未知错误，请联系网站管理员" + err.Error())
	}
	fileDir := "upload/" + time.Now().Format("2006/01/02") + "/"
	err = os.MkdirAll(fileDir, 777)
	if err != nil {
		fmt.Println(err)
		return
	}
	fileName := fileDir + uuid.New().String() + path.Ext(header.Filename)

	//var wait sync.WaitGroup
	//wait.Add(1)
	//go func() {
	//	err2 := this.SaveToFile("file", fileName)
	//	if err2 != nil {
	//		fmt.Println(err2)
	//	}
	//	wait.Done()
	//}()
	//wait.Wait()

	err2 := this.SaveToFile("file", fileName)
	if err2 != nil {
		fmt.Println(err2)
	}

	//读取文件数据并插入
	excel, err := xlsx.OpenFile(fileName)
	if err != nil {
		fmt.Println(err)
	}
	o := orm.NewOrm()
	del, _ := o.Raw("delete from sys_salary where card_id = ? and pay_date = ?").Prepare()
	prepare, _ := o.Raw("insert into sys_salary (card_id,pay_date,work_day,reward,tax,fine,perk,social,net_salary,creat_time) values(?,?,?,?,?,?,?,?,?,?)").Prepare()
	//存放存在已有数据的工号
	var repeat []string
	for i, row := range excel.Sheets[0].Rows {
		if i == 0 {
			continue
		}
		cardId := row.Cells[0].Value
		payDate := row.Cells[1].Value
		workDay, _ := strconv.ParseFloat(row.Cells[2].Value, 64)
		reward, _ := strconv.ParseFloat(row.Cells[3].Value, 64)
		tax, _ := strconv.ParseFloat(row.Cells[4].Value, 64)
		fine, _ := strconv.ParseFloat(row.Cells[5].Value, 64)
		perk, _ := strconv.ParseFloat(row.Cells[6].Value, 64)
		social, _ := strconv.ParseFloat(row.Cells[7].Value, 64)
		netSalary, _ := strconv.ParseFloat(row.Cells[8].Value, 64)
		exec, err := del.Exec(cardId, payDate)
		if n, _ := exec.RowsAffected(); n != 0 {
			repeat = append(repeat, "工号:"+cardId+" 月份:"+payDate)
		}
		_, err1 := prepare.Exec(cardId, payDate, workDay, reward, tax, fine, perk, social, netSalary, time.Now())
		if err1 != nil {
			fmt.Println(err)
		}
	}
	prepare.Close()
	del.Close()
	res = common.ResOk("", repeat)
	this.Data["json"] = res
	this.ServeJSON()
}
