package main

import (
	"fmt"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/logs"
	"github.com/astaxie/beego/orm"
	_ "github.com/go-sql-driver/mysql"
	_ "manager/models"
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
	orm.RegisterDataBase("default", "mysql", username+":"+pwd+"@tcp("+host+":"+port+")/"+db+"?charset=utf8&loc=Local")

	logs.Info(fmt.Sprintf("连接数据库成功！连接信息：host:%s|port:%s|db:%s", host, port, db))
}

//go:generate sh -c "echo 'package routers; import \"github.com/astaxie/beego\"; func init() {beego.BConfig.RunMode = beego.DEV}' > routers/0.go"
//go:generate sh -c "echo 'package routers; import \"os\"; func init() {os.Exit(0)}' > routers/z.go"
//go:generate go run $GOFILE
//go:generate sh -c "rm routers/0.go routers/z.go"
func main() {
	orm.RunCommand()

	//未登录的请求
	beego.InsertFilter("/main/*", beego.BeforeRouter, utils.LoginFilter)
	//日志
	//logs.SetLogger(logs.AdapterMultiFile, `{"filename":"logs/log.log","separate":"["err","info"]"}`)
	beego.SetStaticPath("/upload", "upload")
	beego.SetStaticPath("main/news/upload", "upload")
	beego.Run()
}
