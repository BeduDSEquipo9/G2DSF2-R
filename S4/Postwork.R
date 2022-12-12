"Utilizando la variable total_intl_charge de la base de datos telecom_service.csv de la sesión 3, 
realiza un análisis probabilístico. Para ello, debes determinar la función de distribución de probabilidad que más 
se acerque el comportamiento de los datos. Hint: Puedes apoyarte de medidas descriptivas o técnicas de visualización.

Una vez que hayas seleccionado el modelo, realiza lo siguiente:"
library(DescTools)
library(ggplot2)

df <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-03/Data/telecom_service.csv")

# Estadísticos de tendencia central
Mode(df$total_intl_charge)[1]
mean(df$total_intl_charge)
median(df$total_intl_charge)

# Histograma
hist(df$total_intl_charge, prob=T, main="Histograma total cargos internacionales")


  "- Grafica la distribución teórica de la variable aleatoria total_intl_charge"
  media <- mean(df$total_intl_charge)
  desv <- sd(df$total_intl_charge)
  
  curve(dnorm(x, mean = media, sd = desv), from=0, to=5, 
        col='blue', main = "Densidad de Probabilidad Normal",
        ylab = "f(x)", xlab = "X")
  
  "- ¿Cuál es la probabilidad de que el total de cargos internacionales sea menor a 1.85 usd?"
  pnorm(q = 1.85, mean = media, sd = desv)
  
  "- ¿Cuál es la probabilidad de que el total de cargos internacionales sea mayor a 3 usd?"
  pnorm(q = 3, mean = media, sd = desv, lower.tail = FALSE)
  
  "- ¿Cuál es la probabilidad de que el total de cargos internacionales esté entre 2.35 usd y 4.85 usd?"
  pnorm(q = 4.85, mean = media, sd = desv) - pnorm(q = 2.35, mean = media, sd = desv)
  
  "- Con una probabilidad de 0.48, ¿cuál es el total de cargos internacionales más alto que podría esperar?"
  qnorm(p = 0.48, mean = media, sd = desv)
  
  "- ¿Cuáles son los valores del total de cargos internacionales que dejan exactamente al centro el 80% de probabilidad?"
  qnorm(p = 0.1, mean = media, sd = desv)
  qnorm(p = 0.1, mean = media, sd = desv, lower.tail = F) #o bien
  qnorm(p = 0.90, mean = media, sd = desv)
  