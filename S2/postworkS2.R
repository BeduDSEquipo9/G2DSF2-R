# Postwork Sesión 2.

# Desarrollo
#Libs 
library(dplyr)
library(ggplot2)
# 1) Inspecciona el DataSet iris_meaniris` disponible directamente en R. Identifica las variables que contiene y su tipo, asegúrate de que no hayan datos faltantes y que los datos se encuentran listos para usarse.

class(iris)#Id tipo de dato
str(iris);#ver estructura
head(iris);#Encabezado

dim(iris);
View(iris);

complete.cases(iris)
sum(complete.cases(iris))

# 2) Crea una gráfica de puntos que contenga `Sepal.Lenght` en el eje horizontal, `Sepal.Width` en el eje vertical, que identifique `Species` por color y que el tamaño de la figura está representado por `Petal.Width`. Asegúrate de que la geometría contenga `shape = 10` y `alpha = 0.5`.
?ggplot
?geom_point
?theme_light()

graficaIdSpeciesxColorTamanoSepalPetal <- ggplot(iris, aes(x = Sepal.Length, 
                      y = Sepal.Width, 
                      color = Species, 
                      size = Petal.Width
                      )
            ) +  geom_point(shape = 10, alpha = 0.5);

graficaIdSpeciesxColorTamanoSepalPetal;

# 3) Crea una tabla llamada `iris_mean` que contenga el promedio de todas las variables agrupadas por `Species`.
iris_mean <- iris %>% group_by(Species) %>% summarize_all(mean)  

class(iris_mean)#Id tipo de dato
str(iris_mean);#ver estructura
head(iris_mean);#Encabezado

dim(iris_mean);
View(iris_mean);

# 4) Con esta tabla, agrega a tu gráfica anterior otra geometría de puntos para agregar los promedios en la visualización. Asegúrate que el primer argumento de la geometría sea el nombre de tu tabla y que los parámetros sean `shape = 23`, `size = 4`, `fill = "black"` y `stroke = 2`. También agrega etiquetas, temas y los cambios necesarios para mejorar tu visualización.
graf2 <- graficaIdSpeciesxColorTamanoSepalPetal +
        geom_point(
          data = iris_mean, #primer argumento de la geometría sea el nombre de tu tabla
          shape = 23, #`shape = 23`
          size = 4, #`size = 4`
          fill = "black", #`fill = 'black'`
          stroke = 2 #`stroke = 2`
          ) + labs(title = "Iris con Iris Mean",
                   x = "Largo Sepalo",
                   y = "Ancho Sepalo"
                   ) +   theme_light()
graf2
