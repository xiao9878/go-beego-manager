package controllers

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"manager/models"
	"time"
)

type SalaryController struct {
	beego.Controller
}

func (this *SalaryController) Get() {

	id := this.GetSession("id").(int)
	month := this.GetString("month", time.Now().Format("2006-01"))

	o := orm.NewOrm()
	user := models.User{}
	o.QueryTable(new(models.User)).Filter("id", id).One(&user)
	salary := models.Salary{}
	o.QueryTable(new(models.Salary)).Filter("card_id", user.CardId).Filter("pay_date", month).One(&salary)

	this.Data["salary"] = salary
	this.Data["month"] = month
	this.TplName = "user/pays-list.html"
}

func (this *SalaryController) Detail() {
	this.TplName = "user/pays-detail.html"
}
