#######################

# Postwork Sesión 3

#######################

#### Objetivo

#- Realizar un análisis descriptivo de las variables de un dataframe

#### Requisitos

#1. R, RStudio
#2. Haber realizado el prework y seguir el curso de los ejemplos de la sesión
#3. Curiosidad por investigar nuevos tópicos y funciones de R

#### Desarrollo
library(dplyr)
library(ggplot2)
library(DescTools)
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
df.clean <- df[complete.cases(df),]

"Aplicando factor para transformar las variables"
df$Categoria<-factor(df$Categoria)
summary(df)
df$Grupo<-factor(df$Grupo)
summary(df)


# Transformar variables necesarias en factores
df$Categoria <- factor(df$Categoria)
df$Grupo <- factor(df$Grupo)
summary(df)

#1) Calcula e interpreta las medidas de tendencia central de la variable `Mediciones`

Mode(df$Mediciones); median(df$Mediciones); mean(df$Mediciones)
# Existen datos atíípicos en la derecha de las mediciones. 
#Dado que mode < mediana < media los datos estan sesgados a la derecha.

#2) Con base en tu resultado anterior, ¿qué se puede concluir respecto al sesgo de `Mediciones`?
#Está sesgado a la derecha porque la moda es MENOR a la mediana y la mediana MENOR a la media

#3) Calcula e interpreta la desviación estándar y los cuartiles de la distribución de `Mediciones`
sd(df$Mediciones) # La medición tiene una dispersión promedio, respecto a la media, de 53.7697

quantile(df$Mediciones, probs = c(0.25, 0.50, 0.75))
# 25% de los diamantes tienen una medición de 23.45 o menos
# 50% de los diamantes tienen una medición de 49.40 o menos
# 75% de los diamantes tienen una medición de 82.85 o menos

"4) Con ggplot, realiza un histograma separando la distribución de `Mediciones` por `Categoría`
¿Consideras que sólo una categoría está generando el sesgo?"
#No, todas las categorias tienen un Sesgo similar

ggplot(df, aes(x=Mediciones, fill=Categoria)) + 
  geom_histogram(bins = 10, alpha=0.5)

deciles <-quantile(df$Mediciones, probs = c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9))
deciles

gplot(df, aes(x = Mediciones, fill = Categoria)) + 
  geom_histogram(bins=10)+
  labs(title = "Histograma",
       x = "Mediciones",
       y = "Frequency"
  ) + theme_classic()

"5) Con ggplot, realiza un boxplot separando la distribución de `Mediciones` por `Categoría` 
y por `Grupo` dentro de cada categoría. 
¿Consideras que hay diferencias entre categorías? 
Del grupo 1 no jhay mucha diferencia, pero el grupo 0 sí
¿Los grupos al interior de cada categoría podrían estar generando el sesgo?"
"Sí, ya que hay algunos cambios en sus medias muy marcados con excepción de la categoría 1"

ggplot(df, aes(x=Categoria, y=Mediciones, fill=Grupo)) + 
  geom_boxplot() +
  theme_classic()

