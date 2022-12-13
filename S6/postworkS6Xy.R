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

"Seleccion de datos a analizar"
complete.cases(df)
X1<-df$TV
X2<-df$Radio
X3<-df$Newspaper
Y<-df$Sales
dfxy<-data.frame(X1,X2,X3,Y)
View(dfxy)
str(dfxy)

"Sacando matrices de correlacion varianzas"
?round
?cor
cor(dfxy)
"Redondeando a 4 digitos la matriz"
round(cor(dfxy),4)

"generando Matrices de graficos de puntos "
?pairs
pairs(~ Y + X1 + X2 + X3, 
      data = dfxy, gap = 0.4, cex.labels = 2)

"Estimación por Mínimos Cuadrados Ordinarios (OLS)
Y = beta0 + beta1*TV + beta2*Radio + beta3*NewSpaPER + e"
attach(dfxy)

m1 <- lm(Y ~ X1 + X2 + X3)
summary(m1)

"Para ello, planteamos el siguiente juego de hipótesis:
  H0: beta0 = beta1= beta2 = beta3 = 0
  (Y = beta0 + beta1*X1 + beta2*X2 + beta3*X3 + e

  H0 no es verdad (AL MENOS UN COEFICIENTE ES DISTINTO DE 0) Newspaper

  De los resultados anteriores, podemos concluir que el coeficiente de la variable 
  Newspaper (X3) no es significativo. Probemos nuestro modelo sin incluir dicha variable:
  Y = beta0 + beta1*X1 + beta2*X2  + e"

"Modelo final"  

m2 <- update(m1, ~.-X3)
summary(m2)

"Hipótesis Final:
  H0: beta0 = beta1= beta2 = beta3 = 0
   Y = beta0 + beta1*X1 + beta2*X2  + e

  H0  es verdad (Ningun coeficiente es Distinto de Cero)

  De los resultados anteriores, podemos concluir que el Es mas eficiente invertir el presupuesto total de ventas en Radio (X1) y Televisión (X2)"