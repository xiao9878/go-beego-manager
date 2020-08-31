package common

import (
	"net/http"
)

func ResOk(msg string, data ...interface{}) map[string]interface{} {
	res := make(map[string]interface{})
	res["code"] = http.StatusOK
	if msg == "" {
		res["msg"] = "success"
	} else {
		res["msg"] = msg
	}
	if len(data) > 0 {
		res["data"] = data
	}
	return res
}

func ResServerErr(info string) map[string]interface{} {
	res := make(map[string]interface{})
	res["code"] = http.StatusInternalServerError
	if info == "" {
		res["msg"] = "server error"
	} else {
		res["msg"] = info
	}
	return res
}

func ResClientErr(info string) map[string]interface{} {
	res := make(map[string]interface{})
	res["code"] = http.StatusBadRequest
	if info != "" {
		res["msg"] = info
	} else {
		res["msg"] = "client error"
	}
	return res
}
