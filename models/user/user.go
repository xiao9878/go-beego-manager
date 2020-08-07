package user

import (
	"github.com/astaxie/beego/orm"
	"os/user"
	"time"
)

type User struct {
	Id         int       `orm:"pk;auto"`
	UserName   string    `orm:"unique;column(username);size(64);description(用户名)"`
	Password   string    `orm:"size(32);description(密码)"`
	Age        int       `orm:"null;description(年龄)"`
	Gender     int       `orm:"null;description(性别)"`
	Phone      int64     `orm:"null;description(手机号)"`
	Addr       string    `orm:"null;size(255);description(地址)"`
	CreateTime time.Time `orm:"auto_now;type(datetime);description(创建时间)"`
}

func TableName() string {
	return "t_user"
}

func init() {
	orm.RegisterModel(new(user.User))
}
