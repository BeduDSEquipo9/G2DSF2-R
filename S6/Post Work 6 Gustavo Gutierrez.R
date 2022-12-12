   "Supongamos que nuestro trabajo consiste en aconsejar a un cliente sobre 
   como mejorar las ventas de un producto particular, y el conjunto de datos 
   con el que disponemos son datos de publicidad que consisten en las ventas 
   de aquel producto en 200 diferentes mercados, junto con presupuestos de 
   publicidad para el producto en cada uno de aquellos mercados para tres medios 
   de comunicación diferentes: TV, radio, y periódico. No es posible para 
   nuestro cliente incrementar directamente las ventas del producto. Por otro 
   lado, ellos pueden controlar el gasto en publicidad para cada uno de los tres
   medios de comunicación. Por lo tanto, si determinamos que hay una asociación 
   entre publicidad y ventas, entonces podemos instruir a nuestro cliente para 
   que ajuste los presupuestos de publicidad, y así indirectamente incrementar 
   las ventas."
   
"En otras palabras, nuestro objetivo es desarrollar un modelo preciso que pueda 
ser usado para predecir las ventas sobre la base de los tres presupuestos de 
medios de comunicación. Ajuste modelos de regresión lineal múltiple a los datos
advertisement.csv y elija el modelo más adecuado siguiendo los procedimientos
vistos"
   
"Considera:

Y: Sales (Ventas de un producto)
X1: TV (Presupuesto de publicidad en TV para el producto)
X2: Radio (Presupuesto de publicidad en Radio para el producto)
X3: Newspaper (Presupuesto de publicidad en Periódico para el producto"
   
   
adv <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-06/data/advertising.csv")
any(is.na(adv))
round(cor(adv),4)
#Se observa que TV y radio tienen mayor correlación con Sales

pairs(~ Sales + TV + Radio + Newspaper, 
      data = adv, gap = 0.4, cex.labels = 1.5)
#Se observa una correlación positiva con Tv, tambien cierta relación con Radio, no con Newspaper

# Sales = beta0 + beta1*TV + beta2*Radio + beta3*Newspaper + e
attach(adv)

m1 <- lm(Sales ~ TV + Radio + Newspaper)   
summary(m1)

#Multiple R-squared:  0.9026,	Adjusted R-squared:  0.9011 ->  BUENA CORRELACIÓN
#Hacer las pruebas de hipotesis para cada variable hipotesis para la población
#     ho: beta_i == 0 (significa que no tiene impacto en Precio)
#     ha: beta_i !=0
#Para TV: p_value casi 0, Se rechaza Ho, La variable SI tiene impacto en Sales
#Para Radio: p_value casi 0, Se rechaza Ho, La variable SI tiene impacto en Sales
#Para Newspaper: p_value > Niveles de sib, NO rechaza Ho, La variable NO tiene impacto en Sales

### aHORA SE HACE UN SEGUNDO MODELO, SIN LA VARIABLE QUE NO TIENE IMPACTO:
m2 <- update(m1, ~.- Newspaper)   
summary(m2)
#Multiple R-squared:  0.9026,	Adjusted R-squared:  0.9016 
#R cuadrada ajustada mejor ligeramente
StanRes1 <- rstandard(m1)

StanRes2 <- rstandard(m2)
par(mfrow = c(2, 2))
plot(TV, StanRes2, ylab = "Residuales Estandarizados")
plot(Radio, StanRes2, ylab = "Residuales Estandarizados")
#Las graficas deben ser con tendencia plana, lo que significa que:
#"1) El término de error no tiene correlación significativa con las variables "

dev.off()
qqnorm(StanRes2)
qqline(StanRes2)

#Verificación estadística del comportamiento
shapiro.test(StanRes1) #Prueba de inferencia
shapiro.test(StanRes2) #Prueba de inferencia
"Ho: La variable distribuye como una normal
Ha: La variable no distribuye como una normal"
#W = 0.97535, p-value = 0.001365
#A un nivel de confianza del 90% -> p-value < sig 0.1, RECHAZO la Ho (NO distribuye normal)
#A un nivel de confianza del 95% -> p-value < sig 0.05, RECHAZO la Ho (NO distribuye normal)
#A un nivel de confianza del 99% -> p-value < sig 0.01, RECHAZO la Ho (NO distribuye normal)

"No se cumplen el segundo supuesto(DISTRIBUCIÓN NORMAL)"
#El modelo de predicción es m2


