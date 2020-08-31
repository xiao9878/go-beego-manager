package models

import (
	"github.com/astaxie/beego/orm"
	"math"
	"time"
)

//分类
//本模块开始换写法，实现控制器和业务的分层

type Category struct {
	Id         int       `orm:"pk;auto"`
	Name       string    `orm:"size(64);description(分类名称)"`
	Desc       string    `orm:"size(64);description(描述)"`
	IsActive   int       `orm:"default(0);description(是否启用0-启用；1-停用)"`
	CreateTime time.Time `orm:"description(创建时间);auto_now"`
	Cate       []*News   `orm:"reverse(many)"`
}

func (this *Category) TableName() string {
	return "sys_cate"
}

func init() {
	orm.RegisterModel(new(Category))
}

func CateList(pageSize, page int, keyword string) (*[]Category, int, int, error) {
	var (
		cates []Category
		err   error
	)
	qs := orm.NewOrm().QueryTable(new(Category))
	if keyword != "" {
		qs = qs.Filter("name__icontains", keyword)
	}
	_, err = qs.Limit(pageSize).Offset((page - 1) * pageSize).All(&cates)
	count, _ := qs.Count()
	if err == orm.ErrNoRows || err == orm.ErrMissPK {
		return nil, 0, 0, err
	}
	countPage := int(math.Ceil(float64(count) / float64(pageSize)))
	return &cates, int(count), countPage, nil
}

func CateSave(cate *Category) error {
	_, err := orm.NewOrm().Insert(cate)
	if err != nil {
		return err
	}
	return nil
}

//更新
func CateUpdate(cate *Category) error {
	_, err := orm.NewOrm().Update(cate, "name", "desc", "is_active")
	return err
}

//删除
func CateDel(id int) error {
	cate := Category{Id: id}
	_, err := orm.NewOrm().Delete(&cate)
	return err
}
