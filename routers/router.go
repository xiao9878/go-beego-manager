package routers

import (
	"github.com/astaxie/beego"
	"manager/controllers/login"
)

func init() {
	beego.Router("/", &login.LoginController{})
}
