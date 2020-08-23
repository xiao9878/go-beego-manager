package models

import (
	"github.com/astaxie/beego/orm"
	"time"
)

type Auth struct {
	Id         int       `orm:"pk;auto"`
	AuthName   string    `orm:"description(权限名称);size(64)"`
	UrlFor     string    `orm:"column(urlfor);description(url反转);size(255)"`
	Pid        int       `orm:"description(父级id)"`
	Desc       string    `orm:"description(描述);size(255)"`
	IsActive   int       `orm:"description(是否启用);default(0)"`
	IsDelete   int       `orm:"description(是否删除);default(0)"`
	Weight     int       `orm:"description(权重,数值越大，排序越前)"`
	CreateTime time.Time `orm:"type(datetime);auto_now;description(创建时间)"`
	Role       []*Role   `orm:"reverse(many)"`
}

type Role struct {
	Id         int       `orm:"pk;auto"`
	RoleName   string    `orm:"description(权限名称);size(64)"`
	Desc       string    `orm:"description(描述);size(255)"`
	IsActive   int       `orm:"description(是否启用);default(0)"`
	IsDelete   int       `orm:"description(是否删除);default(0)"`
	CreateTime time.Time `orm:"type(datetime);auto_now_add;description(创建时间)"`
	Auth       []*Auth   `orm:"rel(m2m)"`
	User       []*User   `orm:"rel(m2m)"`
}

func (this *Auth) TableName() string {
	return "sys_auth"
}

func (this *Role) TableName() string {
	return "sys_role"
}

func init() {
	orm.RegisterModel(new(Auth), new(Role))
}
