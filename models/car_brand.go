package models

import (
	"github.com/astaxie/beego/orm"
	"math"
	"time"
)

type CarBrand struct {
	Id        int       `orm:"pk;auto"`
	Name      string    `orm:"description(品牌名称);size(64)"`
	Desc      string    `orm:"description(描述);size(255)"`
	Cars      []*Car    `orm:"reverse(many)"`
	IsActive  int       `orm:"description(是否可用，0可用1不可);default(0)"`
	IsDelete  int       `orm:"description(是否删除，0未删);default(0)"`
	CreatedAt time.Time `orm:"description(创建时间);auto_now_add"`
}

func (this *CarBrand) TableName() string {
	return "sys_car_brand"
}

func init() {
	orm.RegisterModel(new(CarBrand))
}

func BrandList(pageSize, page int, keyword string) (*[]CarBrand, int, int, error) {
	var (
		list []CarBrand
		err  error
	)
	qs := orm.NewOrm().QueryTable(new(CarBrand)).Filter("is_delete", 0)
	if keyword != "" {
		qs = qs.Filter("name__icontains", keyword)
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
func (this *CarBrand) Save() error {
	_, err := orm.NewOrm().Insert(this)
	if err != nil {
		return err
	}
	return nil
}

//更新及物理删除
func (this *CarBrand) Update() error {
	_, err := orm.NewOrm().Update(this)
	if err != nil {
		return err
	}
	return nil
}

//物理删除
func (this *CarBrand) Delete() error {
	_, err := orm.NewOrm().Delete(this)
	if err != nil {
		return err
	}
	return nil
}
