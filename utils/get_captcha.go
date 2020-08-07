package utils

import (
	"github.com/mojocn/base64Captcha"
	"image/color"
)

type Captcha struct {
	Id   string
	BS64 string
	Code int
}

var store = base64Captcha.DefaultMemStore

func GetCaptcha() (id, base64 string, err error) {
	rgba := color.RGBA{0, 0, 0, 0}
	fonts := []string{"wqy-microhei.ttc"}
	//生成driver，高、宽、划线文字干扰、划线的条数，背景颜色的指针
	driver := base64Captcha.NewDriverMath(50, 140, 0, 0, &rgba, fonts)

	store := base64Captcha.DefaultMemStore
	captcha := base64Captcha.NewCaptcha(driver, store)

	//生成验证码并返回
	return captcha.Generate()
}

func VerityCaptcha(id, base64 string) bool {
	return store.Verify(id, base64, true)
}
