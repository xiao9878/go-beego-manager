package controllers

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"manager/common"
	"manager/models"
)

type PersonController struct {
	beego.Controller
}

func (this *PersonController) Get() {
	id := this.GetSession("id").(int)
	var user models.User
	orm.NewOrm().QueryTable(new(models.User)).Filter("id", id).One(&user)
	this.Data["user"] = user
	this.TplName = "user/person.html"
}

func (this *PersonController) Post() {
	id, _ := this.GetInt("id")
	age, _ := this.GetInt("age")
	uname := this.GetString("username")
	gender := this.GetString("gender")
	phone := this.GetString("phone")
	addr := this.GetString("addr")

	orm.NewOrm().QueryTable(new(models.User)).Filter("id", id).Update(orm.Params{"user_name": uname, "age": age, "gender": gender, "phone": phone, "addr": addr})

	this.Data["json"] = common.ResOk("修改成功")
	this.ServeJSON()
}
