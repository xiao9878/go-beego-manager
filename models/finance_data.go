package models

import (
	"github.com/astaxie/beego/orm"
	"time"
)

type FinanceData struct {
	Id              int       `orm:"pk;auto"`
	FinanceDate     string    `orm:"size(62);description(月份)"`
	SalesVolume     float64   `orm:"digits(10);decimals(2);description(销售额)"`
	StudentIncrease int       `orm:"description(学员增加数量)"`
	BootNum         int       `orm:"description(SpringBoot销售数量)"`
	CloudNum        int       `orm:"description(SpringCloud销售数量)"`
	VueNum          int       `orm:"description(Vue销售数量)"`
	ReactNum        int       `orm:"description(React销售数量)"`
	CreateTime      time.Time `orm:"auto_now_add"`
}

func (this *FinanceData) TableName() string {
	return "sys_finance"
}

func init() {
	orm.RegisterModel(new(FinanceData))
}
