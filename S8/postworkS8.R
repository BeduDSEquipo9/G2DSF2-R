############  POSTWORK 8 #####################

library(DescTools)
library(ggplot2)
library(dplyr)
library(moments)

######### Carga del DataSet ###################

df<-read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-08/Postwork/inseguridad_alimentaria_bedu.csv")

str(df)


############Limpieza de Datos ###########################

casos_completos <- complete.cases(df)
sum(casos_completos)

df_clean <- df[casos_completos,]

str(df_clean)


df_clean2 <- df_clean

######################Tranformación de Datos #################


df_clean2$nse5f <-  factor(df_clean2$nse5f, levels= c(1,2,3,4,5), ordered=TRUE)
df_clean2$nse5f <-  factor(df_clean2$nse5f, labels=c("Bajo", "Medio Bajo", "Medio", "Medio alto", "Alto" ))

df_clean2$area <-factor(df_clean$area,labels=c("Zona Urbana", "Zona Rural"))

df_clean2$refin <-factor(df_clean$refin, labels = c("no","si"))

df_clean2$sexojef <-factor(df_clean$sexojef, labels = c("Hombre","Mujer"))

df_clean2$IA <-factor(df_clean$IA, labels = c("No Presenta IA","Presenta IA"))

str(df_clean2)

df_clean2_slogaritmo <- df_clean2 %>%
                       select (nse5f,area,numpeho,refin,edadjef, sexojef,añosedu,IA,ln_als,ln_alns)%>%
                       mutate(als = 10**ln_als, alns=10**ln_alns)


summary(df_clean2)
summary(df_clean2_slogaritmo)


##################### 2. Análisis Descriptivo  ############################


####### Análisis de variables cualitativas  ##########


##### Variable Nivel Socioeconomico en el Hogar #######################
freqNivel <- table(df_clean2$nse5f)
freqNivel

transform(freqNivel, 
          rel.freq=prop.table(Freq))

ggplot(df_clean2, aes(x = nse5f)) +
  geom_bar()

##### Variable Zona Geografica #######################
freqZona <- table(df_clean2$area)
freqZona

transform(freqZona, 
          rel.freq=prop.table(Freq))

ggplot(df_clean2, aes(x = area)) +
  geom_bar()


##### Variable Recursos Financieros distintos al ingreso Laboral #######################
freqRfin <- table(df_clean2$refin)
freqRfin

transform(freqRfin, 
          rel.freq=prop.table(Freq))

ggplot(df_clean2, aes(x = refin)) +
  geom_bar()


##### Variable Inseguridad alimentaria en el hogar #######################
freqIa <- table(df_clean2$IA)
freqIa

transform(freqIa, 
          rel.freq=prop.table(Freq))

ggplot(df_clean2, aes(x = IA)) +
  geom_bar()


####### Análisis de variables Cuantitativas  ##########

#### Calculo del Número de Clases y el ancho de la clase #######

k = ceiling(sqrt(length(df_clean2$ln_als)))
ac = (max(df_clean2$ln_als)-min(df_clean2$ln_als))/k

bins <- seq(min(df_clean2$ln_als), max(df_clean2$ln_als), by = ac)

gastos_alim_salu_clases <- cut(df_clean2$ln_als, breaks = bins, include.lowest=TRUE, dig.lab = 8)


k2 = ceiling(sqrt(length(df_clean2$ln_alns)))
ac2 = (max(df_clean2$ln_alns)-min(df_clean2$ln_alns))/k

bins2 <- seq(min(df_clean2$ln_alns), max(df_clean2$ln_alns), by = ac)

gastos_alim_Nsalu_clases <- cut(df_clean2$ln_alns, breaks = bins2, include.lowest=TRUE, dig.lab = 8)


##### Creación de las Tablas de Distribución ############

dist_gastos_salu<- table(gastos_alim_salu_clases)
dist_gastos_salu

transform(dist_gastos_salu, 
          rel.freq=prop.table(Freq), 
          cum.freq=cumsum(prop.table(Freq)))



hist(x=df_clean$ln_als, main = "Histograma de frecuencias Gastos Alimentarios Saludables", # Frecuencia
     ylab = "Frecuencia")
grid(nx = NA, ny = NULL, lty = 2, col = "gray", lwd = 1)
hist(x=df_clean$ln_als, add=TRUE, col = "red")


boxplot(df_clean$ln_als, horizontal = TRUE)

hist(x=df_clean$ln_als, prob=TRUE, main = "Histograma de densidad Gastos Alimentarios Saludables", 
     ylab = "Densidad")




dist_gastos_Nsalu<- table(gastos_alim_Nsalu_clases)
dist_gastos_Nsalu

transform(dist_gastos_Nsalu, 
          rel.freq=prop.table(Freq), 
          cum.freq=cumsum(prop.table(Freq)))



hist(x=df_clean$ln_alns, main = "Histograma de frecuencias Gastos Alimentarios No Saludables", # Frecuencia
     ylab = "Frecuencia")
grid(nx = NA, ny = NULL, lty = 2, col = "gray", lwd = 1)
hist(x=df_clean$ln_alns, add=TRUE, col = "yellow")


boxplot(df_clean$ln_alns, horizontal = TRUE)



hist(x=df_clean$ln_alns, prob=TRUE, main = "Histograma de densidad Gastos Alimentarios No Saludables", 
     ylab = "Densidad")



##### Histograma de las dos variables Gastos Alimentarios Saludables y 

### Gastos Alimentarios no Saludables ################


hist(df_clean$ln_als, main = "Histograma de frecuencias de Las dos Variables", # Frecuencia
     ylab = "Frecuencia")
hist(df_clean$ln_alns, add = TRUE, col = rgb(1, 0, 0, alpha = 0.5))



######################### Todos los Histogramas #############################

{par(mfrow=c(1,3))
  
  hist(x=df_clean$ln_als, main = "Histograma de frecuencias Gastos Alimentarios Saludables", # Frecuencia
       ylab = "Frecuencia")
  grid(nx = NA, ny = NULL, lty = 2, col = "gray", lwd = 1)
  hist(x=df_clean$ln_als, add=TRUE, col = "red")
  
  hist(x=df_clean$ln_alns, main = "Histograma de frecuencias Gastos Alimentarios No Saludables", # Frecuencia
       ylab = "Frecuencia")
  grid(nx = NA, ny = NULL, lty = 2, col = "gray", lwd = 1)
  hist(x=df_clean$ln_alns, add=TRUE, col = "yellow")
  
  hist(df_clean$ln_als, main = "Histograma de frecuencias de Las dos Variables", # Frecuencia
       ylab = "Frecuencia")
  hist(df_clean$ln_alns, add = TRUE, col = rgb(1, 0, 0, alpha = 0.5))
  
}

dev.off()
############## Medidas de Tendencia Central ######################

### Media de variable Gastos Alimenticios Saludables #####################
promedioGAS <- mean(df_clean2$ln_als)

### Mediana de variable Gastos Alimenticios Saludables #####################
mediaGAS->median(df_clean2$ln_als)

### Moda de variable Gastos Alimenticios Saludables

Mode(df_clean2$ln_als)
Mode(df_clean2$ln_als)[1]



### Media de variable Gastos Alimenticios No Saludables #####################
promedioGANS <- mean(df_clean2$ln_alns)

### Mediana de variable Gastos Alimenticios No Saludables #####################
medianaGANS <- median(df_clean2$ln_alns)

### Moda de variable Gastos Alimenticios No Saludables

Mode(df_clean2$ln_alns)
Mode(df_clean2$ln_alns)[1]


############## Medidas de Dispersión ######################


### Varianza variable Gastos Alimenticios Saludables #####################
varGAS <- var(df_clean2$ln_als)

### Desviación estandar de variable Gastos Alimenticios Saludables #####################
sdGAS <- sd(df_clean2$ln_als)


### Dispersión de la variable Gastos Alimenticios Saludables alrededor de la Media #####################

IQR(df_clean2$ln_als)

quantile(df_clean2$ln_alns, probs = 0.75) - quantile(df_clean2$ln_alns, probs = 0.25)




### Varianza variable Gastos Alimenticios No Saludables #####################
varGANS <- var(df_clean2$ln_alns)

### Desviación estandar de variable Gastos Alimenticios No Saludables #####################
sdGANS <- sd(df_clean2$ln_alns)


### Dispersión de la variable Gastos Alimenticios No Saludables alrededor de la Media #####################

IQR(df_clean2$ln_alns)

quantile(df_clean2$ln_alns, probs = 0.75) - quantile(df_clean2$ln_alns, probs = 0.25)


###### # Medidas de posición (CuaNtiles)  variable Gastos Alimenticios Saludables #####


cuartilesGAS <- quantile(df_clean2$ln_als, probs = c(0.25, 0.50, 0.75))
cuartilesGAS


decilesGAS <-quantile(df_clean2$ln_als, probs = c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9))
decilesGAS

percentilesGAS <- quantile(df_clean2$ln_als, probs = seq(0.01,0.99, by=0.01))
percentilesGAS



###### # Medidas de posición (CuaNtiles)  variable Gastos No Alimenticios Saludables #####


cuartilesGANS <- quantile(df_clean2$ln_alns, probs = c(0.25, 0.50, 0.75))
cuartilesGANS


decilesGANS <-quantile(df_clean2$ln_alns, probs = c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9))
decilesGANS

percentilesGANS <- quantile(df_clean2$ln_alns, probs = seq(0.01,0.99, by=0.01))
percentilesGANS

# Medidas de forma variable Gastos Alimenticios Saludables #####

#s > 0 Sesgo a la derecha
#s = 0 Simétrica
#s < 0 Sesgo a la izquierda

skewness(df_clean2$ln_als) #Sesgo a la Izquierda
skewness(df_clean2$ln_alns)#Sesgo a la Derecha  

#Leptocúrtica k > 3
#Mesocúrtica k = 3
#Platocúrtica k < 3

kurtosis(df_clean2$ln_als)  #LeptoCurtica
kurtosis(df_clean2$ln_alns)  #LeptoCurtica

##################### 3. probabilidades que nos permitan entender el problema en México ############################

################### La distribución de la variable aleatoria  #########################
curve(dnorm(x, mean = promedioGAS, sd = sdGAS), from=0, to=10, 
      col='blue', main = "Densidad de Probabilidad Normal",
      ylab = "f(x)", xlab = "X")


hist(df_clean2$ln_als, freq = FALSE, main = "Curva densidad", ylab = "Densidad")
lines(density(df_clean2$ln_als), lwd = 2, col = 'red')


# Distribución Teorica

hist(df_clean2$ln_als, prob=T, main="Histogramas de Gastos Alimenticios Saludables")

curve(dnorm(x, mean = promedioGAS, sd = sdGAS), from=0, to=10, 
      col='blue', main = "Densidad de Probabilidad Normal",
      ylab = "f(x)", xlab = "X")


# Probabilidad P( ln_als<= 6)

d_normal <- pnorm(q=6, mean=promedioGAS, sd = sdGAS, lower.tail = TRUE)
d_normal

q_normal <- qnorm(p=0.3901862, mean=promedioGAS, sd = sdGAS)
q_normal


# Probabilidad P(ln_als >= 8)

d_normal <- pnorm(q=8, mean=promedioGAS, sd = sdGAS, lower.tail = FALSE)
d_normal

q_normal <- qnorm(p=0.004322172, mean=promedioGAS, sd = sdGAS)
q_normal


#Probabilidad P(6<=ln_als<=8)

d_normal <- pnorm(q=8, mean=promedioGAS, sd = sdGAS) - pnorm(q=6, mean=promedioGAS, sd = sdGAS)
d_normal

q_normal <- qnorm(p=0.6054916, mean=promedioGAS, sd = sdGAS)
q_normal



