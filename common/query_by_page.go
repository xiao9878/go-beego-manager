package common

import (
	"github.com/astaxie/beego/orm"
	"math"
)

/*
封装分页查询函数
*/
type PageSet struct {
	CurrentPage int
	PageSize    int
	Query       orm.QuerySeter
	Model       interface{}
}

type Result struct {
	List    *[]interface{}
	PageMap map[string]interface{}
}

func GetRes(set PageSet) Result {

	pageSize := set.PageSize
	currentPage := set.CurrentPage
	qs := set.Query
	var result Result
	qs.Limit(set.PageSize).Offset((set.CurrentPage - 1) * set.PageSize).All(&result.List)
	count, _ := qs.Count()

	var firstPage int //前一页地址
	var lastPage int  //后一页地址
	// 根据nums总数，利lpageNum每页数量 生成分页总数
	totalPage := int(math.Ceil(float64(count) / float64(pageSize)))

	if currentPage > totalPage {
		currentPage = totalPage
	}
	if currentPage <= 0 {
		currentPage = 1
	}
	countPage := int(math.Ceil(float64(count) / float64(pageSize)))
	var num_pages []int
	switch {
	case currentPage >= totalPage-5 && totalPage > 5: //最后5页
		start := totalPage - 5 + 1
		//firstPage = currentPage - 1
		firstPage = 1
		lastPage = int(math.Min(float64(totalPage), float64(currentPage+1)))
		num_pages = make([]int, 5)
		for i, _ := range num_pages {
			num_pages[i] = start + i
		}
	case currentPage >= 3 && totalPage > 5:
		start := currentPage - 3 + 1
		num_pages = make([]int, 5)
		firstPage = currentPage - 3
		for i, _ := range num_pages {
			num_pages[i] = start + i
		}
		firstPage = currentPage - 1
		//lastPage = currentPage + 1
		lastPage = countPage
	default:
		num_pages = make([]int, int(math.Min(5, float64(totalPage))))
		for i, _ := range num_pages {
			num_pages[i] = i + 1
		}
		firstPage = int(math.Min(float64(1), float64(currentPage)))
		lastPage = countPage
	}
	prePage := 1
	if currentPage == 1 {
		prePage = currentPage
	} else if currentPage > 1 {
		prePage = currentPage - 1
	}
	nextPage := 1
	if currentPage < countPage {
		nextPage = currentPage + 1
	} else {
		nextPage = currentPage
	}

	pagesMap := make(map[string]interface{})
	//中间的页码数字
	pagesMap["num_pages"] = num_pages
	//总页数
	pagesMap["totalPages"] = totalPage
	//首页
	pagesMap["firstPage"] = firstPage
	//尾页
	pagesMap["lastPage"] = lastPage
	//当前页
	pagesMap["currentPage"] = currentPage
	pagesMap["prePage"] = prePage
	pagesMap["nextPage"] = nextPage
	pagesMap["count"] = count

	result.PageMap = pagesMap

	return result
}
