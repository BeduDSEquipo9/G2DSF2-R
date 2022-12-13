##########################
# Postwork 6. Regresion lineal y clasificación
##########################

"
Supongamos que nuestro trabajo consiste en aconsejar a un cliente sobre como mejorar las ventas de un producto particular, y el conjunto de datos con el que disponemos son datos de publicidad que consisten en las ventas de aquel producto en 200 diferentes mercados, junto con presupuestos de publicidad para el producto en cada uno de aquellos mercados para tres medios de comunicación diferentes: TV, radio, y periódico. No es posible para nuestro cliente incrementar directamente las ventas del producto. Por otro lado, ellos pueden controlar el gasto en publicidad para cada uno de los tres medios de comunicación. Por lo tanto, si determinamos que hay una asociación entre publicidad y ventas, entonces podemos instruir a nuestro cliente para que ajuste los presupuestos de publicidad, y así indirectamente incrementar las ventas.

En otras palabras, nuestro objetivo es desarrollar un modelo preciso que pueda ser usado para predecir las ventas sobre la base de los tres presupuestos de medios de comunicación. Ajuste modelos de regresión lineal múltiple a los datos advertisement.csv y elija el modelo más adecuado siguiendo los procedimientos vistos

Considera:

Y: Sales (Ventas de un producto)
X1: TV (Presupuesto de publicidad en TV para el producto)
X2: Radio (Presupuesto de publicidad en Radio para el producto)
X3: Newspaper (Presupuesto de publicidad en Periódico para el producto)
"
adv <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-06/data/advertising.csv")

str(adv)
round(cor(adv),4)

pairs(~ Sales + TV + Radio + Newspaper, 
      data = adv, gap = 0.4, cex.labels = 1.5)

attach(adv) # Toma todas las variables y las enmascara en lugar de df$
m1 <- lm(Sales ~ TV + Radio + Newspaper )#
summary(m1)

StanRes2 <- rstandard(m1)

par(mfrow = c(3, 2))

plot(m1$fitted.values, Sales, ylab = "Valores ajustados")
plot(TV, StanRes2, ylab = "Residuales Estandarizados")
plot(Radio, StanRes2, ylab = "Residuales Estandarizados")
plot(Newspaper, StanRes2, ylab = "Residuales Estandarizados")


qqnorm(StanRes2)
qqline(StanRes2)

dev.off()
shapiro.test(StanRes2)

# Modelo 2
m2 <- update(m1, ~.-Newspaper)#
summary(m2)

StanRes2 <- rstandard(m1)

par(mfrow = c(2, 2))

plot(m2$fitted.values, Sales, ylab = "Valores ajustados")
plot(TV, StanRes2, ylab = "Residuales Estandarizados")
plot(Radio, StanRes2, ylab = "Residuales Estandarizados")


qqnorm(StanRes2)
qqline(StanRes2)

dev.off()
shapiro.test(StanRes2)

# Modelo 3
m3 <- update(m2, ~.-Radio)#
summary(m3)

StanRes2 <- rstandard(m3)

par(mfrow = c(2, 2))

plot(m3$fitted.values, Sales, ylab = "Valores ajustados")
plot(TV, StanRes2, ylab = "Residuales Estandarizados")
plot(Radio, StanRes2, ylab = "Residuales Estandarizados")


qqnorm(StanRes2)
qqline(StanRes2)

dev.off()
shapiro.test(StanRes2)
