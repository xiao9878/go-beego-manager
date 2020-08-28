package utils

import (
	"github.com/astaxie/beego/context"
	"net/http"
)

func LoginFilter(ctx *context.Context) {
	//获取session
	id := ctx.Input.Session("id")
	if id == nil {
		ctx.Redirect(http.StatusFound, "/")
	}
}
