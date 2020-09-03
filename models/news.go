package models

import (
	"github.com/astaxie/beego/orm"
	"math"
	"time"
)

type News struct {
	Id         int       `orm:"pk;auto"`
	Title      string    `orm:"size(256);description(新闻标题)"`
	Content    string    `orm:"type(text);description(新闻内容)"`
	IsDelete   int       `orm:"default(0);description(是否删除0-未删除；1-删除)"`
	CreateTime time.Time `orm:"description(创建时间);auto_now"`
	Category   *Category `orm:"rel(fk)"`
}

func (this *News) TableName() string {
	return "sys_news"
}

func init() {
	orm.RegisterModel(new(News))
}

func NewsList(pageSize, page int, keyword string) (*[]News, int, int, error) {
	var (
		news []News
		err  error
	)
	qs := orm.NewOrm().QueryTable(new(News)).Filter("is_delete", 0).OrderBy("-create_time")
	if keyword != "" {
		qs = qs.Filter("name__icontains", keyword)
	}
	_, err = qs.Limit(pageSize).Offset((page - 1) * pageSize).RelatedSel().All(&news)
	count, _ := qs.Count()
	if err == orm.ErrNoRows || err == orm.ErrMissPK {
		return nil, 0, 0, err
	}
	countPage := int(math.Ceil(float64(count) / float64(pageSize)))
	return &news, int(count), countPage, nil
}
func GetNews(id int) (*News, error) {
	var news News
	o := orm.NewOrm()
	err := o.QueryTable(new(News)).Filter("id", id).Filter("is_delete", 0).RelatedSel().One(&news)
	return &news, err
}

//新增
func NewsSave(news *News) error {
	_, err := orm.NewOrm().Insert(news)
	if err != nil {
		return err
	}
	return nil
}

//更新
func NewsUpdate(news *News) error {
	_, err := orm.NewOrm().Update(news, "title", "content", "category_id")
	return err
}

//删除
func NewsDel(id int) error {
	_, err := orm.NewOrm().QueryTable(new(News)).Filter("id", id).Update(orm.Params{"is_delete": 1})
	return err
}
