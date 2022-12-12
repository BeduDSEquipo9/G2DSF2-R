###### RETO 02: DISTRIBUCIÓN DE POISSON Y EXPONENCIAL

library(dplyr)
library(DescTools)
library(ggplot2)
library(moments)

"Utilizando la variable total_intl_charge de la base de datos
telecom_service.csv de la sesión 3, realiza un análisis probabilístico. Para ello,
debes determinar la función de distribución de probabilidad que más se
acerque el comportamiento de los datos. Hint: Puedes apoyarte de medidas
descriptivas o técnicas de visualización."

df <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-03/Data/telecom_service.csv")
summary(df)
#Medidas descriptivas:
df.mean <- mean(df$total_intl_charge)
df.sd <- sd(df$total_intl_charge)
df.mode <- Mode(df$total_intl_charge)
df.median <- median(df$total_intl_charge)
df.median; df.mode[1]; df.median 
#Moda = Media = Mediana distribución normal

hist(df$total_intl_charge, main = "Histograma Ingreso")

#Comportamiento de distribucion Normal

"Una vez que hayas seleccionado el modelo, realiza lo siguiente:"
"1. Grafica la distribución teórica de la variable aleatoria total_intl_charge"
curve(dnorm(x, mean = df.mean, sd = df.sd), from = 0, to = 6, 
      col='blue', main = "Densidad Normal:\nDiferente media",
      ylab = "f(x)", xlab = "X")

"2. ¿Cuál es la probabilidad de que el total de cargos internacionales sea
menor a 1.85 usd?"
pnorm(q = 1.85, mean = df.mean, sd = df.sd, lower.tail = T) #lower.tail = T (<=)
# [1] 0.1125002


"3. ¿Cuál es la probabilidad de que el total de cargos internacionales sea
mayor a 3 usd?"
pnorm(q = 3, mean = df.mean, sd = df.sd, lower.tail = F) #lower.tail = T (>)
#[1] 0.3773985


"4. ¿Cuál es la probabilidad de que el total de cargos internacionales esté
entre 2.35usd y 4.85 usd?"
pnorm(q = 4.85, mean = df.mean, sd = df.sd) - pnorm(q = 2.35, mean = df.mean, sd = df.sd) 
# 0.7060114

"5. Con una probabilidad de 0.48, ¿cuál es el total de cargos internacionales
más alto que podría esperar?"
b <- qnorm(p = 0.48, mean = df.mean, sd = df.sd)
b
# [1] 2.726777


