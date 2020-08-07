package routers

import (
	"github.com/astaxie/beego"
	"manager/controllers"
)

func init() {
	beego.Router("/", &controllers.MainController{})
}
