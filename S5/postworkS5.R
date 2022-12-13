###########################
# Postwork sesión 5
# Christian Millán
##########################

"
Postwork Sesión 5

OBJETIVO

Realizar inferencia estadística para extraer información de la muestra que sea contrastable con la población
REQUISITOS

Haber desarrollado los postworks anteriores
Cubrir los temas del prework
Replicar los ejemplos de la sesión
DESARROLLO

El data frame iris contiene información recolectada por Anderson sobre 50 flores de 3 especies distintas (setosa, versicolor y virginca), incluyendo medidas en centímetros del largo y ancho del sépalo así como de los pétalos.

Estudios recientes sobre las mismas especies muestran que:

En promedio, el largo del sépalo de la especie setosa (Sepal.Length) es igual a 5.7 cm
En promedio, el ancho del pétalo de la especie virginica (Petal.Width) es menor a 2.1 cm
En promedio, el largo del pétalo de la especie virgínica es 1.1 cm más grande que el promedio del largo del pétalo de la especie versicolor.
En promedio, no existe diferencia en el ancho del sépalo entre las 3 especies.
Utilizando pruebas de inferencia estadística, concluye si existe evidencia suficiente para concluir que los datos recolectados por Anderson están en línea con los nuevos estudios.

Utiliza 99% de confianza para toda las pruebas, en cada caso realiza el planteamiento de hipótesis adecuado y concluye.
"
library(ggplot2)
str(iris)
summary(iris)
View(iris)

# En promedio, el largo del sépalo de la especie setosa (Sepal.Length) es igual a 5.7 cm
# Ho: mu = 5.7
# Ha: mu != 5.7

t.test(x = iris[iris$Species == 'setosa', 'Sepal.Length'], alternative = 'two.sided', mu = 5.7 ) # 2.2e-16
# Nivel de significancia es de  0.01
# p-value = 2.2e-16 < 0.01
# A nivel de confianza estándar 99%, existe evidencia estadística para
# rechzar Ho, es decir, el promedio  es DISTINTO de 5.7

#En promedio, el ancho del pétalo de la especie virginica (Petal.Width) es menor a 2.1 cm
# Ho: mu >= 2.1
# Ha: mu < 2.1

t.test(x = iris[iris$Species == 'virginica', 'Petal.Width'], alternative = 'less', mu = 2.1 ) #  0.03132
# Nivel de significancia es de  0.01
# p-value =  0.03132 > 0.01
# A nivel de confianza estándar 99%, no existe evidencia estadística para
# rechazar Ho, es decir, el promedio no es menor a 2.1

#En promedio, el largo del pétalo de la especie virgínica es 1.1 cm más grande 
#que el promedio del largo del pétalo de la especie versicolor.

#Planteamiento de hipótesis:
# Ho: prom_Petal.Length_virginica <= prom_Petal.Length_versicolor 
# Ha: prom_Petal.Length_virginica > prom_Petal.Length_versicolor
df <- iris
var.test(df[df$Species == "virginica", "Petal.Length"],
         df[df$Species == "versicolor", "Petal.Length"],
         ratio = 1, alternative = "two.sided")
# El p-value 0.2637 > 0.01 Las varianzas son iguales
t.test(x = df[df$Species == "virginica", "Petal.Length"], 
       y = df[df$Species == "versicolor", "Petal.Length"],
       alternative = "greater",
       mu = 1.1,  var.equal = TRUE)
# Nivel de significancia es de  0.01
# p-value =  0.03202 > 0.01
# A nivel de confianza estándar 99%, no EEE para rechazar Ho, es decir,
# en promedio, el largo del pétalo de la especie virgínica  no es 1.1 cm más grande 
#que el promedio del largo del pétalo de la especie versicolor.

# En promedio, no existe diferencia en el ancho del sépalo entre las 3 especies.

# Ho: prom_Petal.Width_virginica = prom_Petal.Width_versicolor = prom_Petal.Width_setosa 
# Ha: AL menos uno es diferente

anova <- aov(Petal.Width ~ Species,
             data = iris)

summary(anova)
#Nivel de significancia es de  0.01
# p-value =  0.26372e-16 > 0.01
# A nivel de confianza estándar 99%, no EEE para rechazar Ho, es decir,
# en promedio,no existe diferencia en el ancho del sépalo entre las 3 especies..

