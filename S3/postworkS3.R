# Postwork Sesión 3

#Desarrollo
library(dplyr)
library(DescTools)
library(ggplot2)
library(moments)

"Utilizando el dataframe `boxp.csv` realiza el siguiente análisis descriptivo. 
No olvides excluir los missing values y transformar las variables a su
tipo y escala correspondiente."
#df <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-03/Data/boxp.csv")
df <- read.csv("./data/boxp.csv")

class(df)   #Id tipo de dato
str(df);    #Identificar structura del dataframe
head(df);   #Leer inicio del datagrama
tail(df);   #leer final del datagrama

dim(df);    #Dimensiones del Objeto 
names(df);  #Etiquetas tags del objeto
length(df); #Longitud del Objeto
View(df);   #Data Viewer
summary(df)

complete.cases(df) #Return a logical vector indicating which cases are complete, i.e., have no missing values.
sum(complete.cases(df)) #
"df[Complete.cases(df),] vs na.omit(df)"
df <- df[complete.cases(df),]
df.1 <- na.omit(df);
"Comparando ambos resultados"
head(df)
tail(df)
df.1
head(df.1)
tail(df.1)
"Nos quedamos con df, analizando el daraframe ya limpio"
class(df)   #Id tipo de dato
str(df);    #Identificar structura del dataframe
head(df);   #Leer inicio del datagrama
tail(df);   #leer final del datagrama

dim(df);    #Dimensiones del Objeto 
names(df);  #Etiquetas tags del objeto
length(df); #Longitud del Objeto
View(df);   #Data Viewer
summary(df)
"Recuerda y compara los resultados antes de procesar el dataframe "
complete.cases(df) #Return a logical vector indicating which cases are complete, i.e., have no missing values.
sum(complete.cases(df)) #

"Aplicando factor para transformar las variables"
df$Categoria<-factor(df$Categoria)
summary(df)
df$Grupo<-factor(df$Grupo)
summary(df)

"1) Calcula e interpreta las medidas de tendencia central de la variable `Mediciones`
Ayuda:?mean"
# Medidas de tendencia central
mean(df$Mediciones)
median(df$Mediciones)
Mode(df$Mediciones)

meanMediciones<-mean(df$Mediciones);
medianMediciones<-median(df$Mediciones);
modeMediciones<-Mode(df$Mediciones);

#2) Con base en tu resultado anterior, ¿qué se puede concluir respecto al sesgo de `Mediciones`?

#3) Calcula e interpreta la desviación estándar y los cuartiles de la distribución de `Mediciones`
# Medidas de dispersión
var(df$Mediciones)
sd(df$Mediciones)
IQR(df$Mediciones)
cuartiles <- quantile(df$Mediciones, probs = c(0.25,0.5,0.75))
cuartiles

"4) Con ggplot, realiza un histograma separando la distribución de `Mediciones` por `Categoría` ¿Consideras que sólo una categoría está generando el sesgo?"

ggplot(df, aes(df$Mediciones)) +
  geom_histogram(bins = 4) + 
  labs(title = "Histograma", 
       x = "Mediciones",
       y = "Frequency") + 
  theme_classic()

ggplot(df, aes(x = Mediciones, fill = Categoria)) + 
  geom_histogram(bins=4)+
  labs(title = "Histograma",
       x = "Mediciones",
       y = "Frequency"
  ) + theme_classic()


deciles <-quantile(df$Mediciones, probs = c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9))
deciles

ggplot(df, aes(df$Mediciones)) +
  geom_histogram(bins = 10) + 
  labs(title = "Histograma", 
       x = "Mediciones",
       y = "Frequency") + 
  theme_classic()

ggplot(df, aes(x = Mediciones, fill = Categoria)) + 
    geom_histogram(bins=10)+
    labs(title = "Histograma",
        x = "Mediciones",
        y = "Frequency"
        ) + theme_classic()

"5) Con ggplot, realiza un boxplot separando la distribución de `Mediciones` por `Categoría` 
y por `Grupo` dentro de cada categoría. 
¿Consideras que hay diferencias entre categorías?
¿Los grupos al interior de cada categoría podrían estar generando el sesgo?"
boxplot(df$Mediciones ~ df$Categoria , horizontal = TRUE)
boxplot(df$Mediciones ~ df$Grupo , horizontal = TRUE)

