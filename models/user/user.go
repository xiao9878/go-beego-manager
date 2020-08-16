package user

import (
	"github.com/astaxie/beego/orm"
	"time"
)

type User struct {
	Id         int       `orm:"pk;auto"`
	UserName   string    `orm:"unique;column(user_name);size(64);description(用户名)"`
	Password   string    `orm:"size(32);description(密码)"`
	Age        int       `orm:"null;description(年龄)"`
	Gender     int       `orm:"null;description(性别)"`
	Phone      string    `orm:"null;description(手机号)"`
	Addr       string    `orm:"null;size(255);description(地址)"`
	IsActive   int       `orm:"default(1);description(1启用/0停用)"`
	IsDelete   int       `orm:"default(0);description(1删除/0未删除)"`
	CreateTime time.Time `orm:"auto_now;type(datetime);description(创建时间);null"`
}

func (u *User) TableName() string {
	return "sys_user"
}

func init() {
	orm.RegisterModel(new(User))
}
