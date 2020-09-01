package routers

import (
	"github.com/astaxie/beego"
	"manager/controllers"
)

func init() {
	beego.Router("/", &controllers.LoginController{})
	beego.Router("/log_out", &controllers.LoginController{}, "get:LogOut")
	beego.Router("/test", &controllers.HomeController{}, "post:Test")
	beego.Router("/change_captcha", &controllers.LoginController{}, "get:ChangCaptcha")
	beego.Router("/main/index", &controllers.HomeController{})
	beego.Router("/main/welecome", &controllers.HomeController{}, "get:Welcome")
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
		//个人中心
		beego.NSRouter("person", &controllers.PersonController{}),
	)
	//工资模块
	salary := beego.NewNamespace("main/salary",
		beego.NSRouter("salary", &controllers.SalaryController{}),
		beego.NSRouter("salary_detail", &controllers.SalaryController{}, "get:Detail"),
		beego.NSRouter("finance_list", &controllers.FinanceController{}),
		beego.NSRouter("finance_detail", &controllers.FinanceController{}, "get:Detail"),
		beego.NSRouter("import_salary", &controllers.FinanceController{}, "get:ToImport"),
		beego.NSRouter("import_salary", &controllers.FinanceController{}, "post:DoImport"),
	)
	//财务管理模块
	finance := beego.NewNamespace("main/finance",
		beego.NSRouter("finance_data_list", &controllers.FinanceDataController{}),
		beego.NSRouter("import_finance", &controllers.FinanceDataController{}, "get:ToImport"),
		beego.NSRouter("import_finance", &controllers.FinanceDataController{}, "post:DoImport"),
	)
	//权限菜单模块
	auth := beego.NewNamespace("main/auth",
		beego.NSRouter("/", &controllers.AuthController{}, "get:List"),
		beego.NSRouter("add", &controllers.AuthController{}, "get:ToAdd"),
		beego.NSRouter("add", &controllers.AuthController{}, "post:DoAdd"),
		beego.NSRouter("isActive", &controllers.AuthController{}, "post:IsActive"),
		beego.NSRouter("test", &controllers.AuthController{}, "get:Test"),
	)
	role := beego.NewNamespace("main/role",
		beego.NSRouter("list", &controllers.RoleController{}, "get:List"),
		beego.NSRouter("add", &controllers.RoleController{}, "get:ToAdd"),
		beego.NSRouter("add", &controllers.RoleController{}, "post:DoAdd"),
		beego.NSRouter("to_role_user_add", &controllers.RoleController{}, "get:ToRoleUser"),
		beego.NSRouter("to_role_user_add", &controllers.RoleController{}, "post:DoRoleUser"),
		beego.NSRouter("to_role_auth_add", &controllers.RoleController{}, "get:ToRoleAuth"),
		beego.NSRouter("to_role_auth_add", &controllers.RoleController{}, "post:DoRoleAuth"),
		beego.NSRouter("get-auth-json", &controllers.RoleController{}, "get:GetAuthJson"),
	)
	//内容管理
	news := beego.NewNamespace("main/",
		beego.NSRouter("cate", &controllers.CateController{}),
		beego.NSRouter("cate/is_active", &controllers.CateController{}, "post:IsActive"),
		beego.NSRouter("news", &controllers.NewsController{}),
		beego.NSRouter("cate/add", &controllers.CateController{}, "get:ToAdd"),
		beego.NSRouter("cate/add", &controllers.CateController{}, "Post:DoAdd"),
		beego.NSRouter("cate/del", &controllers.CateController{}, "Post:DoDelete"),
	)
	beego.AddNamespace(main, salary, finance, auth, role, news)
}
