package controllers

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"github.com/google/uuid"
	"manager/common"
	"manager/models"
	"manager/utils"
	"os"
	"path"
	"time"
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
func (this *NewsController) ToAdd() {
	var (
		news models.News
		cate []models.Category
	)

	id, _ := this.GetInt("id", 0)
	o := orm.NewOrm()
	if id != 0 {
		o.QueryTable(new(models.News)).Filter("id", id).RelatedSel().One(&news)
	}
	o.QueryTable(new(models.Category)).Filter("is_active", 0).All(&cate, "id", "name")
	this.Data["news"] = news
	this.Data["cate"] = cate
	this.TplName = "news/news-add.html"
}

func (this *NewsController) DoAdd() {
	var err error
	id, _ := this.GetInt("id")
	tilte := this.GetString("title")
	content := this.GetString("content")
	cate_id, _ := this.GetInt("cate_id", 0)

	cate := models.Category{Id: cate_id}
	news := models.News{
		Title:    tilte,
		Content:  content,
		Category: &cate,
	}
	if id == 0 {
		err = models.NewsSave(&news)
	} else {
		news.Id = id
		err = models.NewsUpdate(&news)
	}
	if err != nil {
		this.Data["json"] = common.ReturnErr(500, "失败！")
	} else {
		this.Data["json"] = common.ReturnOK(200, "成功", nil)
	}
	this.ServeJSON()
}
func (this *NewsController) DoDelete() {
	id, _ := this.GetInt("id")
	news := models.News{Id: id, IsDelete: 1}
	_, err := orm.NewOrm().Update(&news, "is_delete")
	if err != nil {
		this.Data["json"] = common.ReturnErr(500, "操作失败！")
	} else {
		this.Data["json"] = common.ReturnOK(200, "操作成功", nil)
	}
	this.ServeJSON()
}
func (this *NewsController) Upload() {
	var err error
	file, header, err := this.GetFile("file")
	defer file.Close()
	fileDir := "upload/" + time.Now().Format("2006/01/02") + "/"
	os.MkdirAll(fileDir, 777)
	fileName := fileDir + uuid.New().String() + path.Ext(header.Filename)
	err = this.SaveToFile("file", fileName)
	res := make(map[string]interface{})
	if err != nil {
		res["code"] = 500
		res["msg"] = "出现未知错误"
		this.Data["json"] = res
		//this.Data["json"] = common.ReturnErr(500, "出现未知错误！")
	} else {
		res["code"] = 200
		res["link"] = fileName
		this.Data["json"] = res
		//this.Data["json"] = common.ReturnOK(200, "上传成功！", nil)
	}
	this.ServeJSON()
}
