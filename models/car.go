package models

import (
	"github.com/astaxie/beego/orm"
	"math"
	"time"
)

type Car struct {
	Id         int         `orm:"pk;auto"`
	Name       string      `orm:"description(品牌名称);size(64)"`
	CarBrand   *CarBrand   `orm:"rel(fk)"`
	CarApply   []*CarApply `orm:"reverse(many);null"`
	Desc       string      `orm:"description(描述);size(255)"`
	Status     int         `orm:"description(是否借出，0未借出);default(0)"`
	IsActive   int         `orm:"description(是否可用，0可用1不可);default(0)"`
	IsDelete   int         `orm:"description(是否删除，0未删);default(0)"`
	CreateTime time.Time   `orm:"description(创建时间);auto_now_add"`
}

func (this *Car) TableName() string {
	return "sys_car"
}

func init() {
	orm.RegisterModel(new(Car))
}

//车辆列表
func CarList(pageSize, page int, keyword string, args ...string) (*[]Car, int, int, error) {
	var (
		list []Car
		err  error
	)
	qs := orm.NewOrm().QueryTable(new(Car)).RelatedSel().Filter("is_delete", 0)
	if keyword != "" {
		qs = qs.Filter("name__icontains", keyword)
	}
	if len(args) > 0 {
		for _, arg := range args {
			switch arg {
			case "status":
				qs = qs.Filter("status", 0)
			}
		}
		qs = qs.Filter("is_active", 0)
	}
	_, err = qs.Limit(pageSize).Offset((page - 1) * pageSize).All(&list)
	count, _ := qs.Count()
	if err == orm.ErrNoRows || err == orm.ErrMissPK {
		return nil, 0, 0, err
	}
	countPage := int(math.Ceil(float64(count) / float64(pageSize)))
	return &list, int(count), countPage, nil
}

//新增
func (this *Car) Save() error {
	_, err := orm.NewOrm().Insert(this)
	if err != nil {
		return err
	}
	return nil
}

//更新及物理删除
func (this *Car) Update() error {
	_, err := orm.NewOrm().Update(this)
	if err != nil {
		return err
	}
	return nil
}

//物理删除
func (this *Car) Delete() error {
	_, err := orm.NewOrm().Delete(this)
	if err != nil {
		return err
	}
	return nil
}
