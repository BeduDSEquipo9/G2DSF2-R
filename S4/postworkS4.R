# Postwork Sesión 4

# Desarrollo
library(DescTools)
library(ggplot2)
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

"Utilizando la variable `total_intl_charge` de la base de datos 
`telecom_service.csv` de la sesión 3, realiza un análisis probabilístico. 
Para ello, debes determinar la función de distribución de probabilidad que más 
se acerque el comportamiento de los datos.
Hint: Puedes apoyarte de medidas descriptivas o técnicas de visualización."
# Medidas de tendencia central
summary(df$total_intl_charge)
mean(df$total_intl_charge)
median(df$total_intl_charge)
Mode(df$total_intl_charge)

media <- mean(df$total_intl_charge)
mediana <- median(df$total_intl_charge)
moda <- Mode(df$total_intl_charge)
# Medidas de dispersión
sd(df$total_intl_charge)
var(df$total_intl_charge)
IQR(df$total_intl_charge)
cuartiles <- quantile(df$total_intl_charge, probs = c(0.25,0.5,0.75))
cuartiles

devstd <- sd(df$total_intl_charge)
varianza <- var(df$total_intl_charge)

# Histogramas

# A 4 Columnas
ggplot(df, aes(df$total_intl_charge)) +
  geom_histogram(bins = 4) + 
  labs(title = "Histograma", 
       x = "Cargos Internacionales",
       y = "Frequency") + 
  theme_classic()

# A 10 Columnas
ggplot(df, aes(df$total_intl_charge)) +
  geom_histogram(bins = 10) + 
  labs(title = "Histograma", 
       x = "Cargos Internacionales",
       y = "Frequency") + 
  theme_classic()

#Histograma
hist(df$total_intl_charge, main = "Histograma Total Int Charges, Distribución simétrica")

"Una vez que hayas seleccionado el modelo, realiza lo siguiente:"

"1) Grafica la distribución teórica de la variable aleatoria `total_intl_charge`"

curve(dnorm(x, mean = media, sd = devstd),  from=0, to=5.400, 
      col='blue', main = "Densidad Normal",
      xlab = "total_intl_charge")

"La distribución normal tiene un papel fundamental en muchas áreas de estudio, ya que, 
de forma natural muchas variables siguen o pueden aproximarse a esta distribución.

Algunos puntos importantes de esta distribución son:
    - Tiene dos parámetros: X~N(Media, SD)
    - Es simétrica y con forma de campana"

"2) ¿Cuál es la probabilidad de que el total de cargos internacionales sea menor a 1.85 usd?"
pnorm(1.85, mean=media, sd=devstd)

"3) ¿Cuál es la probabilidad de que el total de cargos internacionales sea mayor a 3 usd?"
pnorm(3, mean=media, sd=devstd, lower.tail=FALSE)

"4) ¿Cuál es la probabilidad de que el total de cargos internacionales esté entre 2.35usd y 4.85 usd?"
pnorm(4.85, mean=media, sd=devstd) - pnorm(2.35, mean=media, sd=devstd)

"5) Con una probabilidad de 0.48, ¿cuál es el total de cargos internacionales más alto que podría esperar?"
qnorm(p=0.48, mean=media, sd=devstd)

"6) ¿Cuáles son los valores del total de cargos internacionales que dejan exactamente al centro el 80% de probabilidad?"
qnorm(p=0.80, mean=media, sd=devstd)

liminf<-qnorm(p=0.10, mean=media, sd=devstd)
liminf;
limsup<-qnorm(p=0.90, mean=media, sd=devstd)
limsup;
liminf;limisup




