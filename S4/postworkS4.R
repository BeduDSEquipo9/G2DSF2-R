###########################
#Postwork sesión 4
# Christian Millán
###########################
"
Objetivo

Realizar un análisis probabilístico del total de cargos internacionales de una 
compañía de telecomunicaciones
Requisitos

R, RStudio
Haber trabajado con el prework y el work
Desarrollo

Utilizando la variable total_intl_charge de la base de datos telecom_service.csv 
de la sesión 3, realiza un análisis probabilístico. Para ello, debes determinar 
la función de distribución de probabilidad que más se acerque el comportamiento 
de los datos. Hint: Puedes apoyarte de medidas descriptivas o técnicas de 
visualización."

df <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-03/Data/telecom_service.csv")
summary(df)
str(df)
View(df)

(mean.total_intl_charge <- mean(df$total_intl_charge)) # 2.764581
median(df$total_intl_charge)
Mode(df$total_intl_charge)

sd.total_intl_charge <- sd(df$total_intl_charge) 
hist(df$total_intl_charge, main = "Histograma")

"Una vez que hayas seleccionado el modelo, realiza lo siguiente:

Grafica la distribución teórica de la variable aleatoria total_intl_charge"

curve(dnorm(x, mean = mean.total_intl_charge , sd = sd.total_intl_charge ),
      from = 0, to = 5,
      col='blue', main = "Densidad Normal:\nDiferente media",
      ylab = "f(x)", xlab = "X")
abline(v = mean.total_intl_charge, lwd = 0.5, lty = 2)
"¿Cuál es la probabilidad de que el total de cargos internacionales sea menor a 
1.85 usd?"

pnorm(q = 1.85, mean = mean.total_intl_charge, sd = sd.total_intl_charge, 
      lower.tail = TRUE) # 0.1125002


"¿Cuál es la probabilidad de que el total de cargos internacionales sea mayor a 
3 usd?"
pnorm(q = 3.0, mean = mean.total_intl_charge, sd = sd.total_intl_charge, 
      lower.tail = FALSE) # 0.3773985

"¿Cuál es la probabilidad de que el total de cargos internacionales esté entre 
2.35usd y 4.85 usd?"
pnorm(q = 4.85, mean = mean.total_intl_charge, sd = sd.total_intl_charge, 
      lower.tail = TRUE) - 
  pnorm(q = 2.35, mean = mean.total_intl_charge, sd = sd.total_intl_charge, 
                                 lower.tail = TRUE) # 0.7060114

"Con una probabilidad de 0.48, ¿cuál es el total de cargos internacionales más 
alto que podría esperar?"
qnorm(p = 0.48, mean = mean.total_intl_charge, sd = sd.total_intl_charge) # 2.726777

"¿Cuáles son los valores del total de cargos internacionales que dejan exactamente al centro el 80% de probabilidad?
"
qnorm(p = 0.1, mean = mean.total_intl_charge, sd = sd.total_intl_charge) # 1.798583
qnorm(p = 0.1, mean = mean.total_intl_charge, sd = sd.total_intl_charge, lower.tail = FALSE) # 3.73058
