package user

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"manager/models/user"
	"manager/utils"
	"math"
)

type UserController struct {
	beego.Controller
}

func (this *UserController) Get() {
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

	limitNum := 10

	currentPage, err := this.GetInt("page")
	if err != nil {
		currentPage = 1
	}

	users := []user.User{}

	count, _ := o.QueryTable(new(user.User)).Filter("is_delete", 0).Count()
	o.QueryTable(new(user.User)).Filter("is_delete", 0).Limit(limitNum).Offset((currentPage - 1) * limitNum).All(&users)

	countPage := int(math.Ceil(float64(count) / float64(limitNum)))

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

	utils.Paginator(currentPage, prePage, count)

	this.Data["users"] = users
	this.Data["prePage"] = prePage
	this.Data["nextPage"] = nextPage
	this.Data["currentPage"] = nextPage
	this.Data["countPage"] = countPage
	this.Data["count"] = count
	this.TplName = "user/user.html"
}
