package controllers

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"manager/common"
	"manager/models"
	"manager/utils"
)

type CateController struct {
	beego.Controller
}

func (this *CateController) Get() {
	keyword := this.GetString("keyword", "")
	pageSize, _ := this.GetInt("pageSize", 10)
	currentPage, _ := this.GetInt("page", 1)
	cates, count, countPage, _ := models.CateList(pageSize, currentPage, keyword)

	pageMap := utils.Paginator(currentPage, pageSize, int64(count))
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
	this.Data["keyword"] = keyword
	this.Data["cates"] = cates
	this.Data["prePage"] = prePage
	this.Data["nextPage"] = nextPage
	this.Data["currentPage"] = currentPage
	this.Data["countPage"] = countPage
	this.Data["count"] = count
	this.Data["pageMap"] = pageMap
	this.TplName = "news/cate-list.html"
}

//
func (this *CateController) ToAdd() {
	var cate models.Category
	id, _ := this.GetInt("id")
	orm.NewOrm().QueryTable(new(models.Category)).Filter("id", id).One(&cate)
	this.Data["cate"] = cate
	this.TplName = "news/cate-add.html"
}

func (this *CateController) DoAdd() {
	var err error
	id, _ := this.GetInt("id", 0)
	name := this.GetString("name")
	desc := this.GetString("desc")
	is_active, _ := this.GetInt("is_active")
	cate := models.Category{
		Name:     name,
		Desc:     desc,
		IsActive: is_active,
	}
	if id == 0 {
		err = models.CateSave(&cate)
	} else {
		cate.Id = id
		err = models.CateUpdate(&cate)
	}
	if err != nil {
		this.Data["json"] = common.ReturnErr(500, "失败！")
	} else {
		this.Data["json"] = common.ReturnOK(200, "成功", nil)
	}
	this.ServeJSON()
}
func (this *CateController) Put() {
	id, _ := this.GetInt("id")
	err := models.CateDel(id)
	if err != nil {
		this.Data["json"] = common.ReturnErr(500, "删除失败！")
	} else {
		this.Data["json"] = common.ReturnOK(200, "删除成功！", nil)
	}
	this.ServeJSON()
}
func (this *CateController) IsActive() {
	id, _ := this.GetInt("id")
	is_active, _ := this.GetInt("is_active")
	if is_active == 0 {
		is_active = 1
	} else {
		is_active = 0
	}
	cate := models.Category{Id: id, IsActive: is_active}
	_, err := orm.NewOrm().Update(&cate, "is_active")
	if err != nil {
		this.Data["json"] = common.ReturnErr(500, "操作失败！")
	} else {
		this.Data["json"] = common.ReturnOK(200, "操作成功！", nil)
	}
	this.ServeJSON()
}

// @router /main/cate/:id [delete]
func (this *CateController) DoDelete() {
	id, _ := this.GetInt("id")
	err := models.CateDel(id)
	if err != nil {
		this.Data["json"] = common.ReturnErr(500, "删除失败！")
	} else {
		this.Data["json"] = common.ReturnOK(200, "删除成功！", nil)
	}
	this.ServeJSON()
}
