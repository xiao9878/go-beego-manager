package auth

type Menu struct {
	Id       int
	AuthName string
	UrlFor   string
	Weight   int
	Children []*Menu
}
