package models

import (
	"github.com/astaxie/beego/orm"
	"time"
)

type Salary struct {
	Id        int       `orm:"pk;auto"`
	CardId    string    `orm:"size(64);null;description(工号)"`
	Salary    float64   `orm:"description(基本工资);null;digits(10);decimals(2)"`
	WorkDay   float64   `orm:"description(工作天数);null;digits(10);decimals(2)"`
	OffDay    float64   `orm:"description(请假天数);null;digits(10);decimals(2)"`
	RestDay   float64   `orm:"description(调休天数);null;digits(10);decimals(2)"`
	Reward    float64   `orm:"description(奖金);null;digits(10);decimals(2)"`
	Perk      float64   `orm:"description(补贴);null;digits(10);decimals(2)"`
	Social    float64   `orm:"description(社保);null;digits(10);decimals(2)"`
	Tax       float64   `orm:"description(税);null;digits(10);decimals(2)"`
	Fine      float64   `orm:"description(罚金);null;digits(10);decimals(2)"`
	NetSalary float64   `orm:"description(实发);null;digits(10);decimals(2)"`
	PayDate   string    `orm:"null;description(工资月份)"`
	CreatTime time.Time `orm:"type(date);auto_now_add"`
}

func (this *Salary) TableName() string {
	return "sys_salary"
}

func init() {
	orm.RegisterModel(new(Salary))
}
