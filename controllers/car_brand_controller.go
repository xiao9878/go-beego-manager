package controllers

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"manager/common"
	"manager/models"
	"manager/utils"
)

type CarBrandController struct {
	beego.Controller
}

func (this *CarBrandController) Get() {
	keyword := this.GetString("keyword", "")
	pageSize, _ := this.GetInt("pageSize", 10)
	currentPage, _ := this.GetInt("page", 1)
	brand, count, countPage, _ := models.BrandList(pageSize, currentPage, keyword)

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
	this.Data["brand"] = brand
	this.Data["prePage"] = prePage
	this.Data["nextPage"] = nextPage
	this.Data["currentPage"] = currentPage
	this.Data["countPage"] = countPage
	this.Data["count"] = count
	this.Data["pageMap"] = pageMap
	this.TplName = "car/car-brand-list.html"
}
func (this *CarBrandController) ToAdd() {
	var brand models.CarBrand

	id, _ := this.GetInt("id", 0)
	o := orm.NewOrm()
	if id != 0 {
		o.QueryTable(new(models.CarBrand)).Filter("id", id).One(&brand)
	}
	this.Data["brand"] = brand
	this.TplName = "car/brand-add.html"
}
func (this *CarBrandController) DoAdd() {
	var err error
	id, _ := this.GetInt("id", 0)
	name := this.GetString("name")
	desc := this.GetString("desc")
	is_active, _ := this.GetInt("is_active")

	brand := models.CarBrand{
		Name:     name,
		Desc:     desc,
		IsActive: is_active,
	}
	if id != 0 {
		brand.Id = id
		err = brand.Update()
	} else {
		err = brand.Save()
	}
	if err != nil {
		this.Data["json"] = common.ReturnErr(500, "失败！")
	} else {
		this.Data["json"] = common.ReturnOK(200, "成功", nil)
	}
	this.ServeJSON()
}
func (this *CarBrandController) IsActive() {
	id, _ := this.GetInt("id")
	is_active, _ := this.GetInt("is_active")
	o := orm.NewOrm()
	qs := o.QueryTable(new(models.CarBrand)).Filter("id", id)

	var res map[string]interface{}
	if is_active == 1 {
		qs.Update(orm.Params{"is_active": 0})
		res = common.ResOk("启用成功！")
	} else if is_active == 0 {
		qs.Update(orm.Params{"is_active": 1})
		res = common.ResOk("停用成功！")
	}
	this.Data["json"] = res
	this.ServeJSON()
}

func (this *CarBrandController) Delete() {
	id, _ := this.GetInt("id")
	brand := models.CarBrand{Id: id, IsDelete: 1}
	_, err := orm.NewOrm().Update(&brand, "is_delete")
	var res map[string]interface{}
	if err != nil {
		res = common.ResOk("删除成功！")
	} else {
		res = common.ResOk("删除成功！")
	}
	this.Data["json"] = res
	this.ServeJSON()
}
