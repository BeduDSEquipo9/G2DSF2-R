#######################

# Postwork 6. Regresion lineal y clasificación

#######################

"Supongamos que nuestro trabajo consiste en aconsejar a un cliente sobre como mejorar 
las ventas de un producto particular, y el conjunto de datos con el que disponemos son 
datos de publicidad que consisten en las ventas de aquel producto en 200 diferentes mercados, 
junto con presupuestos de publicidad para el producto en cada uno de aquellos mercados 
para tres medios de comunicación diferentes: TV, radio, y periódico. No es posible 
para nuestro cliente incrementar directamente las ventas del producto. Por otro lado, 
ellos pueden controlar el gasto en publicidad para cada uno de los tres medios de comunicación. 
Por lo tanto, si determinamos que hay una asociación entre publicidad y ventas, 
entonces podemos instruir a nuestro cliente para que ajuste los presupuestos de 
publicidad, y así indirectamente incrementar las ventas.

En otras palabras, nuestro objetivo es desarrollar un modelo preciso que pueda ser 
usado para predecir las ventas sobre la base de los tres presupuestos de medios de 
comunicación. Ajuste modelos de regresión lineal múltiple a los datos advertisement.csv 
y elija el modelo más adecuado siguiendo los procedimientos vistos"

"Considera:
    Y: Sales (Ventas de un producto)
    X1: TV (Presupuesto de publicidad en TV para el producto)
    X2: Radio (Presupuesto de publicidad en Radio para el producto)
    X3: Newspaper (Presupuesto de publicidad en Periódico para el producto)"


library(dplyr)

"Analisis de datos"
#adv <- read.csv("advertising.csv")*
adv <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-06/data/advertising.csv")

class(adv)   #Id tipo de dato
str(adv);    #Identificar structura del dataframe
head(adv);   #Leer inicio del datagrama
tail(adv);   #leer final del datagrama

dim(adv);    #Dimensiones del Objeto 
names(adv);  #Etiquetas tags del objeto
length(adv); #Longitud del Objeto
View(adv);   #Data Viewer

"Seleccion de datos a analizar y generacion de matriz de Correlaciones Covarianzas,etc"

any(is.na(adv))
round(cor(adv),4)
#Se observa que TV y radio tienen mayor correlación con Sales


"Generando matrices de graficos de puntos"

pairs(~ Sales + TV + Radio + Newspaper, data = adv, gap = 0.4, cex.labels = 1.5)
# Se observan aproximadamente relaciones lineales
# Se observa una correlación positiva con Tv, tambien cierta relación con Radio, no con Newspaper


"Estimación por Mínimos Cuadrados Ordinarios (OLS)
Y = beta0 + beta1*TV + beta2*Radio + beta3*NewSpaPER + e"
?attach
attach(adv)

# Ajuste de un modelo con su resumen
# Sales = beta0 + beta1*TV + beta2*Radio + beta3*Newspaper + e
m1 <- lm(Sales ~ TV + Radio + Newspaper)

summary(m1)

# Se pude quitar la variable Newspaper, ya que su p-value no es tan significativo
# y se ajusta nuevamente el modelo 

# Y = beta0 + beta1*TV + beta2*Radio + e (Reducido)

"Modelo final"  
m2 <- update(m1, ~.-Newspaper)
summary(m2)

# Observaciones
"Hipótesis Final:
  H0: beta0 = beta1= beta2 = beta3 = 0
   Y = beta0 + beta1*TV + beta2*Radio  + e
  H0  es verdad (Ningun coeficiente es Distinto de Cero)
  De los resultados anteriores, podemos concluir que el Es mas eficiente invertir el presupuesto total de ventas en Radio (X1) y Televisión (X2)"

## SUPUESTOS DEL MODELO DE REGRESIÓN LINEAL Y PREDICCIÓN
# Se muestran las gráficas de residuales estandarizados contra cada elemento . 

StanRes2 <- rstandard(m2)
par(mfrow = c(2, 2))
plot(TV, StanRes2, ylab = "Residuales Estandarizados")
plot(Radio, StanRes2, ylab = "Residuales Estandarizados")

#Las graficas deben ser con tendencia plana, lo que significa que:
#"1) El término de error no tiene correlación significativa con las variables "

qqnorm(StanRes2)
qqline(StanRes2)


dev.off()

shapiro.test(StanRes2)

# Modelo con efectos cruzados

# Sales = beta0 + beta1*TV + beta2*Radio +  beta3*TV*Radio + e (completo)

mfull <- lm(Sales ~ TV + Radio + TV:Radio)

summary(mfull)

# Se compara el modelo mfull contra el modelo m2 con ANOVA. 
# Utilizando el siguiente juego de hipótesis

# H0: beta3 = 0
# Sales = beta0 + beta1*TV + beta2*Radio + e
# 
# H1: H0 no se cumple
# Sales = beta0 + beta1*TV + beta2*Radio +  beta3*TV*Radio +  e

# prueba-F parcial.

anova(m2,mfull)

# Como p-value es aproximadamente 7.633e-07, se rechaza la hipótesis nula y se toma la Ha
# Sales = beta0 + beta1*TV + beta2*Radio +  beta3*TV*Radio +  e

# Gráficas
StanRes <- rstandard(mfull)
par(mfrow = c(2, 2))
plot(TV, StanRes, ylab = "Residuales Estandarizados")
plot(Radio, StanRes, ylab = "Residuales Estandarizados")

# Buscamos evidencia para soportar la hipótesis de normalidad en los errores 

qqnorm(StanRes)
qqline(StanRes)

dev.off()

shapiro.test(StanRes)
