package controllers

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"manager/common"
	"manager/models"
	"manager/utils"
	"math"
	"strconv"
)

type RoleController struct {
	beego.Controller
}

func (this *RoleController) List() {

	pageSize := 10

	currentPage, _ := this.GetInt("page", 1)

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
		res = common.ResServerErr("出现未知错误！，请联系管理员")
	} else {
		res = common.ResOk("添加成功")
	}
	this.Data["json"] = res
	this.ServeJSON()
}
func (this *RoleController) ToRoleUser() {
	id, _ := this.GetInt("role_id")
	role := models.Role{}
	o := orm.NewOrm()
	o.QueryTable(new(models.Role)).Filter("id", id).One(&role)

	users := []models.User{}
	//已绑定的用户
	o.LoadRelated(&role, "User")
	if len(role.User) > 0 {
		o.QueryTable(new(models.User)).Filter("is_delete", 0).Filter("is_active", 0).Exclude("id__in", role.User).All(&users)
	} else {
		o.QueryTable(new(models.User)).Filter("is_delete", 0).Filter("is_active", 0).All(&users)
	}

	//为绑定的用户

	this.Data["role"] = role
	this.Data["users"] = users
	this.TplName = "auth/role-user-add.html"
}
func (this *RoleController) DoRoleUser() {
	role_id, _ := this.GetInt("role_id")
	user_id := this.GetStrings("user_id[]")

	o := orm.NewOrm()

	role := models.Role{Id: role_id}
	//查询出已绑定的数据
	m2m := o.QueryM2M(&role, "User")
	m2m.Clear()

	for _, uid := range user_id {
		id, _ := strconv.Atoi(uid)
		user := models.User{Id: id}
		m2M := o.QueryM2M(&role, "User")
		m2M.Add(user)
	}
	this.Data["json"] = common.ResOk("")
	this.ServeJSON()
}

func (this *RoleController) ToRoleAuth() {
	o := orm.NewOrm()
	var role models.Role
	role_id := this.GetString("role_id")

	o.QueryTable(new(models.Role)).Filter("id", role_id).One(&role, "id", "role_name", "desc")

	this.Data["role"] = role
	this.TplName = "auth/role-auth-add.html"
}

func (this *RoleController) GetAuthJson() {

	role_id, _ := this.GetInt("role_id")

	o := orm.NewOrm()

	//已绑定的权限
	role := models.Role{Id: role_id}
	o.LoadRelated(&role, "Auth")

	var auth_inds_has []int
	for _, auth := range role.Auth {
		auth_inds_has = append(auth_inds_has, auth.Id)
	}

	//所有权限
	var auths []models.Auth
	o.QueryTable(new(models.Auth)).Filter("is_active", 0).OrderBy("weight").All(&auths, "auth_name", "id", "pid")
	var auth_map []map[string]interface{}
	for _, auth := range auths {
		m := map[string]interface{}{"id": auth.Id, "pId": auth.Pid, "name": auth.AuthName}
		if auth.Pid == 0 {
			m["open"] = false
		}
		auth_map = append(auth_map, m)
	}

	authMaps := make(map[string]interface{})
	authMaps["auth_arr_map"] = auth_map
	authMaps["auth_ids_has"] = auth_inds_has

	this.Data["json"] = authMaps
	this.ServeJSON()
}

func (this *RoleController) DoRoleAuth() {
	role_id, _ := this.GetInt("role_id")
	auth_ids := this.GetStrings("auth_id[]")

	o := orm.NewOrm()
	role := models.Role{Id: role_id}
	m2m := o.QueryM2M(&role, "Auth")
	m2m.Clear()

	for _, auth_id := range auth_ids {
		id, _ := strconv.Atoi(auth_id)
		auth := models.Auth{Id: id}
		m2m := o.QueryM2M(&role, "Auth")
		m2m.Add(auth)
	}

	this.Data["json"] = common.ResOk("添加成功！")
	this.ServeJSON()
}
