package main

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	_ "github.com/go-sql-driver/mysql"
	_ "manager/models/user"
	_ "manager/routers"
	"manager/utils"
)

func init() {
	username := beego.AppConfig.String("username")
	pwd := beego.AppConfig.String("pwd")
	host := beego.AppConfig.String("host")
	port := beego.AppConfig.String("port")
	db := beego.AppConfig.String("db")
	orm.RegisterDriver("mysql", orm.DRMySQL)
	orm.RegisterDataBase("default", "mysql", username+":"+pwd+"@tcp("+host+":"+port+")/"+db+"?charset=utf8")
}
func main() {
	orm.RunCommand()

	//未登录的请求
	beego.InsertFilter("/main/*", beego.BeforeRouter, utils.LoginFilter)

	beego.Run()
}
