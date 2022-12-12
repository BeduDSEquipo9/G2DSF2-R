"Postwork Sesión 5"

"El data frame iris contiene información recolectada por Anderson sobre 50 flores
de 3 especies distintas (setosa, versicolor y virginca), incluyendo medidas en 
centímetros del largo y ancho del sépalo así como de los pétalos."
"Utiliza 99% de confianza para toda las pruebas, en cada caso realiza el 
planteamiento de hipótesis adecuado y concluye."
str(iris)
df.setosa <- iris[iris$Species == 'setosa',]

"Estudios recientes sobre las mismas especies muestran que:"

"i. En promedio, el largo del sépalo de la especie setosa (Sepal.Length) es igual 
a 5.7 cm"
#Ho: El promedio de largo de sepalo de setosa == 5.7
#Ha: El promedio de largo de sepalo de setosa != 5.7

t.test(x=df.setosa$Sepal.Length, alternative = 'two.sided', mu=5.7)
#t = -13.922, df = 49, p-value < 2.2e-16, para pruebas de dos colas Nivel de significancia/2
# p-value = 2.2e-16 < 0.01
#Si p-value >= significancia -> No Rechazo Ho

#Respuesta:A NC 99% EEE para RECHAZAR la hipótesis nula, 
#El promedio de largo de sepalo de setosa es diferente a 5.7"


"ii. En promedio, el ancho del pétalo de la especie virginica (Petal.Width) es 
menor a 2.1 cm"
#Ho: El promedio de ancho de sepalo de virginica >= 2.1
#Ha: El promedio de ancho de sepalo de virginica < 2.1
df.virginica <- iris[iris$Species == 'virginica',]
t.test(x=df.virginica$Sepal.Width, alternative = 'less', mu=2.1)
#t = 19.163, df = 49, p-value = 1
#p-value = 1 > 0.01
### Toma de decisión: Si p-value >= significancia -> No Rechazo Ho

#Respuesta: A los NC 99% EEE para NO RECHAZAR la hipótesis nula, 
#El promedio de ancho de sepalo de virginica es >= a 2.1"

"iii. En promedio, el largo del pétalo de la especie virgínica es 1.1 cm más 
grande que el promedio del largo del pétalo de la especie versicolor."

var.test(iris[iris$Species == 'virginica', "Sepal.Length"], #primer vector
         iris[iris$Species == 'versicolor', "Sepal.Length"], #segundo grupo
         ratio = 1, alternative = "two.sided") # ratio es la comparación ratio = 1 si son iguales, si son diferentes es un aprueba de dos colas
#F = 1.5176, num df = 49, denom df = 49, p-value = 0.1478
#p-value = 0.1478 > NC estandar, Las varianzas SON IGUALES

# Ho: virginica es mas grande por 1.1 cm o menos que versicolor
# Ha: virginica es 1.1 cm mayor que versicolor
t.test(x = iris[iris$Species == 'virginica', "Sepal.Length"], 
       y = iris[iris$Species == 'versicolor', "Sepal.Length"],
       alternative = "greater", 
       mu = 1.1, var.equal = T)

#t = -3.8679, df = 98, p-value = 0.9999
#p-value = 0.9999 > 0.1
#Para los NC estanadar EEE para NO RECHAZAR la Ho:
#En promedio, el largo del pétalo de la especie virgínica es mas grande que  el de versicolor por 1.1 cm o menos de diferencia


"mu = a number indicating the true value of the mean (or difference in means if you are performing a two sample test)."


"iv. En promedio, no existe diferencia en el ancho del sépalo entre las 3 especies."
#Ho: Ancho de cepalo de setosa = al ancho de sepalo de virginca = AS de versicolor
#Ha: Al menos una es diferente

var.test(iris[iris$Species == 'virginica', "Sepal.Width"], #primer vector
         iris[iris$Species == 'versicolor', "Sepal.Width"], #segundo grupo
         ratio = 1, alternative = "two.sided")
#F = 1.0562, num df = 49, denom df = 49, p-value = 0.849 VARIANZAS Son Iguales
t.test(x = iris[iris$Species == 'virginica', "Sepal.Width"], 
       y = iris[iris$Species == 'versicolor', "Sepal.Width"],
       alternative = "two.sided", 
       mu = mean(df.setosa$Sepal.Width), var.equal = T)
#t = -50.664, df = 98, p-value < 2.2e-16
#p-value < 2.2e-16 < 0.01
#A NC 99% EEE para RECHAZAR la Ho, Si existe diferencia en el ancho de las 3 especies



