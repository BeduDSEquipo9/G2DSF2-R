

"Utilizando la variable total_intl_charge de la base de datos telecom_service.csv 
de la sesión 3, realiza un análisis probabilístico. Para ello, debes determinar 
la función de distribución de probabilidad que más se acerque el comportamiento 
de los datos. Hint: Puedes apoyarte de medidas descriptivas o técnicas de visualización."



library(DescTools)
df <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-03/Data/telecom_service.csv")
  
summary(df)

promedio <- mean(df$total_intl_calls)
moda <- Mode(df$total_intl_calls)
moda <- Mode(df$total_intl_calls)[1]
mediana <- median(df$total_intl_calls)
desviacion <- sd(df$total_intl_calls)

#Una vez que hayas seleccionado el modelo, realiza lo siguiente:



#Grafica la distribución teórica de la variable aleatoria total_intl_charge

hist(df$total_intl_charge, main="Cargos internacionales")

curve(dnorm(x, mean = promedio, sd = desviacion), from=0, to=50, 
      col='blue', main = "Densidad de Probabilidad Normal",
      ylab = "f(x)", xlab = "X")

curve(pnorm(x, mean = promedio, sd = desviacion), from=0, to=50, 
      col='blue', main = "Probabilidad Acumulada Normal",
      ylab = "f(x)", xlab = "X")

#¿Cuál es la probabilidad de que el total de cargos internacionales sea menor a 1.85 usd?
pnorm(q=1.85, mean =promedio, sd=desviacion, lower.tail = TRUE)

qnorm(p=0.04996519, mean=promedio, sd=desviacion)


#¿Cuál es la probabilidad de que el total de cargos internacionales esté entre 2.35usd y 4.85 usd?
pnorm(q=4.85, mean =promedio, sd=desviacion) - pnorm(q=2.35, mean =promedio, sd=desviacion)

 #Con una probabilidad de 0.48, ¿cuál es el total de cargos internacionales más alto que podría esperar?
pnorm(q=0.48, mean =promedio, sd=desviacion)

#¿Cuáles son los valores del total de cargos internacionales que dejan exactamente
#al centro el 80% de probabilidad?


qnorm(p=0.2/2, mean=promedio, sd=desviacion); qnorm(p=0.2/2, mean=promedio, sd=desviacion, lower.tail = FALSE)

qnorm(p=0.10, mean=promedio, sd=desviacion);qnorm(p=0.9, mean=promedio, sd=desviacion)

qnorm(p=0.10, mean=promedio, sd=desviacion);qnorm(p= 1- 0.2/2, mean=promedio, sd=desviacion, lower.tail = TRUE)

