package models

import (
	"github.com/astaxie/beego/orm"
	"math"
	"time"
)

//车辆申请
type CarApply struct {
	Id           int       `orm:"pk;auto"`
	User         *User     `orm:"rel(fk)"`
	Car          *Car      `orm:"rel(fk)"`
	Reason       string    `orm:"description(理由);size(255)"`
	Destination  string    `orn:"description(目地);size(64)"`
	ReturnTime   time.Time `orm:"description(归还日期);null"`
	ReturnStatus int       `orm:"description(申请状态0待批复1已批复-1已驳回2已完成3超时);default(0)"`
	Option       string    `orm:"description(审批意见);null"`
	IsDelete     int       `orm:"description(是否删除);default(0)"`
	CreatedAt    time.Time `orm:"description(创建时间);auto_now_add"`
}

func (this *CarApply) TableName() string {
	return "sys_car_apply"
}

func init() {
	orm.RegisterModel(new(CarApply))
}

func CarApplyList(pageSize, page int, keyword string, uid int) (*[]CarApply, int, int, error) {
	var (
		list []CarApply
		err  error
	)
	qs := orm.NewOrm().QueryTable(new(CarApply)).RelatedSel().Filter("is_delete", 0).Filter("user_id", uid)
	if keyword != "" {
		qs = qs.Filter("Cars__sys_car__name", keyword)
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
func (this *CarApply) Save() error {
	_, err := orm.NewOrm().Insert(this)
	if err != nil {
		return err
	}
	return nil
}

//更新及物理删除
func (this *CarApply) Update() error {
	_, err := orm.NewOrm().Update(this)
	if err != nil {
		return err
	}
	return nil
}

//物理删除
func (this *CarApply) Delete() error {
	_, err := orm.NewOrm().Delete(this)
	if err != nil {
		return err
	}
	return nil
}
