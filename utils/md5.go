package utils

import (
	"crypto/md5"
	"encoding/hex"
	"fmt"
)

func GetMd5File(str string) string {
	return fmt.Sprintf("%x", md5.Sum([]byte(str)))
}
func md5V(str string) string {
	h := md5.New()
	h.Write([]byte(str))
	return hex.EncodeToString(h.Sum(nil))
}
