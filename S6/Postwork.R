"Supongamos que nuestro trabajo consiste en aconsejar a un cliente sobre
como mejorar las ventas de un producto particular, y el conjunto de datos
con el que disponemos son datos de publicidad que consisten en las ventas
de aquel producto en 200 diferentes mercados, junto con presupuestos de
publicidad para el producto en cada uno de aquellos mercados para tres
medios de comunicación diferentes: TV, radio, y periódico. No es posible
para nuestro cliente incrementar directamente las ventas del producto. Por
otro lado, ellos pueden controlar el gasto en publicidad para cada uno de
los tres medios de comunicación. Por lo tanto, si determinamos que hay una
asociación entre publicidad y ventas, entonces podemos instruir a nuestro
cliente para que ajuste los presupuestos de publicidad, y así
indirectamente incrementar las ventas.

En otras palabras, nuestro objetivo
es desarrollar un modelo preciso que pueda ser usado para predecir las
ventas sobre la base de los tres presupuestos de medios de comunicación. Ajuste modelos de regresión lineal múltiple a
los datos advertisement.csv y elija el modelo más adecuado siguiendo los procedimientos vistos

Considera:
  
Y: Sales (Ventas de un producto)
X1: TV (Presupuesto de publicidad en TV para el producto)
X2: Radio (Presupuesto de publicidad en Radio para el producto)
X3: Newspaper (Presupuesto de publicidad en Periódico para el producto)"


adv <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-06/data/advertising.csv")

library(dplyr)
library(ggplot2)
head(adv)
dim(adv)

attach(adv)
m1 <- lm(Sales ~ TV + Radio + Newspaper)

summary(m1)
#Como el p-value de Newspaper es muy grande entonces no hay evidencia para rechazar que su Beta asociada es = 0, por lo tanto se quita.


m2 <- lm(Sales ~ TV + Radio)

summary(m2)
#Aquí no hay variables dicotómicas entonces no podemos establecer términos de interacción.
#p-value es significativo para el modelo genreal y para los coeficientes individuales
#r2 es 0.9 y es bastante grande.
#Eso concluye que podemos explicar las ventas con base solo en la TV y Radio
#Si aumenta un dolar su presupuesto en TV, sus ventas aumentarán 5%
#Si aumenta un dolar su presupuesto en Radio, sus ventas aumentarán 10%




