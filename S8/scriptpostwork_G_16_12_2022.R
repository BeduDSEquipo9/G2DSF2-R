###################################
# Reto 8. 
###################################

###############################################################################
library(dplyr)
library(DescTools)
library(ggplot2)
library(moments)

setwd("~/dev/R/s8")
#df <- read.csv("inseguridad_alimentaria_bedu.csv")
df <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-08/Postwork/inseguridad_alimentaria_bedu.csv")
# Primera vista de los datos
names(df)
str(df)
summary(df)
#View(df)
"Estos primeros pasos permiten concer la estructura de los datos y un resumen
de estadísticos para cada columna del conjunto de datos"

# Limpieza de los datos
"Después de revisar la estructura, se realiza la conversion de algunas de las 
representaciones de las características de tipo int a factor"
## Conversión de tipos
"Convertir nse5f a categórica ordinal"
df$nse5f <- factor(df$nse5f, 
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("Bajo", "Medio bajo", "Medio", "Medio alto", "Alto"),
                   ordered =  TRUE)
"Convertir area a categórica"
df$area <- factor(df$area, 
                  levels = c(0, 1),
                  labels = c("Urbana", "Rural"))
"Convertir refin a categórica"
df$refin <- factor(df$refin, 
                   levels = c(0, 1),
                   labels = c("No", "Si"))
"Convertir sexojef a categórica"
df$sexojef <- factor(df$sexojef, 
                     levels = c(0, 1),
                     labels = c("Hombre", "Mujer"))
"Convertir IA a categórica"
df$IA <- factor(df$IA, 
                levels = c(0, 1),
                labels = c("No", "Si"))
"Adicional, se realizar una conversión de las variables ln_als y ln_alns que están
expresadas en logaritmo natural"
df$als <- exp(df$ln_als) 
df$alns <- exp(df$ln_alns)

"Se realiza un conversión de los datos atípicos extremos mediante la sustitución 
de un valor tope, esto solo con la finalidad de mejora la visualizaciones graficas
que se realizarán en los siguientes pasos"
df$alns <- replace(df$alns, df$alns > 2320,2320) 
df$als <- replace(df$als, df$als > 3800,3800) 

# #View(df)
# str(df)
# summary(df)

## NAs
"Se realiza un conteo de el número de NAs por columnas que lo reflejaron en str()"
sum(complete.cases(df)) #20280 vs 40809 obs. el 50% esta incompleto
sum(complete.cases(df$edadjef)) # 35792 Borrar o media o mean
sum(complete.cases(df$sexojef)) # 35818 Borrar o llenar con
sum(complete.cases(df$ln_als))  # 40022 Borrar o llenar??
sum(complete.cases(df$ln_alns)) # 23305 Borrar o llenar??

# ## Fill NAs 
# # Solo llenamos edad jefe
# df$edadjef[is.na(df$edadjef)] <- mean(df$edadjef, na.rm = TRUE)
# df$sexojef[is.na(df$sexojef)] <- Mode(df$sexojef, na.rm = TRUE)
# summary(df)

### borrrar
"Se realiza la eliminación de aquellos registros que estan incompletos en cualquier
de las características del conjunto de datos"
df.clean <- df[complete.cases(df),]
#
str(df.clean)
summary(df.clean)
"Nuevamente se realiza un análisis con summary, se concluye que la eluiminación
de los NAs no afecta la tendencia de promedios, medianas y cuartiles."
#View(df.clean)

# Exploración de los datos
## ADES
"Antes de realizar un análisis estadístico es importante realizar una inspección
visual de los datos"

"De acuerdo a la descripción del problema es necesario identificar patrones de 
gatos en alimentos saludables y no saudables, por lo que en primer lugar se realizar
la inspección visal univariable de als y alns"
## graficas de cajas 

boxplot(df.clean$als,
        ylab="Unidades gastadas",
        main="Gasto en alimentos saludables")

boxplot(df.clean$alns,
        ylab="Unidades gastadas",
        main="Gasto en alimentos NO saludables")

"Ahora se relaiza una visualzación de las variables als y alns con respecto a los factores
destacados por la descripcción del problema:
- Nivel socioeconómico
- Si el hogar cuenta con recursos financieros extra
- Si presenta o no inseguridad alimentaria
"

# Alimentos saludables
ggplot(df.clean, 
       aes(x=nse5f,
           y=als,
           fill=nse5f))+
  geom_boxplot()+
  labs(x="Nivel socioecónomico", 
       y="Unidades gastadas",
       title = "Gastos alimentos saludables segun nivel socieconómico")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

ggplot(df.clean, 
       aes(x=refin,
           y=als,
           fill=refin))+
  geom_boxplot()+
  labs(x="Recursos financieros distintos al ingreso laboral", 
       y="Unidades gastadas",
       title = "Gastos alimentos saludables segun recursos financieros distintos al ingreso laboral")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

ggplot(df.clean, 
       aes(x=IA,
           y=als,
           fill=IA))+
  geom_boxplot(alpha=0.7)+
  labs(x="Inseguridad Alimentaria en el hogar", 
       y="Unidades gastadas",
       title = "Gastos alimentos saludables segun Inseguridad Alimentaria en el hogar")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

# Alimentos no saludables
ggplot(df.clean, 
       aes(x=nse5f,
           y=alns,
           fill=nse5f))+
  geom_boxplot()+
  labs(x="nivel socieconómico", 
       y="Unidades gastadas",
       title = "Gastos alimentos NO saludables segun nivel socieconómico")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

ggplot(df.clean, 
       aes(x=refin,
           y=alns,
           fill=refin))+
  geom_boxplot()+
  labs(x="Recursos financieros distintos al ingreso laboral", 
       y="Unidades gastadas",
       title = "Gastos alimentos NO saludables segun recursos financieros distintos al ingreso laboral")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

ggplot(df.clean, 
       aes(x=IA,
           y=alns,
           fill=IA))+
  geom_boxplot()+
  labs(x="Inseguridad Alimentaria en el hogar", 
       y="Unidades gastadas",
       title = "Gastos alimentos NO saludables segun Inseguridad Alimentaria en el hogar")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
#########################

## histogramas
# freq <- table(df$nse5f)
# freq # Esto se tienen en str()
# transform(freq, 
#           rel.freq=prop.table(Freq)) #frecuencia relativa


freq <- table(df$IA)
freq 
transform(freq,
          rel.freq=prop.table(Freq)) #frecuencia relativa

plot(x = df$IA, main = "Gráfica de Inseguridad Alimentaria en el Hogar",
     xlab = "Inseguridad Alimentaria", ylab = "Frecuencia", 
     col = c("royalblue", "seagreen"))


freq <- table(df.clean$IA)
freq # Esto se tienen en str()
transform(freq,
          rel.freq=prop.table(Freq)) #frecuencia relativa


plot(x = df.clean$IA, main = "Gráfica de Inseguridad Alimentaria en el Hogar",
     xlab = "Inseguridad Alimentaria", ylab = "Frecuencia", 
     col = c("royalblue", "seagreen"))





freq <- table(df$als)
freq # Esto se tienen en str()
transform(freq,
          rel.freq=prop.table(Freq)) #frecuencia relativa

hist(x = df$als, main = "Histograma de Gasto en Alimentos Saludables", 
     xlab = "Gasto en Alimentos Saludables", ylab = "Frecuencia",
     col = "purple")


freq <- table(df.clean$als)
freq # Esto se tienen en str()
transform(freq,
          rel.freq=prop.table(Freq)) #frecuencia relativa

hist(x = df.clean$als, main = "Histograma de Gasto en Alimentos Saludables", 
     xlab = "Gasto en Alimentos Saludables", ylab = "Frecuencia",
     col = "purple")


freq <- table(df$alns)
freq # Esto se tienen en str()
transform(freq,
          rel.freq=prop.table(Freq)) #frecuencia relativa

hist(x = df$alns, main = "Histograma de Gasto en Alimentos No Saludables", 
     xlab = "Alimentos No Saludables", ylab = "Frecuencia",
     col = "purple")

freq <- table(df.clean$alns)
freq # Esto se tienen en str()
transform(freq,
          rel.freq=prop.table(Freq)) #frecuencia relativa

hist(x = df.clean$alns, main = "Histograma de Gasto en Alimentos No Saludables", 
     xlab = "Alimentos No Saludables", ylab = "Frecuencia",
     col = "purple")



hist(x=df.clean$als, main = "Histograma de frecuencias Gastos Alimentarios", # Frecuencia
     xlab="als - alns",ylab = "Frecuencia")



grid(nx = NA, ny = NULL, lty = 2, col = "gray", lwd = 1)
hist(x=df.clean$alns, add=TRUE, col = "purple")



#alimentos Saludables
#alimentos no saludables
#tabla frecuencias e histogramas


# nse5f (Nivel socieconómico del hogar)
ggplot(df, aes(x = nse5f)) +
  geom_bar()+
  labs(x="Nivel socieconómico del hogar", y="Cantidad de casos",
       title="Nivel socieconómico del hogar")

# refin (Recursos financieros distintos al ingreso laboral)
ggplot(df, aes(x = refin)) +
  geom_bar()+
  labs(x="Recursos financieros distintos al ingreso laboral", y="Cantidad de casos",
       title="Recursos financieros distintos al ingreso laboral")

# freq.IA <- table(df$IA)
# freq.IA # Esto se tienen en str()
# transform(freq.IA, 
#           rel.freq=prop.table(Freq)) #frecuencia relativa

# IA (Inseguridad alimentaria en el hogar)
ggplot(df, aes(x = IA)) +
  geom_bar() +
  labs(x="Inseguridad Aimentaria en el hogar", y="Cantidad de casos",
       title="Inseguridad Alimentaria en el hogar")

ggplot(df.clean, 
       aes(als)) +
  geom_histogram()
labs(title = "Gasto en alimentos saludables", 
     x = "Gasto en alimentos saludables",
     y = "Unidades gastadas") + 
  theme_classic()

ggplot(df.clean, aes(als)) +
  geom_histogram(aes(y = cumsum(..count..)), bins = 50) + 
  labs(title = "Gasto en alimentos saludables acumulados", 
       x = "Gasto en alimentos saludables",
       y = "Unidades gastadas") + 
  theme_classic()

ggplot(df.clean, aes(alns)) +
  geom_histogram(bins = 50) + 
  labs(title = "Gasto en alimentos NO saludables", 
       x = "Gasto en alimentos NO saludable",
       y = "Unidades gastadas") + 
  theme_classic()

ggplot(df.clean, aes(alns)) +
  geom_histogram(aes(y = cumsum(..count..)), bins = 50) + 
  labs(title = "Gasto en alimentos NO saludables acumulado", 
       x = "Gasto en alimentos NO saludables",
       y = "Unidades gastadas") + 
  theme_classic()

# Otros histogramas
ggplot(df, aes(numpeho)) +
  geom_histogram(bins = 16) + 
  labs(title = "Número de personas en el hogar", 
       x = "Número de personas en el hogar",
       y = "Frequency") + 
  theme_classic()

ggplot(df, aes(edadjef)) +
  geom_histogram(bins = 20) + 
  labs(title = "Edad del jefe/a de familia", 
       x = "Edad del jefe/a de familia",
       y = "Frequency") + 
  theme_classic()

ggplot(df, aes(añosedu)) +
  geom_histogram(bins = 5) + 
  labs(title = "Años de educación del jefe de familia", 
       x = "Años de educación del jefe de familia",
       y = "Frequency") + 
  theme_classic()

# Medidas descriptivas para als
## Medidas de tendencia central
mean(df.clean$als)
median(df.clean$als)
Mode(df.clean$als)
# Medidas de dispersión
var(df.clean$als)
sd(df.clean$als)
#### Coeficiente de variación***
sd(df.clean$als)/mean(df.clean$als) * 100 #si > 25% ->no son homogéneos 56.64 
# Medidad de posición
cuartiles <- quantile(df.clean$als, probs = c(0.25, 0.50, 0.75))
cuartiles
deciles <-quantile(df.clean$als, probs = c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9))
deciles
percentiles <- quantile(df.clean$als, probs = seq(0.01,0.99, by=0.01))
percentiles
# Medidas de forma
skewness(df.clean$als) # #s > 0 Sesgo a la derecha s = 0 Simétrica s < 0 Sesgo a la izquierda
kurtosis(df.clean$als) # #Leptocúrtica k > 3 #Mesocúrtica k = 3 Platocúrtica k < 3


# Medidas descriptivas para alns
## Medidas de tendencia central
mean(df.clean$alns)
median(df.clean$alns)
Mode(df.clean$alns)
# Medidas de dispersión
var(df.clean$alns)
sd(df.clean$alns)
#### Coeficiente de variación***
sd(df.clean$alns)/mean(df.clean$alns) * 100 #si > 25% ->no son homogéneos 130.48
# Medidad de posición
cuartiles <- quantile(df.clean$alns, probs = c(0.25, 0.50, 0.75))
cuartiles
deciles <-quantile(df.clean$alns, probs = c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9))
deciles
percentiles <- quantile(df.clean$alns, probs = seq(0.01,0.99, by=0.01))
percentiles
# Medidas de forma
skewness(df.clean$alns) # #s > 0 Sesgo a la derecha s = 0 Simétrica s < 0 Sesgo a la izquierda
kurtosis(df.clean$alns) # #Leptocúrtica k > 3 #Mesocúrtica k = 3 Platocúrtica k < 3

skewness(df$alns)

# Medidas descriptivas para alns X GRUPO
## Medidas de tendencia central
mean.bajo <- mean(df.clean[df.clean$nse5f == 'Bajo', "alns"])
mean.medio.bajo <- mean(df.clean[df.clean$nse5f == "Medio bajo", "alns"])
mean.medio <- mean(df.clean[df.clean$nse5f == "Medio", "alns"])
mean.medio.alto <- mean(df.clean[df.clean$nse5f == "Medio alto", "alns"])
mean.alto <- mean(df.clean[df.clean$nse5f == 'Alto', "alns"])

sd.bajo <- sd(df.clean[df.clean$nse5f == 'Bajo', "alns"])
sd.medio.bajo <- sd(df.clean[df.clean$nse5f == "Medio bajo", "alns"])
sd.medio <- sd(df.clean[df.clean$nse5f == "Medio", "alns"])
sd.medio.alto <- sd(df.clean[df.clean$nse5f == "Medio alto", "alns"])
sd.alto <- sd(df.clean[df.clean$nse5f == 'Alto', "alns"])

(cv.bajo <- sd.bajo/mean.bajo * 100) 
(cv.medio.bajo <- sd.medio.bajo/mean.medio.bajo * 100) 
(cv.medio <- sd.medio/mean.medio * 100) 
(cv.medio.alto <- sd.medio.alto/mean.medio.alto * 100) 
(cv.alto <- sd.alto/mean.alto * 100) 


#df.clean[df.clean$nse5f == 'Bajo', "alns"]

# Coeficiente de correlación de Pearson
df.select2 <- select(df.clean, numpeho, edadjef, añosedu, als, alns)
corr_matrix <- round(cor(df.select2),4)
corr_matrix

pairs(df.select2)


## Ensayo de Bernoulli y Distribución normal
n <- 11471
p <- 0.74
count <- c()
for (i in seq(n)) {
  x <- sample(c("Si", "No"), size = 1, prob = c(p, 1-p))
  if (x == "Si") {
    count[i] <- 1
  }
  else
    count[i] <- 0
  
}

barplot(table(count)/length(count), 
        main = "Experimento de Bernoulli", 
        xlab = "Simalación de Inseguridad Alimentaria (Bernoulli)",
        names = c("No", "Si"))


binom <- rbinom(n = 111471, size = 10, prob = 0.74)
barplot(table(binom)/length(binom),
        main = "Distribución Binomial", 
        xlab = "# de familias con Inseguridad Alimentaria en el hogar")

"Un familia tiene una probabilidad de 0.74 de presentar Inseguridad Alimentaria 
en el hogar en México. Si al día se evaluan 10 familias, 
¿cuál es la probabilidad de que menos de 4 familias presenten Inseguridad Alimentaria 
en el hogar?"
pbinom(q = 3, size = 10, prob = 0.74, lower.tail = TRUE) #P(X<=x)  0.0044618

"¿cuál es la probabilidad de que más de 8 familias presenten Inseguridad Alimentaria 
en el hogar?"
pbinom(q = 8, size = 10, prob = 0.74, lower.tail = FALSE) #P(X>x)  0.222245

"¿cuál es la probabilidad de que 7 familias presenten Inseguridad Alimentaria 
en el hogar?" 
dbinom(x = 7, size = 10, prob = 0.74) #  0.2562851


## Distribución normal
"El gasto als de una familia mexicana tiene una distribución normal cuya media 
es 651.0853 unidades con desviación estándar de 368.805"
#als
mean.als <- 593.8028
sd.als <- 356.9995
{
  curve(dnorm(x, mean = mean.als, sd = sd.als), from = 0, to = 2000, 
        col='blue', main = "Densidad Normal - als",
        ylab = "f(x)", xlab = "X")
  abline(v =651.0853 , lwd = 0.5, lty = 2)
}

x <- seq(-4, 4, 0.01)*sd.als + mean.als
y <- dnorm(x, mean = mean.als, sd = sd.als) 

plot(x, y, type = "l", xlab = "X", ylab = "f(x)",
     main = "Densidad de Probabilidad Normal", 
     sub = expression(paste(mu == mean.als, " y ", sigma == mean.als)))

integrate(dnorm, lower = x[1], upper = x[length(x)], mean=mean.als, sd = sd.als)

"Calcula P(X <= 312): (salario mínimo 2023 frontera, 207 resto país) " 
pnorm(q = 312, mean = mean.als, sd = sd.als, lower.tail = TRUE) # 0.2149494

par(mfrow = c(2, 2))
plot(x, y, type = "l", xlab = "", ylab = "")
title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == mean.als, " y ", sigma == sd.als)))

polygon(c(min(x), x[x<=312], 312), c(0, y[x<=312], 0), col="red")

"Calcula P(X <= 312): (salario mínimo 2023)" 
pnorm(q = 312, mean = mean.als, sd = sd.als, lower.tail = TRUE) #

"Calcula P(0 <= X <= 312):"
pnorm(q = 312, mean = mean.als, sd = sd.als) - pnorm(q = 0, mean = mean, sd = sd) #  0.14019

plot(x, y, type = "l", xlab="", ylab="")
title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == mean.als, " y ", sigma == mean.als)))

polygon(c(0, x[x>=0 & x<=312], 312), c(0, y[x>=0 & x<=312], 0), col="green")


"Calcula P(X >= 312):"
pnorm(q = 312, mean = mean.als, sd = sd.als, lower.tail = FALSE) # 0.821061

plot(x, y, type = "l", xlab="", ylab="")
title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == mean.als, " y ", sigma == sd.als)))

polygon(c(312, x[x>=312], max(x)), c(0, y[x>=312], 0), col="blue")

dev.off()

"Como con cualquier otra distribución, también podemos calcular los cuantiles de la 
distribución, es decir podemos encontrar el valor b, tal que P(X <= b) = 0.75:"
b <- qnorm(p = 0.75, mean = mean.als, sd = sd.als)
b

## Falta hacer lo mismo con alns
##############################################################################

##############################################################################
"El gasto alns de una familia mexicana tiene una distribución normal cuya media 
es 651.0853 unidades con desviación estándar de 368.805"
#alns
mean.alns <- 107.89
sd.alns <- 145.76
{
  curve(dnorm(x, mean = mean.alns, sd = sd.alns), from = 0, to = 2000, 
        col='blue', main = "Densidad Normal - alns",
        ylab = "f(x)", xlab = "X")
  abline(v =107.89 , lwd = 0.5, lty = 2)
}

x <- seq(-4, 4, 0.01)*sd.alns + mean.alns
y <- dnorm(x, mean = mean.alns, sd = sd.alns) 

plot(x, y, type = "l", xlab = "X", ylab = "f(x)",
     main = "Densidad de Probabilidad Normal", 
     sub = expression(paste(mu == mean.alns, " y ", sigma == mean.alns)))

integrate(dnorm, lower = x[1], upper = x[length(x)], mean=mean.alns, sd = sd.alns)

"Calcula P(X <= 312): (salario mínimo 2023 frontera, 207 resto país) " 
pnorm(q = 312, mean = mean.alns, sd = sd.alns, lower.tail = TRUE) # 0.2149494

par(mfrow = c(2, 2))
plot(x, y, type = "l", xlab = "", ylab = "")
title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == mean.alns, " y ", sigma == sd.alns)))

polygon(c(min(x), x[x<=312], 312), c(0, y[x<=312], 0), col="red")

"Calcula P(X <= 312): (salario mínimo 2023)" 
pnorm(q = 312, mean = mean.alns, sd = sd.alns, lower.tail = TRUE) #

"Calcula P(0 <= X <= 312):"
pnorm(q = 312, mean = mean.alns, sd = sd.alns) - pnorm(q = 0, mean = mean.alns, sd = sd.alns) #  0.14019

plot(x, y, type = "l", xlab="", ylab="")
title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == mean.alns, " y ", sigma == mean.alns)))

polygon(c(0, x[x>=0 & x<=312], 312), c(0, y[x>=0 & x<=312], 0), col="green")


"Calcula P(X >= 312):"
pnorm(q = 312, mean = mean.alns, sd = sd.alns, lower.tail = FALSE) # 0.821061

plot(x, y, type = "l", xlab="", ylab="")
title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == mean.alns, " y ", sigma == sd.alns)))

polygon(c(312, x[x>=312], max(x)), c(0, y[x>=312], 0), col="blue")

dev.off()

"Como con cualquier otra distribución, también podemos calcular los cuantiles de la 
distribución, es decir podemos encontrar el valor b, tal que P(X <= b) = 0.75:"
b <- qnorm(p = 0.75, mean = mean.alns, sd = sd.alns)
b


### Considerando la siguiente creencia
"La mayoría de las personas afirman que los hogares con menor nivel socioeconómico 
tienden a gastar más en productos no saludables que las personas con mayores 
niveles socioeconómicos y que esto, entre otros determinantes, lleva a que un 
hogar presente cierta inseguridad alimentaria.
Hipótesis
Planteamiento de hipótesis:
Ho: alns_nse5f_bajo <= alns_nse5f_alto 
Ha: alns_nse5f_bajo > alns_nse5f_alto
"
var.test(df.clean[df.clean$nse5f == 'Bajo', "alns"],
         df.clean[df.clean$nse5f == 'Alto', "alns"],
         ratio = 1, alternative = "two.sided")

# El p-value 2.2e-16 < 0.01 Las varianzas son DIFERENTES
t.test(x = df.clean[df.clean$nse5f == 'Bajo', "alns"], y = df.clean[df.clean$nse5f == 'Alto', "alns"],
       alternative = "greater",
       mu = 0, var.equal = FALSE)
"EEE para rechazar la hipótesis nula,es decir que el consumo de nivel socieconómico bajo en alns es mayor al nicel socieconómico alto"



### Hacer otra prueba similar

"
Planteamiento de hipótesis:
  Ho: alns_nse5f_bajo <= alns_nse5f_alto 
Ha: alns_nse5f_bajo > alns_nse5f_alto
"
var.test(df.clean[df.clean$nse5f == 'Bajo' | df.clean$nse5f == 'Medio bajo' | df.clean$nse5f == 'Medio', "alns"],
         df.clean[df.clean$nse5f == 'Medio alto' | df.clean$nse5f == 'Alto', "alns"],
         ratio = 1, alternative = "two.sided")

# El p-value 2.2e-16 < 0.01 Las varianzas son DIFERENTES
t.test(x = df.clean[df.clean$nse5f == 'Bajo' | df.clean$nse5f == 'Medio bajo' | df.clean$nse5f == 'Medio', "alns"], 
       y = df.clean[df.clean$nse5f == 'Medio alto' | df.clean$nse5f == 'Alto', "alns"],
       alternative = "greater",
       mu = 0, var.equal = FALSE)
"EEE para rechazar la hipótesis nula,es decir que el consumo de nivel socieconómico bajo en alns es mayor al nicel socieconómico alto"

################
# En promedio, no existe diferencia en el consumo alns en los 5 grupos.

# Ho: prom_alns_bajo = prom_alns_medio_bajo = prom_alns_medio = prom_alns_medio_alto = prom_alns_alto 
# Ha: AL menos uno es diferente

anova <- aov(df.clean$alns ~ df.clean$nse5f,
             data = df.clean)

summary(anova)

#Nivel de significancia es de  0.01
# p-value =  2e-16 < 0.01
# A nivel de confianza estándar 99%, EEE para rechazar Ho, es decir,
# en promedio, al menos el consumo alns en uno de los grupos es diferente

#################### LRegression

d <- select(df.clean, als, alns, refin, nse5f, IA)
#d <- d %>% mutate( nse5ff = as.integer(nse5f), refinn = as.integer(refin),
#IAA = as.integer(IA)) %>% select(als, alns, refinn, nse5ff, IAA)
View(d)

summary(d)

lr <- glm(IA ~ als + alns + refin + nse5f, data = d, family = "binomial")
summary(lr)
# para interpretar quitar logaritmos
exp(coef(lr))
confint(lr)
pseudo_r2.1 <- (lr$null.deviance - lr$deviance)/lr$null.deviance
pseudo_r2.1


lr2 <- glm(IA ~ alns + refin + nse5f, data = d, family = "binomial")
summary(lr2)
# para interpretar quitar logaritmos
exp(coef(lr2))

pseudo_r2.2 <- (lr2$null.deviance - lr2$deviance)/lr2$null.deviance
pseudo_r2.2
