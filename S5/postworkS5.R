# Postwork Sesión 5

#### OBJETIVO

"- Realizar inferencia estadística para extraer información de la muestra que 
sea contrastable con la población"

##### DESARROLLO

"El data frame iris contiene información recolectada por Anderson sobre 50 
flores de 3 especies distintas (setosa, versicolor y virginca), incluyendo 
medidas en centímetros del largo y ancho del sépalo así como de los pétalos."


"Estudios recientes sobre las mismas especies muestran que:

- 1) En promedio, el largo del sépalo de la especie setosa (Sepal.Length) es 
igual a 5.7 cm
- 2) En promedio, el ancho del pétalo de la especie virginica (Petal.Width) es 
menor a 2.1 cm
- 3) En promedio, el largo del pétalo de la especie virgínica es 1.1 cm más 
grande que el promedio del largo del pétalo de la especie versicolor.
- 4) En promedio, no existe diferencia en el ancho del sépalo entre las 3 
especies.

Utilizando pruebas de inferencia estadística, concluye si existe evidencia 
suficiente para concluir que los datos recolectados por Anderson están en línea 
con los nuevos estudios.

Utiliza 99% de confianza para toda las pruebas, en cada caso realiza el 
planteamiento de hipótesis adecuado y concluye."
"1) En promedio, el largo del sépalo de la especie setosa (Sepal.Length) es 
igual a 5.7 cm"
"Planteamiento de hipótesis:
Ho: prom_Sepal.Lengths(setosa) == 5.7
Ha: prom_Sepal.Length(setosa) =! 5.7"

t.test(iris[iris$Species == 'setosa',
            "Sepal.Length"],
       alternative = 'two.sided', mu=5.7)

"2) En promedio, el ancho del pétalo de la especie virginica (Petal.Width) es 
menor a 2.1 cm"
"Planteamiento de hipótesis:
Ho: prom_Petal.Width(virginica) >= 5.7
Ha: prom_Petal.Width(virginica) < 5.7"

t.test(iris[iris$Species == 'virginica', 
            "Petal.Width"],
       alternative = 'less', mu=2.1)

"3) En promedio, el largo del pétalo de la especie virgínica es 1.1 cm más 
grande que el promedio del largo del pétalo de la especie versicolor."
"Planteamiento de hipótesis:
Ho: prom_Petal.Length >= 1.1
Ha: prom_Petal.Length < 1.1"
var.test(iris[iris$Species == "virginica", "Petal.Length"],
         iris[iris$Species == "versicolor", "Petal.Length"],
         ratio = 1, alternative = "two.sided")

t.test(x=iris[iris$Species == "virginica", "Petal.Length"],
       y=iris[iris$Species == "versicolor", "Petal.Length"],
       alternative = "greater", mu = 1.1, var.equal = TRUE)


"4) En promedio, no existe diferencia en el ancho del sépalo entre las 3 
especies"
library(dplyr);
summary(iris)
str(iris)
iris_mean.1<-iris %>% group_by(Species) %>% summarise(Sepal.Length = mean(Sepal.Length),
                                                      Sepal.Width = mean(Sepal.Width),
                                                      Petal.Length = mean(Petal.Length),
                                                      Petal.Width = mean(Petal.Width), n = n())  
iris_mean.1
"El análisis de varianza (de un factor) nos permite comparar la media de una 
variable considerando dos o más niveles/grupos de factor. Entre muchas otras 
aplicaciones del ANOVA, esta técnica puede emplearse como una extensión de la 
prueba t de Student."
"Planteamiento de hipótesis:
Ho: prom_Sepal.Width(virginica) ==  prom_Sepal.Width(versicolor) == prom_Sepal.Width(setosa ) 
Ha: prom_Sepal.Width =! Al menos uno es diff"

library(ggplot2)
summary(iris)
str(iris)

boxplot(log(iris$Sepal.Width))
boxplot(log(iris$Sepal.Width), data = iris)
boxplot(log(iris$Sepal.Width) ~ Species, data = iris)
#Sin Log
anova <- aov(log(iris$Sepal.Width) ~ Species,data = iris)
summary(anova)

boxplot(Sepal.Width ~ Species, data = iris)
anova <- aov(Sepal.Width ~ Species, data = iris)
summary(anova)

