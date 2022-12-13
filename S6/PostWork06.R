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

#adv <- read.csv("advertising.csv")
adv <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-06/data/advertising.csv")
attach(adv)

# Gráfico de dispersión de las variables

pairs(~ Sales + TV + Radio + Newspaper, data = adv, gap = 0.4, cex.labels = 1.5)

# Se observan aproximadamente relaciones lineales

# Ajuste de un modelo con su resumen
# Sales = beta0 + beta1*TV + beta2*Radio + beta3*Newspaper + e

m1 <- lm(Sales ~ TV + Radio + Newspaper)

summary(m1)

# Se pude quitar la variable Newspaper, ya que su p-value no es tan significativo
# y se ajusta nuevamente el modelo 

# Y = beta0 + beta1*TV + beta2*Radio + e (Reducido)

m2 <- update(m1, ~.-Newspaper)
summary(m2)

# Observaciones

# Se muestran las gráficas de residuales estandarizados contra cada elemento . 

StanRes2 <- rstandard(m2)
par(mfrow = c(2, 2))
plot(TV, StanRes2, ylab = "Residuales Estandarizados")
plot(Radio, StanRes2, ylab = "Residuales Estandarizados")

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
