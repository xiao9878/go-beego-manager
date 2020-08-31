package models

import "github.com/astaxie/beego/orm"

type News struct {
	Id       int       `orm:"pk;auto"`
	Title    string    `orm:"size(256);description(新闻标题)"`
	Content  string    `orm:"type(text);description(新闻内容)"`
	IsDelete int       `orm:"default(0);description(是否删除0-未删除；1-删除)"`
	Category *Category `orm:"rel(fk)"`
}

func (this *News) TableName() string {
	return "sys_news"
}

func init() {
	orm.RegisterModel(new(News))
}
