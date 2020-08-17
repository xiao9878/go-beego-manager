package auth

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"manager/models/auth"
	"manager/utils"
	"math"
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
