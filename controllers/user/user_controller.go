package user

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"manager/models/user"
)

type UserController struct {
	beego.Controller
}

func (this *UserController) Get() {
	o := orm.NewOrm()

	users := []user.User{}
	o.QueryTable(new(user.User)).Filter("is_delete", 0).All(&users)

	this.Data["users"] = users
	this.TplName = "user/user.html"
}
