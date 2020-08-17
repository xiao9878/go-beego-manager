package routers

import (
	"github.com/astaxie/beego"
	"manager/controllers"
	"manager/controllers/auth"
	"manager/controllers/login"
	"manager/controllers/user"
)

func init() {
	beego.Router("/", &login.LoginController{})
	beego.Router("/change_captcha", &login.LoginController{}, "get:ChangCaptcha")
	beego.Router("/main/index", &controllers.HomeController{})
	beego.Router("/main/welcome", &controllers.HomeController{}, "get:Welcome")
	beego.Router("/main/user/list", &user.UserController{}, "get:List")
	beego.Router("/main/user/to_add", &user.UserController{}, "get:ToAdd")
	beego.Router("/main/user/do_add", &user.UserController{}, "post:DoAdd")
	beego.Router("/main/user/is_active", &user.UserController{}, "post:IsActive")
	beego.Router("/main/user/delete", &user.UserController{}, "post:Delete")
	beego.Router("/main/user/resetpwd", &user.UserController{}, "post:ResetPassword")
	beego.Router("/main/user/edit", &user.UserController{}, "get:ToUpdate")
	beego.Router("/main/user/delall", &user.UserController{}, "post:MuliDel")
	auth := beego.NewNamespace("main/user",
		beego.NSRouter("auth/list", &auth.AuthController{}, "get:List"))
	beego.AddNamespace(auth)
}
