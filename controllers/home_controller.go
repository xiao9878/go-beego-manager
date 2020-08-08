package controllers

import "github.com/astaxie/beego"

type HomeController struct {
	beego.Controller
}

func (this *HomeController) Get() {
	//后端首页
	this.TplName = "index.html"
}

func (this *HomeController) Welcome() {
	this.TplName = "welcome.html"
}
