package routers

import (
	"github.com/astaxie/beego"
	"manager/controllers"
)

func init() {
	beego.Router("/", &controllers.LoginController{})
	beego.Router("/test", &controllers.HomeController{}, "post:Test")
	beego.Router("/change_captcha", &controllers.LoginController{}, "get:ChangCaptcha")
	beego.Router("/main/index", &controllers.HomeController{})
	//用户模块
	main := beego.NewNamespace("main/user",
		beego.NSRouter("list", &controllers.UserController{}, "get:List"),
		beego.NSRouter("to_add", &controllers.UserController{}, "get:ToAdd"),
		beego.NSRouter("do_add", &controllers.UserController{}, "post:DoAdd"),
		beego.NSRouter("is_active", &controllers.UserController{}, "post:IsActive"),
		beego.NSRouter("delete", &controllers.UserController{}, "post:Delete"),
		beego.NSRouter("resetpwd", &controllers.UserController{}, "post:ResetPassword"),
		beego.NSRouter("edit", &controllers.UserController{}, "get:ToUpdate"),
		beego.NSRouter("delall", &controllers.UserController{}, "post:MuliDel"),
	)
	beego.AddNamespace(main)
	//权限菜单模块
	auth := beego.NewNamespace("main/auth",
		beego.NSRouter("/", &controllers.AuthController{}, "get:List"),
		beego.NSRouter("add", &controllers.AuthController{}, "get:ToAdd"),
		beego.NSRouter("add", &controllers.AuthController{}, "post:DoAdd"),
		beego.NSRouter("isActive", &controllers.AuthController{}, "post:IsActive"),
		beego.NSRouter("test", &controllers.AuthController{}, "get:Test"),
	)
	beego.AddNamespace(auth)
	role := beego.NewNamespace("main/role",
		beego.NSRouter("list", &controllers.RoleController{}, "get:List"),
		beego.NSRouter("add", &controllers.RoleController{}, "get:ToAdd"),
		beego.NSRouter("add", &controllers.RoleController{}, "post:DoAdd"),
		beego.NSRouter("to_role_user_add", &controllers.RoleController{}, "get:ToRoleUser"),
	)
	beego.AddNamespace(role)
}
