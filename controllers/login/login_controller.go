package login

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/logs"
	"github.com/astaxie/beego/orm"
	"manager/models/user"
	"manager/utils"
	"net/http"
)

type LoginController struct {
	beego.Controller
}

func (this *LoginController) Get() {
	id, base64, err := utils.GetCaptcha()
	if err != nil {
		return
	}
	this.Data["captcha"] = utils.Captcha{Id: id, BS64: base64}
	this.TplName = "login/login.html"
}

func (this *LoginController) ChangCaptcha() {
	message := map[string]interface{}{}
	id, base64, err := utils.GetCaptcha()
	if err != nil {
		message["Msg"] = "生成失败！"
		message["Code"] = http.StatusServiceUnavailable
		this.Data["json"] = message
	} else {
		this.Data["json"] = utils.Captcha{Id: id, BS64: base64, Code: http.StatusOK}
	}
	this.ServeJSON()
}
func (this *LoginController) Post() {
	username := this.GetString("username")
	password := this.GetString("password")
	captcha := this.GetString("captcha")
	captcha_id := this.GetString("captcha_id")
	is_ok := utils.VerityCaptcha(captcha_id, captcha)

	logs.Error(is_ok)
	res := map[string]interface{}{}
	if !is_ok {
		res["code"] = http.StatusBadRequest
		res["msg"] = "验证码错误！"
		this.Data["json"] = res
	} else {
		md5_pwd := utils.GetMd5File(password)
		user := user.User{}
		o := orm.NewOrm()
		orm.Debug = true
		is_exist := o.QueryTable(user).Filter("user_name", username).Filter("password", md5_pwd).Exist() //.One(&user)
		if !is_exist {
			res["code"] = http.StatusUnauthorized
			res["msg"] = "用户或密码错误！"
			this.Data["json"] = res
		} else {
			this.SetSession("username", username)
			res["code"] = http.StatusOK
			res["msg"] = "登陆成功！"
			this.Data["json"] = res
		}
	}
	this.ServeJSON()
}
