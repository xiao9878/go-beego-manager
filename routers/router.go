package routers

import (
	"github.com/astaxie/beego"
	"manager/controllers"
	"manager/controllers/login"
	"manager/controllers/user"
)

func init() {
	beego.Router("/", &login.LoginController{})
	beego.Router("/change_captcha", &login.LoginController{}, "get:ChangCaptcha")
	beego.Router("/main/user", &user.UserController{})
	beego.Router("/main/index", &controllers.HomeController{})
	beego.Router("/main/welcome", &controllers.HomeController{}, "get:Welcome")
}
