package controllers

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"manager/models"
	"manager/utils"
	"math"
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
	this.TplName = "user/pays-list.html"
}

func (this *FinanceController) Detail() {
	id, _ := this.GetInt("id")
	var salary models.Salary
	orm.NewOrm().QueryTable(new(models.Salary)).Filter("id", id).One(&salary)
	this.Data["salary"] = salary
	this.TplName = "user/salary-detail.html"

}
