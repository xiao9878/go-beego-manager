package controllers

import (
	"fmt"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/logs"
	"github.com/astaxie/beego/orm"
	"manager/models"
	"manager/utils"
	"net/http"
)

const (
	IsActiveOK = iota
	IsActiveNO = 1
)

type LoginController struct {
	beego.Controller
}

func (this *LoginController) Get() {
	id, base64, err := utils.GetCaptcha()
	if err != nil {
		logs.Error(fmt.Sprintf("验证码错误，信息：%v", err))
		return
	}
	this.Data["captcha"] = utils.Captcha{Id: id, BS64: base64}
	this.TplName = "login/login.html"
}

func (this *LoginController) ChangCaptcha() {
	message := map[string]interface{}{}
	id, base64, err := utils.GetCaptcha()
	if err != nil {
		message["msg"] = "生成失败！"
		message["code"] = http.StatusServiceUnavailable
		this.Data["json"] = message
	} else {
		message["code"] = http.StatusOK
		message["captcha"] = utils.Captcha{Id: id, BS64: base64}
		this.Data["json"] = message
	}
	this.ServeJSON()
}
func (this *LoginController) Post() {
	username := this.GetString("username")
	password := this.GetString("password")
	captcha := this.GetString("captcha")
	captcha_id := this.GetString("captcha_id")
	is_ok := utils.VerityCaptcha(captcha_id, captcha)

	res := map[string]interface{}{}
	if !is_ok {
		res["code"] = http.StatusBadRequest
		res["msg"] = "验证码错误！"
		this.Data["json"] = res
	} else {
		md5_pwd := utils.GetMd5File(password)
		user_info := models.User{}
		o := orm.NewOrm()
		orm.Debug = true
		is_exist := o.QueryTable(user_info).Filter("user_name", username).Filter("password", md5_pwd).Exist() //.One(&user)
		o.QueryTable(user_info).Filter("user_name", username).Filter("password", md5_pwd).One(&user_info)     //.One(&user)
		if !is_exist {
			res["code"] = http.StatusUnauthorized
			res["msg"] = "用户或密码错误！"
		} else if user_info.IsActive == 1 {
			res["code"] = http.StatusPaymentRequired
			res["msg"] = "用户被禁用！"
		} else {
			this.SetSession("username", username)
			res["code"] = http.StatusOK
			res["msg"] = "登陆成功！"
			logs.Info(fmt.Sprintf("登陆成功，登录信息%x", username))
		}
	}
	this.Data["json"] = res
	this.ServeJSON()
}
