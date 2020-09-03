package models

import (
	"github.com/astaxie/beego/orm"
	"time"
)

type Notice struct {
	Id          int       `orm:"pk;auto"`
	Title       string    `orm:"description(标题);size(65)"`
	Flag        int       `orm:"description(通知类型)"`
	Content     string    `orm:"description(内容)"`
	User        *User     `orm:"description(用户外键);rel(fk)"`
	Tag         int       `orm:"description(读状态（1已读0未读）);default(0)"`
	CreatedTime time.Time `orm:"description(创建时间)"`
}

func (this *Notice) TableName() string {
	return "sys_notice"
}
func init() {
	orm.RegisterModel(new(Notice))
}
