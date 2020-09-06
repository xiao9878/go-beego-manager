package controllers

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"manager/common"
	"manager/models"
	"manager/utils"
)

type CarController struct {
	beego.Controller
}

func (this *CarController) Get() {
	keyword := this.GetString("keyword", "")
	pageSize, _ := this.GetInt("pageSize", 10)
	currentPage, _ := this.GetInt("page", 1)
	car, count, countPage, _ := models.CarList(pageSize, currentPage, keyword)

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
	this.Data["car"] = car
	this.Data["prePage"] = prePage
	this.Data["nextPage"] = nextPage
	this.Data["currentPage"] = currentPage
	this.Data["countPage"] = countPage
	this.Data["count"] = count
	this.Data["pageMap"] = pageMap
	this.TplName = "car/car-list.html"
}
func (this *CarController) ToAdd() {
	var (
		car   models.Car
		brand []models.CarBrand
	)
	id, _ := this.GetInt("id", 0)
	o := orm.NewOrm()
	if id != 0 {
		o.QueryTable(new(models.Car)).Filter("id", id).RelatedSel().One(&car)
	}
	o.QueryTable(new(models.CarBrand)).Filter("is_delete", 0).All(&brand)
	this.Data["car"] = car
	this.Data["brand"] = brand
	this.TplName = "car/car-add.html"
}
func (this *CarController) DoAdd() {
	var err error
	id, _ := this.GetInt("id", 0)
	name := this.GetString("name")
	brandId, _ := this.GetInt("brand", 0)
	desc := this.GetString("desc")
	isActive, _ := this.GetInt("is_active")
	if brandId == 0 {
		this.Data["json"] = common.ReturnErr(500, "请选择品牌！")
		this.ServeJSON()
	}
	brand := models.CarBrand{Id: brandId}
	car := models.Car{
		Name:     name,
		Desc:     desc,
		CarBrand: &brand,
		IsActive: isActive,
	}
	if id != 0 {
		car.Id = id
		err = car.Update()
	} else {
		err = car.Save()
	}
	if err != nil {
		this.Data["json"] = common.ReturnErr(500, "失败！")
	} else {
		this.Data["json"] = common.ReturnOK(200, "成功", nil)
	}
	this.ServeJSON()
}
func (this *CarController) IsActive() {

	id, _ := this.GetInt("id")
	isActive, _ := this.GetInt("is_active")
	o := orm.NewOrm()
	qs := o.QueryTable(new(models.Car)).Filter("id", id)

	var res map[string]interface{}
	if isActive == 1 {
		qs.Update(orm.Params{"is_active": 0})
		res = common.ResOk("启用成功！")
	} else {
		qs.Update(orm.Params{"is_active": 1})
		res = common.ResOk("停用成功！")
	}
	this.Data["json"] = res
	this.ServeJSON()
}

func (this *CarController) Delete() {
	id, _ := this.GetInt("id")
	brand := models.Car{Id: id, IsDelete: 1}
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
