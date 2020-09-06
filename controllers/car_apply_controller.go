package controllers

import (
	"fmt"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"manager/common"
	"manager/models"
	"manager/utils"
	"time"
)

type CarApplyController struct {
	beego.Controller
}

func (this *CarApplyController) Get() {
	keyword := this.GetString("keyword", "")
	pageSize, _ := this.GetInt("pageSize", 10)
	currentPage, _ := this.GetInt("page", 1)
	car, count, countPage, _ := models.CarList(pageSize, currentPage, keyword, "status")

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
	this.TplName = "car/car-apply-list.html"
}
func (this *CarApplyController) ToAdd() {
	var (
		car models.Car
	)
	id, _ := this.GetInt("id", 0)
	o := orm.NewOrm()
	if id != 0 {
		o.QueryTable(new(models.Car)).Filter("id", id).RelatedSel().One(&car)
	} else {
		this.Ctx.WriteString("请求错误！")
	}
	uid := this.GetSession("id")
	this.Data["car"] = car
	this.Data["uid"] = uid
	this.TplName = "car/car-apply-add.html"
}
func (this *CarApplyController) DoAdd() {
	var err error
	cid, _ := this.GetInt("car_id", 0)
	uid, _ := this.GetInt("user_id", 0)
	reason := this.GetString("reason")
	dest := this.GetString("dest")
	rdate := this.GetString("return_date")
	t, _ := time.Parse("2006-01-02", rdate)
	fmt.Println("转换后的日期为:", t)
	date, _ := time.ParseInLocation("2006-01-02", rdate, time.Local)
	user := models.User{Id: uid}
	car := models.Car{Id: cid}
	apply := models.CarApply{
		User:        &user,
		Car:         &car,
		Reason:      reason,
		Destination: dest,
		ReturnTime:  date,
	}
	o := orm.NewOrm()
	o.Begin()
	err = apply.Save()
	_, err = o.QueryTable(new(models.Car)).Filter("id", cid).Update(orm.Params{"status": 1})
	if err != nil {
		o.Rollback()
		this.Data["json"] = common.ReturnErr(500, "失败！")
		this.ServeJSON()
	}
	err = o.Commit()
	//if id != 0 {
	//	car.Id = id
	//	err = car.Update()
	//} else {
	//	err = car.Save()
	//}
	if err != nil {
		this.Data["json"] = common.ReturnErr(500, "失败！")
	} else {
		this.Data["json"] = common.ReturnOK(200, "成功", nil)
	}
	this.ServeJSON()
}

//个人申请记录
func (this *CarApplyController) MyApply() {
	pageSize, _ := this.GetInt("pageSize", 10)
	currentPage, _ := this.GetInt("page", 1)
	uid := this.GetSession("id").(int)
	keyword := this.GetString("keyword")
	list, count, countPage, _ := models.CarApplyList(pageSize, currentPage, keyword, uid)
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
	this.Data["apply"] = list
	this.Data["prePage"] = prePage
	this.Data["nextPage"] = nextPage
	this.Data["currentPage"] = currentPage
	this.Data["countPage"] = countPage
	this.Data["count"] = count
	this.Data["pageMap"] = pageMap

	this.TplName = "car/car-apply-history.html"
}

func (this *CarApplyController) IsActive() {

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

func (this *CarApplyController) Delete() {
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
