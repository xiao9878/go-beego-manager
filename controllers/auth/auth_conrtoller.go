package auth

import (
	"fmt"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"manager/common"
	"manager/models/auth"
	"manager/utils"
	"math"
	"time"
)

type AuthController struct {
	beego.Controller
}

func (this *AuthController) List() {
	pageSize := 10

	currentPage, _ := this.GetInt("page", 0)

	keyword := this.GetString("keyword")

	o := orm.NewOrm()
	auths := []auth.Auth{}
	qs := o.QueryTable(new(auth.Auth)).Filter("is_delete", 0)

	if keyword != "" {
		this.Data["keyword"] = keyword
		qs = qs.Filter("auth_name__icontains", keyword)
	}
	qs.Limit(pageSize).Offset((currentPage - 1) * pageSize).All(&auths)
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

	this.Data["auths"] = auths
	this.Data["prePage"] = prePage
	this.Data["nextPage"] = nextPage
	this.Data["currentPage"] = currentPage
	this.Data["countPage"] = countPage
	this.Data["count"] = count
	this.Data["pageMap"] = pageMap
	this.TplName = "auth/auth-list.html"
}
func (this *AuthController) ToAdd() {

	this.TplName = "auth/auth-add.html"
}
func (this *AuthController) DoAdd() {

	auth_parent_id, err1 := this.GetInt("auth_parent_id")
	auth_name := this.GetString("auth_name")
	auth_url := this.GetString("auth_url")
	auth_desc := this.GetString("auth_desc")
	auth_weight, err2 := this.GetInt("auth_weight")
	is_active, err3 := this.GetInt("is_active")
	o := orm.NewOrm()
	auth := auth.Auth{
		AuthName:   auth_name,
		UrlFor:     auth_url,
		Pid:        auth_parent_id,
		Desc:       auth_desc,
		IsActive:   is_active,
		Weight:     auth_weight,
		CreateTime: time.Time{},
	}
	fmt.Println(auth)
	_, err4 := o.Insert(&auth)
	err := common.HandleErrors(err1, err2, err3, err4)
	res := common.ResOk("添加成功")
	if err != nil {
		res = common.ResServerErr("出现未知错误！请联系管理员")
	}
	this.Data["json"] = &res
	this.ServeJSON()
}
func (this *AuthController) Test() {
	m := make(map[string]interface{})
	m["name"] = "张三"
	m["age"] = 18
}
