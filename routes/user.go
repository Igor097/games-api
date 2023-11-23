package routes

import "github.com/gin-gonic/gin"

func UserRouter(router *gin.Engine) {
  router.GET("/", func(c *gin.Context) {
    c.String(200, "Hello World")
  })

}

