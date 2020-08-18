package controllers

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"manager/common"
	"manager/models/auth"
)

type HomeController struct {
	beego.Controller
}

func (this *HomeController) Get() {

	//后端首页
	this.TplName = "index.html"
}

func (this *HomeController) Welcome() {
	this.TplName = "welcome.html"
}

func (this *HomeController) Test() {
	o := orm.NewOrm()
	var auths []auth.Auth
	o.QueryTable(new(auth.Auth)).Filter("is_active", 0).All(&auths)

	menus := common.TreeMenu(&auths)

	this.Data["json"] = common.ResOk("", menus)
	this.ServeJSON()
}

/*
思路整理
1.查询出所有的菜单
2.筛选出pid为0的菜单
3.遍历pid0菜单，完成第一轮子菜单获取
3.借助递归完成剩余工作
*/
