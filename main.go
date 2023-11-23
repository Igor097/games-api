package main

import (
	"github.com/Igor097/games-api/routes"
	"github.com/gin-gonic/gin"
)

func main() {
  router := gin.New()
  routes.UserRouter(router)

  router.Run(":8080")
}

