package common

type Res struct {
	Code int         `json:"code"`
	Msg  string      `json:"msg"`
	Data interface{} `json:"data"`
}

func ReturnOK(code int, msg string, data interface{}) *Res {
	return &Res{Code: code, Msg: msg, Data: data}
}
func ReturnErr(code int, msg string) *Res {
	return &Res{Code: code, Msg: msg, Data: nil}
}
