package common

import "net/http"

//type Res struct {
//	res map[string]interface{}
//}

func SuccessRes(info string, data ...interface{}) map[string]interface{} {
	res := make(map[string]interface{})
	res["code"] = http.StatusOK
	if info != "" {
		res["msg"] = "success"
	}
	if len(data) > 0 {
		res["data"] = data
	}
	return res
}

func ErrorRes(info string, data ...interface{}) map[string]interface{} {
	res := make(map[string]interface{})
	res["code"] = http.StatusInternalServerError
	if info != "" {
		res["msg"] = "error"
	}
	if len(data) > 0 {
		res["data"] = data
	}
	return res
}

func MethodNotAllowRes(info string, data ...interface{}) map[string]interface{} {
	res := make(map[string]interface{})
	res["code"] = http.StatusNotAcceptable
	if info != "" {
		res["msg"] = "fail"
	}
	if len(data) > 0 {
		res["data"] = data
	}
	return res
}
