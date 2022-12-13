# Postwork S6

# Desarrollo

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
ventas sobre la base de los tres presupuestos de medios de comunicación. Ajuste
modelos de regresión lineal múltiple a los datos advertisement.csv y elija el
modelo más adecuado siguiendo los procedimientos vistos

Considera:
  
  - Y: Sales (Ventas de un producto)
- X1: TV (Presupuesto de publicidad en TV para el producto)
- X2: Radio (Presupuesto de publicidad en Radio para el producto)
- X3: Newspaper (Presupuesto de publicidad en Periódico para el producto)"

# Desarrollo

"Analisis de datos"
df <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-06/data/advertising.csv")
class(df)   #Id tipo de dato
str(df);    #Identificar structura del dataframe
head(df);   #Leer inicio del datagrama
tail(df);   #leer final del datagrama

dim(df);    #Dimensiones del Objeto 
names(df);  #Etiquetas tags del objeto
length(df); #Longitud del Objeto
View(df);   #Data Viewer

"Seleccion de datos a analizar y generacion de matriz de Correlaciones Covarianzas,etc"
library(dplyr)
df.select <- select(df, TV, Radio, Newspaper, Sales)
?round
?cor
round(cor(df.select),4)  
cor(df)
round(cor(df),4)
"Generando matrices de graficos de puntos"
pairs(~ Sales + TV + Radio + Newspaper, 
      data = df, gap = 0.4, cex.labels = 2)

"Estimación por Mínimos Cuadrados Ordinarios (OLS)
Y = beta0 + beta1*TV + beta2*Radio + beta3*NewSpaPER + e"
?attach
attach(df)

"Modelo base"
m1 <- lm(Sales ~ TV + Radio + Newspaper)
summary(m1)

"Para ello, planteamos el siguiente juego de hipótesis:
  H0: beta0 = beta1= beta2 = beta3 = 0
  (Y = beta0 + beta1*TV + beta2*Radio + beta3*NewSpaPER + e

  H0 no es verdad (AL MENOS UN COEFICIENTE ES DISTINTO DE 0) Newspaper

  De los resultados anteriores, podemos concluir que el coeficiente de la variable 
  Newspaper (X3) no es significativo. Probemos nuestro modelo sin incluir dicha variable:
  Y = beta0 + beta1*TV + beta2*Radio  + e"

"Modelo final"  
m2 <- update(m1, ~.-Newspaper)
summary(m2)

"Hipótesis Final:
  H0: beta0 = beta1= beta2 = beta3 = 0
   Y = beta0 + beta1*TV + beta2*Radio  + e

  H0  es verdad (Ningun coeficiente es Distinto de Cero)

  De los resultados anteriores, podemos concluir que el Es mas eficiente invertir el presupuesto total de ventas en Radio (X1) y Televisión (X2)"

## SUPUESTOS DEL MODELO DE REGRESIÓN LINEAL Y PREDICCIÓN
"El modelo de regresión lineal clásico establece ciertos supuestos en el término 
de error:
1) Eltérmino de error no tiene correlación significativa con las variables 
explicativas. En caso contrario, tendríamos un problema de endogeneidad.
2) El término de error sigue una distribución normal"
StanRes2 <- rstandard(m2)
StanRes2
?par
??mfrow
par(mfrow = c(2, 2))
plot(TV, StanRes2, ylab = "Residuales Estandarizados")
plot(Radio, StanRes2, ylab = "Residuales Estandarizados")
plot(Newspaper, StanRes2, ylab = "Residuales Estandarizados")
qqnorm(StanRes2)
qqline(StanRes2)

shapiro.test(StanRes2)
