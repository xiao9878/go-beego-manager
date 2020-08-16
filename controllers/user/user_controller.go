package user

import (
	"fmt"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"manager/models/user"
	"manager/utils"
	"math"
	"net/http"
	"strconv"
)

type UserController struct {
	beego.Controller
}

func (this *UserController) List() {
	/*
		o := orm.NewOrm()

		limitNum := 10

		currentPage,err := this.GetInt("page")
		if err != nil {
			currentPage = 1
		}

		users := []user.User{}

		count, _ := o.QueryTable(new(user.User)).Filter("is_delete", 0).Count()
		o.QueryTable(new(user.User)).Filter("is_delete", 0).Limit(limitNum).Offset((currentPage-1)*limitNum).All(&users)

		countPage := int(math.Ceil(float64(count)/float64(limitNum)))

		prePage := 1
		if currentPage == 1 {
			prePage = currentPage
		} else if currentPage > 1 {
			prePage = currentPage -1
		}
		nextPage := 1
		if currentPage < countPage {
			nextPage = currentPage + 1
		} else {
			nextPage = currentPage
		}*/
	o := orm.NewOrm()

	pageSize := 5

	currentPage, err := this.GetInt("page")
	if err != nil {
		currentPage = 1
	}

	users := []user.User{}

	count, _ := o.QueryTable(new(user.User)).Filter("is_delete", 0).Count()
	o.QueryTable(new(user.User)).Filter("is_delete", 0).Limit(pageSize).Offset((currentPage - 1) * pageSize).All(&users)
	countPage := int(math.Ceil(float64(count) / float64(pageSize)))

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

	pageMap := utils.Paginator(currentPage, pageSize, count)

	this.Data["users"] = users
	this.Data["prePage"] = prePage
	this.Data["nextPage"] = nextPage
	this.Data["currentPage"] = currentPage
	this.Data["countPage"] = countPage
	this.Data["count"] = count
	this.Data["pageMap"] = pageMap

	this.TplName = "user/user.html"
}

func (this *UserController) ToAdd() {

	this.TplName = "user/user-add.html"
}
func (this *UserController) DoAdd() {
	username := this.GetString("username")
	password := this.GetString("password")
	age, _ := this.GetInt(" age")
	gender, _ := this.GetInt("gender")
	phone := this.GetString("phone")
	addr := this.GetString("addr")
	is_active, _ := this.GetInt("is_active")
	u := user.User{
		UserName: username,
		Password: utils.GetMd5File(password),
		Age:      age,
		Gender:   gender,
		Phone:    phone,
		Addr:     addr,
		IsActive: is_active,
	}
	fmt.Println(u)
	res := map[string]interface{}{}
	o := orm.NewOrm()
	_, err := o.Insert(&u)
	if err != nil {
		res["code"] = http.StatusServiceUnavailable
		res["msg"] = "添加失败"
	} else {
		res["code"] = http.StatusOK
		res["msg"] = "添加成功"
	}
	res["code"] = http.StatusOK
	res["msg"] = "添加成功"
	this.Data["json"] = res
	this.ServeJSON()
}
func (this *UserController) IsActive() {
	id, _ := this.GetInt("id")
	is_active, _ := this.GetInt("is_active")
	o := orm.NewOrm()
	qs := o.QueryTable(new(user.User)).Filter("id", id)

	res := make(map[string]interface{})
	if is_active == 1 {
		qs.Update(orm.Params{"is_active": 0})
		res["msg"] = "启用成功"
	} else if is_active == 0 {
		qs.Update(orm.Params{"is_active": 1})
		res["msg"] = "停用成功"
	}
	this.Data["json"] = res
	this.ServeJSON()
}
func (this *UserController) Delete() {
	//id,_ := this.GetInt("id")
	id, _ := strconv.Atoi(this.Input().Get("id"))
	fmt.Println(id)
	o := orm.NewOrm()
	_, err := o.QueryTable(new(user.User)).Filter("id", id).Update(orm.Params{"is_delete": 1})
	res := make(map[string]interface{})
	if err != nil {
		res["msg"] = "出现未知错误"
		res["code"] = http.StatusInternalServerError
	} else {
		res["msg"] = "删除成功！"
		res["code"] = http.StatusOK
	}
	this.Data["json"] = res
	this.ServeJSON()
}
func (this *UserController) ResetPassword() {
	id, _ := this.GetInt("id")
	o := orm.NewOrm()
	_, err := o.QueryTable(new(user.User)).Filter("id", id).Update(orm.Params{"password": utils.GetMd5File("123456")})
	res := make(map[string]interface{})
	if err != nil {
		res["msg"] = "出现未知错误"
		res["code"] = http.StatusInternalServerError
	} else {
		res["msg"] = "重置成功！"
		res["code"] = http.StatusOK
	}
	this.Data["json"] = res
	this.ServeJSON()
}
