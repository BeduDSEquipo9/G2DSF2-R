###############################################################################
# Postwork sesión 8. Análisis de la Inseguridad Alimentaria en México
###############################################################################
#
# Integrantes:
# Tomás Hernández
# José Luis Rodríguez Gallardo
# Gustavo Gutiérrez
# Isidro Amaro
# Francisco Gómez
# Christian Millán
# 
###############################################################################

# Bibliotecas necesarias para el proyecto
library(dplyr)
library(DescTools)
library(ggplot2)
library(moments)
#install.packages('car')
library('car')
#install.packages('nortest')
library('nortest')


setwd("~/dev/R/s8")
# Lectura del dataset
df <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-08/Postwork/inseguridad_alimentaria_bedu.csv")
# El dataframe df_orig se ocupará en la modelación, pues incluirá las variables con su valor
# numérico original, mientras que df tendrá variables que son factores.
df_orig <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-08/Postwork/inseguridad_alimentaria_bedu.csv")
###############################################################################
# 2. Realiza un análisis descriptivo de la información
###############################################################################

## Primera vista de los datos
names(df)
str(df)
summary(df)
View(df)

"Estos primeros pasos permiten concer la estructura de los datos y un resumen
de estadísticos para cada columna del conjunto de datos"

## Limpieza de los datos

"Después de revisar la estructura, se realiza la conversion de algunas de las 
representaciones de las características de tipo int a factor"

## Conversión de tipos a factor

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
df_orig$als <- exp(df_orig$ln_als) 
df_orig$alns <- exp(df_orig$ln_alns)

## Eliminar NAs

"Se realiza un conteo de el número de NAs por columnas que lo reflejaron en str()"
sum(complete.cases(df)) #20280 vs 40809 obs. el 50% esta incompleto
sum(complete.cases(df$edadjef)) # 35792 Borrar o media o mean
sum(complete.cases(df$sexojef)) # 35818 Borrar o llenar con
sum(complete.cases(df$ln_als))  # 40022 Borrar o llenar??
sum(complete.cases(df$ln_alns)) # 23305 Borrar o llenar??

### Se eliminan todos los registos incompletos
"Se realiza la eliminación de aquellos registros que estan incompletos en cualquier
de las características del conjunto de datos"
df.clean <- df[complete.cases(df),]
df.clean2 <- df_orig[complete.cases(df_orig),]

str(df.clean)
summary(df.clean)

"Nuevamente se realiza un análisis con summary, se concluye que la eliminación
de los NAs no afecta la tendencia de promedios, medianas y cuartiles."


## Exploración de los datos ADES

"Antes de realizar un análisis estadístico es importante realizar una inspección
visual de los datos"

"De acuerdo a la descripción del problema es necesario identificar patrones de 
gatos en alimentos saludables y no saudables, por lo que en primer lugar se realizar
la inspección visal univariable de als y alns"

### Gráficas de cajas 

boxplot(df.clean$ln_als,
        ylab="Unidades gastadas",
        main="Gasto en alimentos saludables")

boxplot(df.clean$ln_alns,
        ylab="Unidades gastadas",
        main="Gasto en alimentos NO saludables")

"Ahora se realiza una visualzación de las variables als y alns con respecto a los factores
destacados por la descripcción del problema:
- Nivel socioeconómico
- Si el hogar cuenta con recursos financieros extra
- Si presenta o no inseguridad alimentaria
"
# Boxplot de Alimentos saludables vs nse5f
ggplot(df.clean, 
       aes(x=nse5f,
           y=ln_als,
           fill=nse5f))+
  geom_boxplot()+
  labs(x="Nivel socioecónomico", 
       y="Unidades gastadas",
       title = "Gastos alimentos saludables segun nivel socieconómico")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

# Boxplot de Alimentos saludables vs refin
ggplot(df.clean, 
       aes(x=refin,
           y=ln_als,
           fill=refin))+
  geom_boxplot()+
  labs(x="Recursos financieros distintos al ingreso laboral", 
       y="Unidades gastadas",
       title = "Gastos alimentos saludables segun recursos financieros distintos al ingreso laboral")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

# Boxplot de Alimentos saludables vs IA
ggplot(df.clean, 
       aes(x=IA,
           y=ln_als,
           fill=IA))+
  geom_boxplot(alpha=0.7)+
  labs(x="Inseguridad Alimentaria en el hogar", 
       y="Unidades gastadas",
       title = "Gastos alimentos saludables segun Inseguridad Alimentaria en el hogar")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

# Alimentos no saludables vs nse5f
ggplot(df.clean, 
       aes(x=nse5f,
           y=ln_alns,
           fill=nse5f))+
  geom_boxplot()+
  labs(x="nivel socieconómico", 
       y="Unidades gastadas",
       title = "Gastos alimentos NO saludables segun nivel socieconómico")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

# Alimentos no saludables vs refin
ggplot(df.clean, 
       aes(x=refin,
           y=ln_alns,
           fill=refin))+
  geom_boxplot()+
  labs(x="Recursos financieros distintos al ingreso laboral", 
       y="Unidades gastadas",
       title = "Gastos alimentos NO saludables segun recursos financieros distintos al ingreso laboral")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

# Alimentos no saludables vs IA
ggplot(df.clean, 
       aes(x=IA,
           y=ln_alns,
           fill=IA))+
  geom_boxplot()+
  labs(x="Inseguridad Alimentaria en el hogar", 
       y="Unidades gastadas",
       title = "Gastos alimentos NO saludables segun Inseguridad Alimentaria en el hogar")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

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

# IA (Inseguridad alimentaria en el hogar)
ggplot(df, aes(x = IA)) +
  geom_bar() +
  labs(x="Inseguridad Aimentaria en el hogar", y="Cantidad de casos",
       title="Inseguridad Alimentaria en el hogar")

# Histograma de als
ggplot(df.clean, 
       aes(als)) +
  geom_histogram()+
  labs(title = "Gasto en alimentos saludables", 
       x = "Gasto en alimentos saludables",
       y = "Unidades gastadas") + 
  theme_classic()

# Histograma acumulado de als
ggplot(df.clean, aes(als)) +
  geom_histogram(aes(y = cumsum(..count..)), bins = 50) + 
  labs(title = "Gasto en alimentos saludables acumulados", 
       x = "Gasto en alimentos saludables",
       y = "Unidades gastadas") + 
  theme_classic()

#### número de clases y el ancho de la clase para alns

k = ceiling(sqrt(length(df.clean$alns)))
ac = (max(df.clean$alns)-min(df.clean$alns))/k
binsss <- seq(min(df.clean$alns), max(df.clean$alns), by = ac)
binsss

# Histograma de alns
hist(df.clean$alns, breaks = binsss, main = "Histograma alns")


#### número de clases y el ancho de la clase para alns con ln
k = ceiling(sqrt(length(df.clean$ln_alns)))
ac = (max(df.clean$ln_alns)-min(df.clean$ln_alns))/k
bins <- seq(min(df.clean$ln_alns), max(df.clean$ln_alns), by = ac)

# Histograma y dnormal para visualizar el ajuste

mean(df.clean$ln_alns)
sd(df.clean$ln_alns)

hist(df.clean$ln_alns, breaks = bins, main = "Histograma ln_alns")
curve(dnorm(x, mean = 4.118845, sd = 1.041476), from = 0, to = 8,
      col='blue', main = "Densidad Normal:\nDiferente media",
      ylab = "f(x)", xlab = "X")

# Histograma alns
ggplot(df.clean, aes(alns)) +
  geom_histogram(bins = 144) + 
  labs(title = "Gasto en alimentos NO saludables", 
       x = "Gasto en alimentos NO saludable",
       y = "Unidades gastadas") + 
  theme_classic()

# Histograma acumulado alns

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

## Tablas de frecuencia y distribución de frecuencias

# Frecuencia relativa de nse5f
freq <- table(df$IA)
freq # Esto se tienen en str()
transform(freq,
          rel.freq=prop.table(Freq)) #frecuencia relativa

###################################
# Medidas descriptivas para ln_als
##################################

## Medidas de tendencia central 
mean(df.clean$ln_als)
median(df.clean$ln_als)
Mode(df.clean$ln_als)
# Medidas de dispersión
var(df.clean$ln_als)
sd(df.clean$ln_als)
#### Coeficiente de variación***
sd(df.clean$ln_als)/mean(df.clean$ln_als) * 100 #si > 25% ->no son homogéneos 56.64 
# Medidad de posición
cuartiles <- quantile(df.clean$ln_als, probs = c(0.25, 0.50, 0.75))
cuartiles
deciles <-quantile(df.clean$ln_als, probs = c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9))
deciles
percentiles <- quantile(df.clean$ln_als, probs = seq(0.01,0.99, by=0.01))
percentiles
# Medidas de forma
skewness(df.clean$ln_als) # #s > 0 Sesgo a la derecha s = 0 Simétrica s < 0 Sesgo a la izquierda
kurtosis(df.clean$ln_als) # #Leptocúrtica k > 3 #Mesocúrtica k = 3 Platocúrtica k < 3

###################################
# Medidas descriptivas para ln_alns
#################################
## Medidas de tendencia central
mean(df.clean$ln_alns)
median(df.clean$ln_alns)
Mode(df.clean$ln_alns)
# Medidas de dispersión
var(df.clean$ln_alns)
sd(df.clean$ln_alns)
#### Coeficiente de variación***
sd(df.clean$ln_alns)/mean(df.clean$ln_alns) * 100 #si > 25% ->no son homogéneos 130.48
# Medidad de posición
cuartiles <- quantile(df.clean$ln_alns, probs = c(0.25, 0.50, 0.75))
cuartiles
deciles <-quantile(df.clean$ln_alns, probs = c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9))
deciles
percentiles <- quantile(df.clean$ln_alns, probs = seq(0.01,0.99, by=0.01))
percentiles

##################################################
# Medidas descriptivas para ln_als X GRUPO
#################################################
## Medidas de tendencia central
## als vs nse
# medias 
(mean.bajo <- mean(df.clean[df.clean$nse5f == 'Bajo', "ln_als"]))
(mean.medio.bajo <- mean(df.clean[df.clean$nse5f == "Medio bajo", "ln_als"]))
(mean.medio <- mean(df.clean[df.clean$nse5f == "Medio", "ln_als"]))
(mean.medio.alto <- mean(df.clean[df.clean$nse5f == "Medio alto", "ln_als"]))
(mean.alto <- mean(df.clean[df.clean$nse5f == 'Alto', "ln_als"]))
# Desviación estándar
(sd.bajo <- sd(df.clean[df.clean$nse5f == 'Bajo', "ln_als"]))
(sd.medio.bajo <- sd(df.clean[df.clean$nse5f == "Medio bajo", "ln_als"]))
(sd.medio <- sd(df.clean[df.clean$nse5f == "Medio", "ln_als"]))
(sd.medio.alto <- sd(df.clean[df.clean$nse5f == "Medio alto", "ln_als"]))
(sd.alto <- sd(df.clean[df.clean$nse5f == 'Alto', "ln_als"]))
# Coeficiente de variación
(cv.bajo <- sd.bajo/mean.bajo * 100) 
(cv.medio.bajo <- sd.medio.bajo/mean.medio.bajo * 100) 
(cv.medio <- sd.medio/mean.medio * 100) 
(cv.medio.alto <- sd.medio.alto/mean.medio.alto * 100) 
(cv.alto <- sd.alto/mean.alto * 100) 

##################################################
# Medidas descriptivas para ln_als X refin
#################################################
## Medidas de tendencia central
# als vs refin
(mean.no <- mean(df.clean[df.clean$refin == 'No', "ln_als"]))
(mean.si <- mean(df.clean[df.clean$refin == "Si", "ln_als"]))
(sd.no <- sd(df.clean[df.clean$refin == 'No', "ln_als"]))
(sd.si <- sd(df.clean[df.clean$refin == "No", "ln_als"]))
(cv.no <- sd.no/mean.no * 100) 
(cv.si <- sd.si/mean.si * 100) 

##################################################
# Medidas descriptivas para ln_als X IA
#################################################
## Medidas de tendencia central
# als vs IA
(mean.no <- mean(df.clean[df.clean$IA == 'No', "ln_als"]))
(mean.si <- mean(df.clean[df.clean$IA == "Si", "ln_als"]))
(sd.no <- sd(df.clean[df.clean$IA == 'No', "ln_als"]))
(sd.si <- sd(df.clean[df.clean$IA == "No", "ln_als"]))
(cv.no <- sd.no/mean.no * 100) 
(cv.si <- sd.si/mean.si * 100) 

##################################################
# Medidas descriptivas para ln_alns X refin
#################################################
## Medidas de tendencia central
# alns vs nse
(median.bajo <- median(df.clean[df.clean$nse5f == 'Bajo', "ln_alns"]))
(median.medio.bajo <- median(df.clean[df.clean$nse5f == "Medio bajo", "ln_alns"]))
(median.medio <- median(df.clean[df.clean$nse5f == "Medio", "ln_alns"]))
(median.medio.alto <- median(df.clean[df.clean$nse5f == "Medio alto", "ln_alns"]))
(median.alto <- median(df.clean[df.clean$nse5f == 'Alto', "ln_alns"]))

(mean.bajo <- mean(df.clean[df.clean$nse5f == 'Bajo', "ln_alns"]))
(mean.medio.bajo <- mean(df.clean[df.clean$nse5f == "Medio bajo", "ln_alns"]))
(mean.medio <- mean(df.clean[df.clean$nse5f == "Medio", "ln_alns"]))
(mean.medio.alto <- mean(df.clean[df.clean$nse5f == "Medio alto", "ln_alns"]))
(mean.alto <- mean(df.clean[df.clean$nse5f == 'Alto', "ln_alns"]))

(mode.bajo <- Mode(df.clean[df.clean$nse5f == 'Bajo', "ln_alns"]))
(mode.medio.bajo <- Mode(df.clean[df.clean$nse5f == "Medio bajo", "ln_alns"]))
(mode.medio <- Mode(df.clean[df.clean$nse5f == "Medio", "ln_alns"]))
(mode.medio.alto <- Mode(df.clean[df.clean$nse5f == "Medio alto", "ln_alns"]))
(mode.alto <- Mode(df.clean[df.clean$nse5f == 'Alto', "ln_alns"]))

(sd.bajo <- sd(df.clean[df.clean$nse5f == 'Bajo', "ln_alns"]))
(sd.medio.bajo <- sd(df.clean[df.clean$nse5f == "Medio bajo", "ln_alns"]))
(sd.medio <- sd(df.clean[df.clean$nse5f == "Medio", "ln_alns"]))
(sd.medio.alto <- sd(df.clean[df.clean$nse5f == "Medio alto", "ln_alns"]))
(sd.alto <- sd(df.clean[df.clean$nse5f == 'Alto', "ln_alns"]))

(cv.bajo <- sd.bajo/mean.bajo * 100) 
(cv.medio.bajo <- sd.medio.bajo/mean.medio.bajo * 100) 
(cv.medio <- sd.medio/mean.medio * 100) 
(cv.medio.alto <- sd.medio.alto/mean.medio.alto * 100) 
(cv.alto <- sd.alto/mean.alto * 100) 

##################################################
# Medidas descriptivas para ln_alns X refin
#################################################
## Medidas de tendencia central
# alns vs refin
(mean.no <- mean(df.clean[df.clean$refin == 'No', "ln_alns"]))
(mean.si <- mean(df.clean[df.clean$refin == "Si", "ln_alns"]))

(sd.no <- sd(df.clean[df.clean$refin == 'No', "ln_alns"]))
(sd.si <- sd(df.clean[df.clean$refin == "No", "ln_alns"]))

(cv.no <- sd.no/mean.no * 100) 
(cv.si <- sd.si/mean.si * 100) 

##################################################
# Medidas descriptivas para ln_alns X IA
#################################################
## Medidas de tendencia central
# alns vs IA
(mean.no <- mean(df.clean[df.clean$IA == 'No', "ln_alns"]))
(mean.si <- mean(df.clean[df.clean$IA == "Si", "ln_alns"]))

(sd.no <- sd(df.clean[df.clean$IA == 'No', "ln_alns"]))
(sd.si <- sd(df.clean[df.clean$IA == "No", "ln_alns"]))

(cv.no <- sd.no/mean.no * 100) 
(cv.si <- sd.si/mean.si * 100) 

###############################
# Histogramas
###############################
# als

k = ceiling(sqrt(length(df.clean$ln_als)))
ac = (max(df.clean$ln_als)-min(df.clean$ln_als))/k
bins <- seq(min(df.clean$ln_als), max(df.clean$ln_als), by = ac)
gasto.als <- cut(df.clean$ln_als, breaks = bins, include.lowest=TRUE, dig.lab = 8)

freq <- table(gasto.als)
freq # Esto se tienen en str()
transform(freq, 
          rel.freq=prop.table(Freq)) #frecuencia relativa

hist(df.clean$ln_als , breaks = bins,
     main = "Histograma de Gasto en Alimentos Saludables", 
     xlab = "Gasto en Alimentos Saludables", ylab = "Frecuencia",
     col = "purple")

# Medidas de forma ln_als
skewness(df.clean$ln_als) # #s > 0 Sesgo a la derecha s = 0 Simétrica s < 0 Sesgo a la izquierda
kurtosis(df.clean$ln_als) # #Leptocúrtica k > 3 #Mesocúrtica k = 3 Platocúrtica k < 3

## alns histograma
k = ceiling(sqrt(length(df.clean$ln_alns)))
ac = (max(df.clean$ln_alns)-min(df.clean$ln_alns))/k
bins <- seq(min(df.clean$ln_alns), max(df.clean$ln_alns), by = ac)
gasto.alns <- cut(df.clean$ln_alns, breaks = bins, include.lowest=TRUE, dig.lab = 8)

freq <- table(gasto.alns)
freq # Esto se tienen en str()
transform(freq, 
          rel.freq=prop.table(Freq)) #frecuencia relativa

hist(df.clean$ln_alns , breaks = bins,
     main = "Histograma de Gasto en Alimentos No Saludables", 
     xlab = "Gasto en Alimentos No Saludables", ylab = "Frecuencia",
     col = "purple")

# Medidas de forma
skewness(df.clean$ln_alns) # #s > 0 Sesgo a la derecha s = 0 Simétrica s < 0 Sesgo a la izquierda
kurtosis(df.clean$ln_alns) # #Leptocúrtica k > 3 #Mesocúrtica k = 3 Platocúrtica k < 3



# Coeficiente de correlación de Pearson
df.select2 <- select(df.clean, numpeho, edadjef, añosedu, als, alns)
corr_matrix <- round(cor(df.select2),4)
corr_matrix

pairs(df.select2)

##############################################################################
# 3. Probabilidades que nos permitan entender el problema en México
##############################################################################

##############################################################################
# 3.1.  Cálculo de probabilidad de que una familia presente o no inseguridad alimentaria.
###############################################################################
## Ensayo de Bernoulli y Distribución normal en IA
# Simulación de un experimento
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

# Graficación del experimento
barplot(table(count)/length(count), 
        main = "Experimento de Bernoulli", 
        xlab = "Simalación de Inseguridad Alimentaria (Bernoulli)",
        names = c("No", "Si"))

# Distribución binomial de IA
binom <- rbinom(n = 111471, size = 10, prob = 0.74)
barplot(table(binom)/length(binom),
        main = "Distribución Binomial", 
        xlab = "Número de familias con Inseguridad Alimentaria en el hogar")

# Medidas obtenidas en el experimento
mean(count)
sd(count)

# DS teórica
sqrt(0.74 * (1-0.74))

# Planteamiento de un supuesto de uso de la distribución binomial

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

##############################################################################
# 3.2.  Cálculo de probabilidad de los gastos en alimentos no saludables de una 
# familia de acuerdo a su nivel socioeconómico.
###############################################################################
## Distribución normal
"El gasto als de una familia mexicana tiene una distribución normal cuya media 
es 593.8028  unidades con desviación estándar de 356.9995"
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


# Cálculo de  medias por nse
mean.bajo.alns <- mean(df.clean[df.clean$nse5f == 'Bajo', "ln_alns"])
mean.medio.bajo.alns <- mean(df.clean[df.clean$nse5f == "Medio bajo", "ln_alns"])
mean.medio.alns <- mean(df.clean[df.clean$nse5f == "Medio", "ln_alns"])
mean.medio.alto.alns <- mean(df.clean[df.clean$nse5f == "Medio alto", "ln_alns"])
mean.alto.alns <- mean(df.clean[df.clean$nse5f == 'Alto', "ln_alns"])

# Cálculo de sd por nse
sd.bajo.alns <- sd(df.clean[df.clean$nse5f == 'Bajo', "ln_alns"])
sd.medio.bajo.alns <- sd(df.clean[df.clean$nse5f == "Medio bajo", "ln_alns"])
sd.medio.alns <- sd(df.clean[df.clean$nse5f == "Medio", "ln_alns"])
sd.medio.alto.alns <- sd(df.clean[df.clean$nse5f == "Medio alto", "ln_alns"])
sd.alto.alns <- sd(df.clean[df.clean$nse5f == 'Alto', "ln_alns"])

"
En México el salario mínimo para 2023 será de $207.00 pesos, se 
plantean las siguientes preguntas
¿Cuál es la probabilidad de que el gasto en alimentos no saludables sea menor 
o igual a medio salario mínimo en cada nivel socioeconómico?
"
" se convierten 103.5 pesos en logaritmo natural "
##### bajo P(X <= 4.63)
x <- seq(-4, 4, 0.01)*sd.bajo.alns + mean.bajo.alns
y <- dnorm(x, mean = mean.bajo.alns, sd = sd.bajo.alns) 

pnorm(q = 4.63, mean = mean.bajo.alns, sd = sd.bajo.alns, lower.tail = TRUE)
plot(x, y, type = "l", xlab = "", ylab = "")
title(main = "Probabilidad P(X <= 4.63) NSE Bajo ", 
      sub = expression(paste(mu == 3.68, ", ", sigma == 0.94, " y ", p == 0.8410548 )))

polygon(c(min(x), x[x<=4.63], 4.63), c(0, y[x<=4.63], 0), col="darkorchid4")
##### medio bajo P(X <= 4.63)
x <- seq(-4, 4, 0.01)*sd.medio.bajo.alns + mean.medio.bajo.alns
y <- dnorm(x, mean = mean.medio.bajo.alns, sd = sd.medio.bajo.alns) 

pnorm(q = 4.63, mean = mean.medio.bajo.alns, sd = sd.medio.bajo.alns, lower.tail = TRUE)
plot(x, y, type = "l", xlab = "", ylab = "")
title(main = "Probabilidad P(X <= 4.63) NSE Medio bajo", 
      sub = expression(paste(mu == 3.09, " , ", sigma == 0.94, " y ", p == 0.7761948)))

polygon(c(min(x), x[x<=4.63], 4.63), c(0, y[x<=4.63], 0), col="royalblue4")

##### medio P(X <= 4.63)
x <- seq(-4, 4, 0.01)*sd.medio.alns + mean.medio.alns
y <- dnorm(x, mean = mean.medio.alns, sd = sd.medio.alns) 

pnorm(q = 4.63, mean = mean.medio.alns, sd = sd.medio.alns, lower.tail = TRUE)
plot(x, y, type = "l", xlab = "", ylab = "")
title(main = "Probabilidad P(X <= 4.63) NSE Medio", 
      sub = expression(paste(mu == 4.05, " , ", sigma == 0.98, " y ", p == 0.7214145)))

polygon(c(min(x), x[x<=4.63], 4.63), c(0, y[x<=4.63], 0), col="seagreen4")

##### medio alto P(X <= 4.63)
x <- seq(-4, 4, 0.01)*sd.medio.alto.alns + mean.medio.alto.alns
y <- dnorm(x, mean = mean.medio.alto.alns, sd = sd.medio.alto.alns) 

pnorm(q = 4.63, mean = mean.medio.alto.alns, sd = sd.medio.alto.alns, lower.tail = TRUE)
plot(x, y, type = "l", xlab = "", ylab = "")
title(main = "Probabilidad P(X <= 4.63) NSE Medio alto", 
      sub = expression(paste(mu == 4.23, " , ", sigma == 1.02, " y ", p == 0.6515184)))

polygon(c(min(x), x[x<=4.63], 4.63), c(0, y[x<=4.63], 0), col="springgreen4")

##### alto P(X <= 4.63)
x <- seq(-4, 4, 0.01)*sd.alto.alns + mean.alto.alns
y <- dnorm(x, mean = mean.alto.alns, sd = sd.alto.alns) 

pnorm(q = 4.63, mean = mean.alto.alns, sd = sd.alto.alns, lower.tail = TRUE)
plot(x, y, type = "l", xlab = "", ylab = "")
title(main = "Probabilidad P(X <= 4.63) NSE Alto", 
      sub = expression(paste(mu == 4.61, " , ", sigma == 1.05, " , ", p == 0.5071862)))

polygon(c(min(x), x[x<=4.63], 4.63), c(0, y[x<=4.63], 0), col="yellow1")

#####################

"Como con cualquier otra distribución, también podemos calcular los cuantiles de la 
distribución, es decir podemos encontrar el valor b, tal que P(X <= b) = 0.75:"
b <- qnorm(p = 0.75, mean = mean.als, sd = sd.als)
b




##############################################################################
# 4. Plantea hipótesis estadísticas y concluye sobre ellas para entender el problema en México
##############################################################################

#Los datos de gasto no son normales, por lo tanto se aproximarán con una t de Student
#require(nortest)  # Se debe tener instalado
lillie.test(df.clean[df.clean$nse5f == 'Alto', "ln_als"])$p.value
lillie.test(df.clean[df.clean$nse5f == 'Bajo', "ln_alns"])$p.value

q1 <- qqnorm(df.clean[df.clean$nse5f == 'Bajo', "alns"], plot.it=FALSE)
q2 <- qqnorm(df.clean[df.clean$nse5f == 'Alto', "alns"], plot.it=FALSE)
plot(range(q1$x, q2$x), range(q1$y, q2$y), type="n", las=1,
     xlab='Theoretical Quantiles', ylab='Sample Quantiles')
points(q1, pch=19)
points(q2, col="red", pch=19)
qqline(df.clean[df.clean$nse5f == 'Bajo', "alns"], lty='dashed')
qqline(df.clean[df.clean$nse5f == 'Alto', "alns"], col="red", lty="dashed")
legend('topleft', legend=c('Bajo', 'Alto'), bty='n',
       col=c('black', 'red'), pch=19)


### Considerando la siguiente creencia
"La mayoría de las personas afirman que los hogares con menor nivel socioeconómico 
tienden a gastar más en productos no saludables que las personas con mayores 
niveles socioeconómicos y que esto, entre otros determinantes, lleva a que un 
hogar presente cierta inseguridad alimentaria."

#Para comprobar si los hogares con menor nivel socioeconómico tienden a gastar más en 
#productos no salubable que las personas con mayor nivel socioeconómico, se plantea el siguiente
#constraste de hipótesis:

"PRUEBA 1
Planteamiento de hipótesis:
Ho: prom_alns_nse5f_bajo >= prom_alns_nse5f_alto 
Ha: prom_ alns_nse5f_bajo < prom_alns_nse5f_alto
"
#Como se van a comparar dos medias, y los datos no son normales si no distribuidos por una t de Student,
#es necesario verificar si las desviaciones estándar de cada grupo son iguales o diferentes en la población:

var.test(df.clean[df.clean$nse5f == 'Bajo', "alns"],
         df.clean[df.clean$nse5f == 'Alto', "alns"],
         ratio = 1, alternative = "two.sided")

#El ratio no es igual a 1, por lo tanto las varianzas son diferentes.
# El p-value 2.2e-16 < 0.01. Las varianzas son DIFERENTES.

t.test(x = df.clean[df.clean$nse5f == 'Bajo', "alns"], y = df.clean[df.clean$nse5f == 'Alto', "alns"],
       alternative = "less",
       mu = 0, var.equal = FALSE)

"Se aplica una prueba T, y resulta que como el valor p es 2.2e-16 < 0.01, EEE para rechazar la hipótesis nula y así la 
diferencia de medias no es igual a cero, por lo tanto, las medias son distintas y, de hecho, la media
del nivel socioenómico bajo es menor. 

Esto indica que, en promedio, y contrario a la creencia popoular, las personas de nivel socioeconómico alto
gastan más en alimentos no saludables en comparación a los de nse bajo!!!"

### La prueba anterior confirma que las personas del nse más bajo gastan, en promedio, más que las del nse más alto en
# alimentos no saludables; tiene mérito ver si agrupando niveles socioeconómicos se sigue manteniendo:


"PRUEBA 2
Planteamiento de hipótesis:
Ho: prom_alns_nse5f_bajo >= prom_alns_nse5f_alto 
Ha: prom_alns_nse5f_bajo < prom_alns_nse5f_alto
"
var.test(df.clean[df.clean$nse5f == 'Bajo' | df.clean$nse5f == 'Medio bajo' | df.clean$nse5f == 'Medio', "alns"],
         df.clean[df.clean$nse5f == 'Medio alto' | df.clean$nse5f == 'Alto', "alns"],
         ratio = 1, alternative = "two.sided")

# El p-value 2.2e-16 < 0.01 Las varianzas son DIFERENTES


t.test(x = df.clean[df.clean$nse5f == 'Bajo' | df.clean$nse5f == 'Medio bajo' | df.clean$nse5f == 'Medio', "alns"], 
       y = df.clean[df.clean$nse5f == 'Medio alto' | df.clean$nse5f == 'Alto', "alns"],
       alternative = "less",
       mu = 0, var.equal = FALSE)

#Pvalue es 2.2e-16 < 0.01, por lo tanto EEE para rechazar la hipótesis nula, e incluso agrupando los nse's, los altos gastan más,
#en promedio, que los bajos en alimentos no saludables.

"EEE para rechazar la hipótesis nula,es decir que el consumo de nivel socieconómico bajo en alns es 
menor al nivel socieconómico alto

Esto SE COMPLEMENTA con lo visto en los análisis de probabilidad, donde se vio que el nse más bajo tiene un mayor probabilidad
de gastar en alns, misma que disminuye conforme aumenta el nse. Esto va acorde a lo observado en la realidad pues es verdad
que los nse tienen acceso más fácil y rápido a alimentos no saludables (pensemos en puestos de garnachas, frituras, etc.)
El NSE bajo es más propenso (tiene más probabilidad) a gastar más en alns pero en realidad son los altos quienes más lo hacen.

No obstante, en la PRÁCTICA y EFECTIVAMENTE, las personas con NSE alto gastan MÁS en alns, en primera porque tienen mayor ingreso y, por tanto,
más dinero disponible para gastar, y además, tienen acceso a cosas más refinadas que NO NECESARIAMENTE son alimentos saludables.
(comidas finas en restaurantes, snacks más elaborados y calóricos, etc.)"


################
#Ahora se analizará si existe evidencia estadística para determinar si, en promedio, el nivel socioeconómico tiene efectos
#sobre el gasto en alimentos no saludables


"PRUEBA 3
Planteamiento de hipótesis:
Ho: prom_alns_bajo = prom_alns_medio_bajo = prom_alns_medio = prom_alns_medio_alto = prom_alns_alto 
Ha: AL menos uno es diferente"

anova <- aov(df.clean2$nse5f ~ df.clean2$alns,
             data = df.clean2)

summary(anova)

#Nivel de significancia es de  0.01
# p-value =  2e-16 < 0.01
# A nivel de confianza estándar 99%, EEE para rechazar Ho, es decir,
# en promedio, el consumo alns en AL MENOS uno de los niveles socioeconómicos es diferente,
# por lo que el nse sí es un factor determinante.


"Tiene mérito analizar si la zona geográfica y los ingresos extra también tienen influencia en el consumo
de alns"

"PRUEBA 4
Planteamiento de hipótesis:
Ho: prom_alns_urbana >= prom_alns_rural 
Ha: prom_alns_urbana < prom_alns_rural "

var.test(df.clean[df.clean$area == 'Urbana', "alns"],
         df.clean[df.clean$area == 'Rural', "alns"],
         ratio = 1, alternative = "two.sided")

# El p-value 2.2e-16 < 0.01 Las varianzas son DIFERENTES


t.test(x = df.clean[df.clean$area == 'Urbana', "alns"], 
       y = df.clean[df.clean$area == 'Rural', "alns"],
       alternative = "less",
       mu = 0, var.equal = FALSE)

#p value = 1, por lo tanto NO EEE para rechazar la hipótesis nula de que en las zonas urbanas gastan más o igual que en 
#las rurales en alimentos no saludables.

anova2 <- aov(df.clean2$alns ~ df.clean2$area,
              data = df.clean2)

summary(anova2)

"La zona geográfica sí influye en el promedio de gasto en alimentos no saludables pues tiene valor p menor a 0.01. Como
se rechaza la hipótesis de igualdad, podemos asegurar que, en promedio, las zonas urbanas gastan MÁS que las rurales.
Hace sentido con el análisis anterior pues en las zonas urbanas viven personas de un mayor nivel socioeconómico." 

"PRUEBA 5
Planteamiento de hipótesis:
Ho: prom_alns_coningreso >= prom_alns_siningreso
Ha: prom_alns_coningreso < prom_alns_siningreso"

var.test(df.clean[df.clean$refin == 'Si', "alns"],
         df.clean[df.clean$refin == 'No', "alns"],
         ratio = 1, alternative = "two.sided")

# El p-value 8.833e-13 < 0.01 Las varianzas son DIFERENTES


t.test(x = df.clean[df.clean$area == 'Urbana', "alns"], 
       y = df.clean[df.clean$area == 'Rural', "alns"],
       alternative = "less",
       mu = 0, var.equal = FALSE)

#p value = 1, por lo tanto NO EEE para rechazar la hipótesis nula de que las personas con ingresos adicionales
#gastan más o igual que en las personas sin ingresos extra en alimentos no saludables.

"PRUEBA 6
Planteamiento de hipótesis:
# Ho: prom_alns_coningreso == prom_alns_siningreso
# Ha: prom_alns_coningreso != prom_alns_siningreso"

anova3 <- aov(df.clean2$alns ~ df.clean2$refin,
              data = df.clean2)

summary(anova3)

#Por su parte, al tener un valor p = 0.136, se concluye que NEE para rechazar la hipótesis nula de igualdad de medias,
# por lo que NEEE para decir que las personas con ingresos extra gastan más en ALNS que quienes no los tienen y por lo tanto
# ésta no sería una variable significativa en el análisis ni determinante en el gasto de ALNS.

"ANALISIS PARA ALS"


"PRUEBA 7
Planteamiento de hipótesis:
Ho: prom_als_nse5f_bajo >= prom_alns_nse5f_alto 
Ha: prom_ als_nse5f_bajo < prom_alns_nse5f_alto
"

var.test(df.clean[df.clean$nse5f == 'Bajo', "als"],
         df.clean[df.clean$nse5f == 'Alto', "als"],
         ratio = 1, alternative = "two.sided")

#El ratio no es igual a 1, por lo tanto las varianzas son diferentes.
# El p-value 2.2e-16 < 0.01. Las varianzas son DIFERENTES.

t.test(x = df.clean[df.clean$nse5f == 'Bajo', "als"], y = df.clean[df.clean$nse5f == 'Alto', "als"],
       alternative = "less",
       mu = 0, var.equal = FALSE)

"Se aplica una prueba T, y resulta que como el valor p es 2.2e-16 < 0.01, EEE para rechazar la hipótesis nula y así la 
diferencia de medias no es igual a cero, por lo tanto, las medias son distintas y, de hecho, la media
del nivel socioenómico bajo es menor. 
Esto indica que, en promedio, las personas de nivel socioeconómico alto
gastan más en alimentos saludables en comparación a los de nse bajo. TIENE SENTIDO CON LA REALIDAD."

#Tiene mérito ver si agrupando niveles socioeconómicos se sigue manteniendo:


"PRUEBA 8
Planteamiento de hipótesis:
Ho: prom_als_nse5f_bajos >= prom_als_nse5f_altos 
Ha: prom_als_nse5f_bajos < prom_als_nse5f_altos
"
var.test(df.clean[df.clean$nse5f == 'Bajo' | df.clean$nse5f == 'Medio bajo' | df.clean$nse5f == 'Medio', "als"],
         df.clean[df.clean$nse5f == 'Medio alto' | df.clean$nse5f == 'Alto', "als"],
         ratio = 1, alternative = "two.sided")

# El p-value 2.2e-16 < 0.01 Las varianzas son DIFERENTES


t.test(x = df.clean[df.clean$nse5f == 'Bajo' | df.clean$nse5f == 'Medio bajo' | df.clean$nse5f == 'Medio', "als"], 
       y = df.clean[df.clean$nse5f == 'Medio alto' | df.clean$nse5f == 'Alto', "als"],
       alternative = "less",
       mu = 0, var.equal = FALSE)

#Pvalue es 2.2e-16 < 0.01, por lo tanto EEE para rechazar la hipótesis nula, e incluso agrupando los nse's, los altos gastan más,
#en promedio, que los bajos en alimentos saludables.

"EEE para rechazar la hipótesis nula,es decir que el consumo de nivel socieconómico bajo en alns es 
menor al nivel socieconómico alto"

################
#Ahora se analizará si existe evidencia estadística para determinar si, en promedio, el nivel socioeconómico tiene efectos
#sobre el gasto en alimentos saludables

"PRUEBA 9
Planteamiento de hipótesis:
Ho: prom_als_bajo = prom_als_medio_bajo = prom_als_medio = prom_als_medio_alto = prom_als_alto 
Ha: AL menos uno es diferente"

anova4 <- aov(df.clean2$nse5f ~ df.clean2$als,
              data = df.clean2)

summary(anova4)

#Nivel de significancia es de  0.01
# p-value =  2e-16 < 0.01
# En promedio, SÍ existe diferencia en el consumo als en los 5 grupos.
# A nivel de confianza estándar 99%, EEE para rechazar Ho, es decir,
# en promedio, el consumo als en AL MENOS uno de los niveles socioeconómicos es diferente
# por lo que el nse sí es un factor determinante.


"Tiene mérito analizar si la zona geográfica y los ingresos extra también tienen influencia en el consumo
de als"

"PRUEBA 10
Planteamiento de hipótesis:
Ho: prom_als_urbana >= prom_als_rural 
Ha: prom_als_urbana < prom_als_rural "

var.test(df.clean[df.clean$area == 'Urbana', "als"],
         df.clean[df.clean$area == 'Rural', "als"],
         ratio = 1, alternative = "two.sided")

# El p-value 2.2e-16 < 0.01 Las varianzas son DIFERENTES


t.test(x = df.clean[df.clean$area == 'Urbana', "als"], 
       y = df.clean[df.clean$area == 'Rural', "als"],
       alternative = "less",
       mu = 0, var.equal = FALSE)

#p value = 1, por lo tanto NO EEE para rechazar la hipótesis nula de que en las zonas urbanas gastan más o igual que en 
#las rurales en alimentos no saludables.

anova5 <- aov(df.clean2$als ~ df.clean2$area,
              data = df.clean2)

summary(anova5)

"La zona geográfica sí influye en el promedio de gasto en alimentos no saludables pues tiene valor p menor a 0.01. Como
se rechaza la hipótesis de igualdad, podemos asegurar que, en promedio, las zonas urbanas gastan MÁS que las rurales.
Hace sentido con el análisis anterior pues en las zonas urbanas viven personas de un mayor nivel socioeconómico y tienen
acceso más fácilmente a alimentos saludables." 

"PRUEBA 11
Planteamiento de hipótesis:
Ho: prom_als_coningreso >= prom_als_siningreso
Ha: prom_als_coningreso < prom_als_siningreso"

var.test(df.clean[df.clean$refin == 'Si', "als"],
         df.clean[df.clean$refin == 'No', "als"],
         ratio = 1, alternative = "two.sided")

# El p-value 9.447e-12 < 0.01 Las varianzas son DIFERENTES


t.test(x = df.clean[df.clean$area == 'Urbana', "als"], 
       y = df.clean[df.clean$area == 'Rural', "als"],
       alternative = "less",
       mu = 0, var.equal = FALSE)

#p value = 1, por lo tanto NO EEE para rechazar la hipótesis nula de que las personas con ingresos adicionales
#gastan más o igual que en las personas sin ingresos extra en alimentos saludables.

"PRUEBA 12
Planteamiento de hipótesis:
Ho: prom_alns_coningreso == prom_alns_siningreso
Ha: prom_alns_coningreso != prom_alns_siningreso"

anova6 <- aov(df.clean2$als ~ df.clean2$refin,
              data = df.clean2)

summary(anova6)

"Por su parte, al tener un valor p = 9.75e-09 < 0.01, se concluye que sí EEE para rechazar la hipótesis nula de igualdad de medias,
por lo que EEE para decir que las personas con ingresos extra, en promedio, gastan más ALS que quienes no los tienen 

De este modo, existe evidencia para pensar que las personas con ingresos extra prefieren gastar esos ingresos en 
alimentos saludables que en no saludables."
#SI INFLUYE, ENTRE OTROS FACTORES, EN LA INSEGURIDAD ALIMENTARIA




##############################################################################
# 5. Estima un modelo de regresión, lineal o logístico, para identificar los
#determinantes de la inseguridad alimentaria en México
##############################################################################

#Como se busca entender qué factores influyen en la inseguridad alimentaria (IA), se define IA como variable objetivo"
attach(df.clean2)
y = df.clean2$IA
#install.packages('car')
library('car')
# Al ser una variable dicotómica, no se puede usar una regresión lineal, si no una logística. Para ello, se comienza con un
# modelo base, usando las variables disponibles

logistic.1 <- glm(y ~ nse5f + area + numpeho + refin + edadjef + sexojef 
                  + añosedu + als + alns, data = df.clean2, family = binomial)

# Se prueba un modelo general, que incluya tanto las variables individuales como todos los términos de interacción posibles
logistic.2 <- glm(y ~ nse5f + area + numpeho + refin + edadjef + sexojef + añosedu + als + alns 
                  + numpeho:refin + añosedu:refin + edadjef:refin + als:refin + alns:refin + nse5f:refin + area:refin + sexojef:refin
                  + numpeho:area + añosedu:area + edadjef:area + als:area + alns:area + nse5f:area + sexojef:area
                  + numpeho:sexojef + añosedu:sexojef + edadjef:sexojef + als:sexojef + alns:sexojef + nse5f:sexojef 
                  + numpeho:nse5f + añosedu:nse5f + edadjef:nse5f + als:nse5f + alns:nse5f, 
                  data = df.clean2, family = binomial)

# Modelo con todas las variables individuales, pero sólo incluye términos de interacción con refin
logistic.3 <- glm(y ~ nse5f + area + numpeho + refin + sexojef + edadjef 
                  + añosedu + als + alns + numpeho:refin + añosedu:refin + edadjef:refin
                  + als:refin + alns:refin + nse5f:refin + area:refin + sexojef:refin, data = df.clean2, family = binomial)

# Modelo con todas las variables individuales, pero sólo incluye términos de interacción con area
logistic.4 <- glm(y ~ nse5f + area + numpeho + refin + sexojef + edadjef 
                  + añosedu + als + alns + numpeho:area + añosedu:area + edadjef:area
                  + als:area + alns:area + nse5f:area + refin:area + sexojef:area, data = df.clean2, family = binomial)

# Modelo con todas las variables individuales, pero sólo incluye términos de interacción con sexojef
logistic.5 <- glm(y ~ nse5f + area + numpeho + refin + sexojef + edadjef 
                  + añosedu + als + alns + numpeho:sexojef + añosedu:sexojef + edadjef:sexojef
                  + als:sexojef + alns:sexojef + nse5f:sexojef + refin:sexojef + area:sexojef, data = df.clean2, family = binomial)

# Modelo con todas las variables individuales, pero sólo incluye términos de interacción con nse5f
logistic.6 <- glm(y ~ nse5f + area + numpeho + refin + sexojef + edadjef 
                  + añosedu + als + alns + numpeho:nse5f + añosedu:nse5f + edadjef:nse5f
                  + als:nse5f + alns:nse5f + sexojef:nse5f + refin:nse5f + area:nse5f, data = df.clean2, family = binomial)


# Se mantendrán únicamente los términos estadísticamente significativos, es decir, cuyo coeficiente (estadísticamente)
# sea mayor que cero.

logistic.7 <- glm(y ~ numpeho + refin + edadjef + sexojef + añosedu + als + alns 
                  + numpeho:area 
                  + añosedu:sexojef + edadjef:sexojef
                  + añosedu:nse5f + edadjef:nse5f, data = df.clean2, family = binomial)

# Se modela usando las variables originales de als y alns
logistic.8 <- glm(y ~ numpeho + refin + edadjef + sexojef + añosedu + ln_als + ln_alns 
                  + numpeho:area 
                  + añosedu:sexojef + edadjef:sexojef
                  + añosedu:nse5f + edadjef:nse5f, data = df.clean2, family = binomial)

# Como el modelo 7 tiene problemas de multicolinealidad, se elimina el término sexojef y la interacción edadjef:sexojef
# Se prueban modelos eliminando términos e interacciones para ver cuál genera mejores métricas
logistic.9 <- glm(y ~ numpeho + refin + edadjef  + añosedu + als + alns 
                  + numpeho:area 
                  + añosedu:sexojef
                  + añosedu:nse5f + edadjef:nse5f, data = df.clean2, family = binomial)

logistic.10 <- glm(y ~ numpeho + refin + edadjef + añosedu + als + alns 
                   + numpeho:area 
                   + añosedu:sexojef + edadjef:sexojef
                   + añosedu:nse5f + edadjef:nse5f, data = df.clean2, family = binomial)

logistic.11 <- glm(y ~ numpeho + refin + añosedu + als + alns 
                   + numpeho:area 
                   + añosedu:sexojef + edadjef:sexojef
                   + añosedu:nse5f + edadjef:nse5f, data = df.clean2, family = binomial)

logistic.12 <- glm(y ~ numpeho + refin + edadjef + añosedu + ln_als + ln_alns 
                   + numpeho:area 
                   + añosedu:sexojef + edadjef:sexojef
                   + añosedu:nse5f + edadjef:nse5f, data = df.clean2, family = binomial)


summary(logistic.1)
summary(logistic.2)
summary(logistic.3)
summary(logistic.4)
summary(logistic.5)
summary(logistic.6)
summary(logistic.7)
summary(logistic.8)
summary(logistic.9)
summary(logistic.10)
summary(logistic.11)
summary(logistic.12)


pseudo_r2.1 <- (logistic.1$null.deviance - logistic.1$deviance)/logistic.1$null.deviance
pseudo_r2.1

pseudo_r2.2 <- (logistic.2$null.deviance - logistic.2$deviance)/logistic.2$null.deviance
pseudo_r2.2

pseudo_r2.3 <- (logistic.3$null.deviance - logistic.3$deviance)/logistic.3$null.deviance
pseudo_r2.3

pseudo_r2.4 <- (logistic.4$null.deviance - logistic.4$deviance)/logistic.4$null.deviance
pseudo_r2.4

pseudo_r2.5 <- (logistic.5$null.deviance - logistic.5$deviance)/logistic.5$null.deviance
pseudo_r2.5

pseudo_r2.6 <- (logistic.6$null.deviance - logistic.6$deviance)/logistic.6$null.deviance
pseudo_r2.6

pseudo_r2.7 <- (logistic.7$null.deviance - logistic.7$deviance)/logistic.7$null.deviance
pseudo_r2.7

pseudo_r2.8 <- (logistic.8$null.deviance - logistic.8$deviance)/logistic.8$null.deviance
pseudo_r2.8

pseudo_r2.9 <- (logistic.9$null.deviance - logistic.9$deviance)/logistic.9$null.deviance
pseudo_r2.9

pseudo_r2.10 <- (logistic.10$null.deviance - logistic.10$deviance)/logistic.10$null.deviance
pseudo_r2.10

pseudo_r2.11 <- (logistic.11$null.deviance - logistic.11$deviance)/logistic.11$null.deviance
pseudo_r2.11

pseudo_r2.12 <- (logistic.12$null.deviance - logistic.12$deviance)/logistic.12$null.deviance
pseudo_r2.12


# El AIC del modelo 7 es el menor de todos, incluso en comparación al modelo 8. Asimismo tiene mayor 
# bondad de ajuste. A pesar de que la bondad de ajuste del modelo 7 es menor que el del 2, la diferencia es muy
# pequeña, y como AIC es menor, se mantendrá el modelo 7 como el mejor.
# Sin embargo, tiene problemas de multicolinealidad pues sale un vif mayor que 10.

vif(logistic.7, type="predictor")

# Así, se elige el modelo 10 como el mejor, pues pese a que tanto el AIC como la bondad de ajuste son menores, la diferencia
# es muy pequeña y no se considera significativa

anova(logistic.7,logistic.10)


## Validación de supuestos de la regresión logística

# a) Multicolinealidad
#step(logistic.10, direction = "backward")
vif(logistic.10, type="predictor")

#Al no haber VIF mayores que 10, se considera que no existe multicolinealidad

# b) Independencia
Indice <- seq(1,20280,1)
Residuales <- logistic.10$residuals
residuales <- data.frame(Indice, Residuales)
ggplot(data = residuales, aes(x = Indice, y = Residuales)) +
  geom_point() +
  ggtitle("Residuales del modelo ajustado") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5))


# El gráfico de dispersión permite observar más residuos positivos que negativos, sin embargo, 
# los puntos se distribuyen de manera homogénea y no se observa ningún patrón aparente que pudiera 
# indicar un grado de dependencia entre las observaciones.

#logodds <- logistic.10$linear.predictors
#boxTidwell(logodds ~ df.clean2$edadjef)


# c) Linealidad
# Para contrastar este supuesto necesitamos ejecutar la regresión logística pero 
# incluyendo como predictores las iteraciones entre cada predictor y el logaritmo de sí mismo
df.clean2$numpeho_area <- df.clean2$numpeho * df.clean2$area
df.clean2$añosedu_sexojef <- df.clean2$añosedu * df.clean2$sexojef
df.clean2$edadjef_sexojef <- df.clean2$edadjef * df.clean2$sexojef
df.clean2$añosedu_nse5f <- df.clean2$añosedu * df.clean2$nse5f
df.clean2$edadjef_nse5f <- df.clean2$edadjef * df.clean2$nse5f

df.clean2$log_numpeho_area <- df.clean2$numpeho_area * log(df.clean2$numpeho_area)
df.clean2$log_añosedu_sexojef <- df.clean2$añosedu_sexojef * log(df.clean2$añosedu_sexojef)
df.clean2$log_edadjef_sexojef <- df.clean2$edadjef_sexojef * log(df.clean2$edadjef_sexojef)
df.clean2$log_añosedu_nse5f <- df.clean2$añosedu_nse5f * log(df.clean2$añosedu_nse5f)
df.clean2$log_edadjef_nse5f <- df.clean2$edadjef_nse5f * log(df.clean2$edadjef_nse5f)
df.clean2$log_numpeho <- df.clean2$numpeho * log(df.clean2$numpeho)
df.clean2$log_refin <- df.clean2$refin * log(df.clean2$refin)
df.clean2$log_edadjef <- df.clean2$edadjef * log(df.clean2$edadjef)
df.clean2$log_añosedu <- df.clean2$añosedu * log(df.clean2$añosedu)
df.clean2$log_als <- df.clean2$als * log(df.clean2$als)
df.clean2$log_alns <- df.clean2$alns * log(df.clean2$alns)

linealidad <- glm(y ~ numpeho + refin + añosedu + als + alns  
                  + log_numpeho + log_refin  + log_añosedu + log_als + log_alns
                  , data = df.clean2, family = binomial())
summary(linealidad)

# Sólo son de interés los términos de las iteraciones. Cualquier iteración que sea significativa 
# quiere decir que el efecto principal ha violado el supuesto de linealidad del logaritmo.
# En este caso, como ningún término de iteración es significativo, no hay evidencia de que se viole la linealidad.


# Ahora, se calculan los momios correspondientes:
#Si el valor es mayor que 1, entonces indica que a medida que aumenta el predictor, las probabilidades de los resultados aumentan
#A la inversa, un valor menor que 1 indica que a medida que aumenta el predictor, las probabilidades de los resultados disminuyen
exp(logistic.10$coefficients)


# Por último, se calculan intervalos de confianza para los predictores:
exp(confint(logistic.10))

#Lo importante de este intervalo de confianza es que no cruza 1 (los valores en cada extremo del intervalo son mayores que 1).
#Esto es fundamental porque valores mayores que 1 significan que a medida que la variable predictora aumenta, 
#también lo hacen las probabilidades de que el hogar caiga en Insuficiencia alimentaria.
