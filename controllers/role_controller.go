package controllers

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"manager/common"
	"manager/models"
	"manager/utils"
	"math"
)

type RoleController struct {
	beego.Controller
}

func (this *RoleController) List() {

	pageSize := 10

	currentPage, _ := this.GetInt("page", 0)

	o := orm.NewOrm()
	roles := []models.Role{}
	o.QueryTable(new(models.Role)).Filter("is_delete", 0).Limit(pageSize).Offset((currentPage - 1) * pageSize).All(&roles)

	count, _ := o.QueryTable(new(models.Role)).Filter("is_delete", 0).Count()

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

	this.Data["roles"] = roles
	this.Data["prePage"] = prePage
	this.Data["nextPage"] = nextPage
	this.Data["currentPage"] = currentPage
	this.Data["countPage"] = countPage
	this.Data["count"] = count
	this.Data["pageMap"] = pageMap

	this.TplName = "auth/role-list.html"
}
func (this *RoleController) ToAdd() {
	this.TplName = "auth/role-add.html"
}

func (this *RoleController) DoAdd() {
	roleName := this.GetString("role_name")
	desc := this.GetString("desc")
	isActive, _ := this.GetInt("is_active")
	role := models.Role{
		RoleName: roleName,
		Desc:     desc,
		IsActive: isActive,
	}
	_, err := orm.NewOrm().Insert(&role)
	res := make(map[string]interface{})
	if err != nil {
		res = common.ResOk("添加成功")
	} else {
		res = common.ResServerErr("出现未知错误！，请联系管理员")
	}
	this.Data["json"] = res
	this.ServeJSON()
}
func (this *AuthController) ToRoleUser() {
	id, _ := this.GetInt("role_id")
	role := models.Role{}
	orm.NewOrm().QueryTable(new(models.Role)).Filter("id", id).One(&role)
	this.Data["role"] = role
	this.TplName = "auth/role-user-auth.html"
}
