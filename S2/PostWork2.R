# Postwork Sesión 2.

#### Objetivo

"- Conocer algunas de las bases de datos disponibles en `R`
- Observar algunas características y manipular los DataFrames con `dplyr`
- Realizar visualizaciones con `ggplot`
#### Requisitos

1. Tener instalado R y RStudio
2. Haber realizado el prework y estudiado los ejemplos de la sesión."

#### Desarrollo

#1 Inspeccionar el DataFrame
str(iris)
head(iris)

#2 Gráfica de puntos
g <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species, size = Petal.Width)) + 
  geom_point(shape = 10, alpha = 0.5)
g

#3 Media de todas las variables por especie
iris_mean <- iris %>% group_by(Species) %>% summarize_all(mean)  

#4 Agregar gráfica de puntos con los promedios de Sepal.Width y Sepal.Lenght
g <- g + geom_point(data = iris_mean, shape = 23, size = 4, fill = "black", stroke = 2) +
  labs(title = "Iris Data",
       x = "Sepal Length",
       y = "Sepal Width") +
  scale_size("Petal Width") +
  theme_classic()
g
