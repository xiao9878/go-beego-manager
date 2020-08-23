package common

import (
	"manager/models"
	"sort"
)

//菜单算法，将菜单整理成树形结构
func TreeMenu(auths *[]models.Auth) *[]models.Menu {
	var treeMenu []models.Menu
	//1.查询出所有的顶级菜单，并添加到菜单项
	for _, data := range *auths {
		if data.Pid == 0 {
			m := models.Menu{Id: data.Id, AuthName: data.AuthName, UrlFor: data.UrlFor, Weight: data.Weight, Children: nil}
			treeMenu = append(treeMenu, m)
		}
	}
	//2.找到顶级菜单的子菜单
	for _, menu := range treeMenu {
		menu.Children = GetChilds(&menu, auths)
		treeMenu = append(treeMenu, menu)
	}
	treeMenu = treeMenu[len(treeMenu)/2 : len(treeMenu)]
	sort.Slice(treeMenu, func(i, j int) bool {
		return treeMenu[i].Weight < treeMenu[j].Weight
	})
	return &treeMenu
}

func GetChilds(node *models.Menu, all *[]models.Auth) []*models.Menu {
	var menuSlice []*models.Menu
	for _, data := range *all {
		if data.Pid == node.Id {
			m := models.Menu{Id: data.Id, AuthName: data.AuthName, UrlFor: data.UrlFor, Weight: data.Weight, Children: nil}
			m.Children = GetChilds(&m, all)
			menuSlice = append(menuSlice, &m)
		}
	}
	node.Children = menuSlice
	sort.Slice(menuSlice, func(i, j int) bool {
		return menuSlice[i].Weight < menuSlice[j].Weight
	})
	return menuSlice
}
