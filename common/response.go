package common

import (
	"net/http"
)

func ResOk(msg string, data ...interface{}) map[string]interface{} {
	res := make(map[string]interface{})
	res["code"] = http.StatusOK
	if msg == "" {
		res["msg"] = "success"
	}
	if len(data) > 0 {
		res["data"] = data[0]
	}
	return res
}

func ResServerErr(info string) map[string]interface{} {
	res := make(map[string]interface{})
	res["code"] = http.StatusInternalServerError
	if info != "" {
		res["msg"] = "server error"
	}
	return res
}

func ResClientErr(info string) map[string]interface{} {
	res := make(map[string]interface{})
	res["code"] = http.StatusBadRequest
	if info != "" {
		res["msg"] = "client error"
	}
	return res
}
