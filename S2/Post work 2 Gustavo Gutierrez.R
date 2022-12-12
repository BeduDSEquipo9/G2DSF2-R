# Postwork Sesión 2.

#### Objetivo

"- Conocer algunas de las bases de datos disponibles en `R`
- Observar algunas características y manipular los DataFrames con `dplyr`
- Realizar visualizaciones con `ggplot`
#### Requisitos

1. Tener instalado R y RStudio
2. Haber realizado el prework y estudiado los ejemplos de la sesión."

#### Desarrollo

"1) Inspecciona el DataSet iris disponible directamente en la librería de ggplot. 
Identifica las variables que contiene y su tipo, asegúrate de que no hayan datos 
faltantes y que los datos se encuentran listos para usarse."

library(dplyr)
library(ggplot2)

iris
str(iris)
#Tipos de variables:
"'data.frame':	150 obs. of  5 variables:
 $ Sepal.Length: num  
 $ Sepal.Width : num  
 $ Petal.Length: num  
 $ Petal.Width : num  
 $ Species     : Factor w/ 3 levels"

dim(iris)
#Comprobar datos completos opción 1. Que la cantidad de casos sea igual al total
complete.cases(iris)
sum(complete.cases(iris))
#Comprobar datos completos opción 2:
any(is.na(iris))

"2) Crea una gráfica de puntos que contenga `Sepal.Lenght` en el eje horizontal, 
`Sepal.Width` en el eje vertical, que identifique `Species` por color y que el 
tamaño de la figura está representado por `Petal.Width`. 
Asegúrate de que la geometría contenga `shape = 10` y `alpha = 0.5`."

iris_plot <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species, size = Petal.Width )) +
         geom_point(shape = 10, alpha = 0.5)
iris_plot

"3) Crea una tabla llamada `iris_mean` que contenga el promedio de todas las 
variables agrupadas por `Species`."


iris_mean <- iris %>% 
            group_by(Species) %>% 
            summarize_all(mean)
iris_mean

"4) Con esta tabla, agrega a tu gráfica anterior otra geometría de puntos para 
agregar los promedios en la visualización. Asegúrate que el primer argumento de
la geometría sea el nombre de tu tabla y que los parámetros sean `shape = 23`, 
`size = 4`, `fill = 'black'` y `stroke = 2`. También agrega etiquetas, temas y 
los cambios necesarios para mejorar tu visualización."

iris_means_plot <- iris_plot + geom_point(data = iris_mean, shape = 23, size = 4, fill = "black", stroke = 2) +
  labs(title = "Iris", x = "Sepal Length", y = "Sepal Width")+
  theme_classic()

iris_means_plot

