"Postwork Sesión 5

OBJETIVO
Realizar inferencia estadística para extraer información de la muestra que sea 
contrastable con la población

REQUISITOS
Haber desarrollado los postworks anteriores
Cubrir los temas del prework
Replicar los ejemplos de la sesión

DESARROLLO"

"El data frame iris contiene información recolectada por Anderson sobre 
50 flores de 3 especies distintas (setosa, versicolor y virginca),
incluyendo medidas en centímetros del largo y ancho del sépalo así como de los pétalos."

#Estudios recientes sobre las mismas especies muestran que:

summary(iris)

View(iris)

df <- iris


#Ejericio 1. En promedio, el largo del sépalo de la especie setosa (Sepal.Length) es igual a 5.7 cm

"Planteamiento de hipótesis:"
# Ho: mu=5.7
# H1: mu!=5.7 #Prueba de dos colas



t.test(x=df[df$Species == 'setosa', "Sepal.Length"],alternative='two.sided', mu=5.7)


# Nivel de Significancia = 0.01 -> 0.01/2 = 0.005


#Conclusión

"A nivel de confianza del 99%, existe evidencia estadística para rechazar Ho, es decir,
en promedio el largo del sépalo de la especie setosa no es igual a 5.7 cm"

#Ejercicio2. En promedio, el ancho del pétalo de la especie virginica (Petal.Width) es menor a 2.1 cm


"Planteamiento de Hipotesis"

# Ho: mu >= 2.1
# Ha: mu < 2.1 # Cola Inferior


t.test(x=df[df$Species == 'virginica', "Petal.Width"],alternative='less', mu=2.1)


0.03132>=0.01

# Conclusión

"A nivel de confianza del 99%, no existe evidencia estadística para rechazar Ho, es decir,
# En promedio el ancho del petalo de la especie Virginica no es menor a 2.1 cm."


#Ejercicio 3.
#En promedio, el largo del pétalo de la especie virgínica es 1.1 cm más grande que 
# el promedio del largo del pétalo de la especie versicolor.


#prueba de varianzas

#Ho: razon = 1
#H1: razon != 1 

var.test(df[df$Species=="virginica", "Petal.Length"],
         df[df$Species=="versicolor", "Petal.Length"], 
         ratio = 1, alternative = "two.sided")       #Demuestra si las varianzas son iguales o diferentes

0.2637>=0.01

"Planteamiento de hipótesis:#


Ho: prom_Petal.Length = 2.1
Ha: prom_Petal.Length != 2.1"


t.test(x = df[df$Species=="virginica", "Petal.Length"], 
       y=df[df$Species=="versicolor", "Petal.Length"],
       alternative = "greater", mu=1.1, var.equal = TRUE)

0.03202>=0.01

"A Nivel de confianza del 99%, No Existe Evidencia Estadistica para rechazar Ho, es decir
en promedio el largo del pétalo de la especie virgínica es 1.1 cm más grande que 
el promedio del largo del pétalo de la especie versicolor."

#Ejercicio 4

#En promedio, no existe diferencia en el ancho del sépalo entre las 3 especies


#Planteamiento de la Hipotesis

"ho:prom_sepal_with_setosa = prom_sepal_with_versicolor = prom_sepal_with_virginica 
h1:Alguna especie es diferente"

library(ggplot2)
str(df)

boxplot(log(df$Sepal.Width))

boxplot(log(Sepal.Width) ~ Species,
        data = df)

anova <- aov(log(Sepal.Width) ~ Species,
             data = df)

#Conclusión 



#Utilizando pruebas de inferencia estadística, concluye si existe evidencia suficiente para concluir que los datos recolectados por Anderson están en línea con los nuevos estudios.

#Utiliza 99% de confianza para toda las pruebas, en cada caso realiza el planteamiento de hipótesis adecuado y concluye.