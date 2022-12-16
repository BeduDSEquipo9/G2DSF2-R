#######################

#Postwork sesión 4#

#######################

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

library(DescTools)
library(ggplot2)

# Cargar el dataframe
#df <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-03/Data/telecom_service.csv")
df <- read.csv("./data/telecom_service.csv")
class(df)   #Id tipo de dato
str(df);    #Identificar structura del dataframe
head(df);   #Leer inicio del datagrama
tail(df);   #leer final del datagrama

dim(df);    #Dimensiones del Objeto 
names(df);  #Etiquetas tags del objeto
length(df); #Longitud del Objeto
View(df);   #Data Viewer
summary(df)

# Estadísticos de tendencia central
summary(df$total_intl_charge)
df.mean <- mean(df$total_intl_charge)
df.sd <- sd(df$total_intl_charge)
df.mode <- Mode(df$total_intl_charge)
df.median <- median(df$total_intl_charge)
df.median; df.mode[1]; df.median 
"Moda = Media = Mediana distribución normal"

# Medidas de dispersión
sd(df$total_intl_charge)
var(df$total_intl_charge)
IQR(df$total_intl_charge)
cuartiles <- quantile(df$total_intl_charge, probs = c(0.25,0.5,0.75))
cuartiles

devstd <- sd(df$total_intl_charge)
varianza <- var(df$total_intl_charge)


# Histogramas
hist(df$total_intl_charge, prob=T, main="Histograma total cargos internacionales")


"Una vez que hayas seleccionado el modelo, realiza lo siguiente:"

"1) Grafica la distribución teórica de la variable aleatoria `total_intl_charge`"

curve(dnorm(x, mean = df.mean , sd = df.sd ),
      from = 0, to = 5,
      col='blue', main = "Densidad Normal:\nDiferente media",
      ylab = "f(x)", xlab = "X")
abline(v = df.mean, lwd = 0.5, lty = 2)

"La distribución normal tiene un papel fundamental en muchas áreas de estudio, ya que, 
de forma natural muchas variables siguen o pueden aproximarse a esta distribución.
Algunos puntos importantes de esta distribución son:
    - Tiene dos parámetros: X~N(Media, SD)
    - Es simétrica y con forma de campana"

"2) ¿Cuál es la probabilidad de que el total de cargos internacionales sea menor a 1.85 usd?"
pnorm(1.85, mean=df.mean, sd=df.sd, lower.tail = T)# [1] 0.1125002
#qnorm(p=0.04996519, mean=df.mean, sd=df.sd)

"3. ¿Cuál es la probabilidad de que el total de cargos internacionales sea mayor a 3 usd?"
pnorm(q = 3, mean = df.mean, sd = df.sd, lower.tail = F) #lower.tail = T (>)
#[1] 0.3773985

"4. ¿Cuál es la probabilidad de que el total de cargos internacionales esté entre 2.35usd y 4.85 usd?"
pnorm(q = 4.85, mean = df.mean, sd = df.sd) - pnorm(q = 2.35, mean = df.mean, sd = df.sd) 
# 0.7060114

"5. Con una probabilidad de 0.48, ¿cuál es el total de cargos internacionales más alto que podría esperar?"
b <- qnorm(p = 0.48, mean = df.mean, sd = df.sd)
b
# [1] 2.726777

# ¿Cuáles son los valores del total de cargos internacionales que dejan exactamente al centro el 80% de probabilidad?
qnorm(p=0.10, mean=df.mean, sd=df.sd)

qnorm(p=0.80, mean=df.mean, sd=df.sd)

liminf<-qnorm(p=0.10, mean=df.mean, sd=df.sd)
liminf;
limsup<-qnorm(p=0.90, mean=df.mean, sd=df.sd)
limsup;

"Probando la secuencia de resultados"
?seq
x <- seq(0.1,0.9,by=.01)
y <- qnorm(x,mean=df.mean, sd=df.sd)
xy=data.frame(x,y)
str(xy)
View(xy)
?plot
plot(xy)
lines(lowess(xy))

