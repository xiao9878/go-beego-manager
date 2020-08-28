package controllers

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"manager/common"
	"manager/models"
)

type HomeController struct {
	beego.Controller
}

func (this *HomeController) Get() {

	user_id := this.GetSession("id").(int)

	user := models.User{Id: user_id}

	o := orm.NewOrm()

	o.LoadRelated(&user, "Role")

	var auth_arr []int
	for _, role := range user.Role {
		role_data := models.Role{Id: role.Id}
		o.LoadRelated(&role_data, "Auth")
		for _, auth := range role_data.Auth {
			auth_arr = append(auth_arr, auth.Id)
		}
	}

	var auths []models.Auth
	o.QueryTable(new(models.Auth)).Filter("is_active", 0).Filter("id__in", auth_arr).All(&auths)
	o.QueryTable(new(models.User)).Filter("id", user_id).One(&user)

	menus := common.TreeMenu(&auths)

	this.Data["tree"] = menus
	this.Data["user"] = user

	//后端首页
	this.TplName = "index.html"
}

func (this *HomeController) Welcome() {
	this.TplName = "welcome.html"
}

func (this *HomeController) Test() {
	o := orm.NewOrm()

	var list []map[string]interface{}

	o.Raw("select * from sys_user").QueryRows(&list)

	//o.QueryTable("sys_user").All(list, "id", "user_name")

	this.Data["json"] = common.ResOk("", list)
	this.ServeJSON()
}

/*
思路整理
1.查询出所有的菜单
2.筛选出pid为0的菜单
3.遍历pid0菜单，完成第一轮子菜单获取
3.借助递归完成剩余工作
*/
