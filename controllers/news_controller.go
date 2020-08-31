package controllers

import (
	"github.com/astaxie/beego"
	"manager/models"
	"manager/utils"
)

type NewsController struct {
	beego.Controller
}

func (this *NewsController) Get() {
	keyword := this.GetString("keyword", "")
	pageSize, _ := this.GetInt("pageSize", 10)
	currentPage, _ := this.GetInt("page", 1)
	news, count, countPage, _ := models.NewsList(pageSize, currentPage, keyword)

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
	this.Data["news"] = news
	this.Data["prePage"] = prePage
	this.Data["nextPage"] = nextPage
	this.Data["currentPage"] = currentPage
	this.Data["countPage"] = countPage
	this.Data["count"] = count
	this.Data["pageMap"] = pageMap
	this.TplName = "news/news-list.html"
}
