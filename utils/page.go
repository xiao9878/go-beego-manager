package utils

import "math"

//分页算法，当前页、每页数、总数
func Paginator(currentPage, pageSize int, count int64) map[string]interface{} {
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
	return pagesMap
}
