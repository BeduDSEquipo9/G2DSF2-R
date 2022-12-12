# Postwork Sesión 3

#### Objetivo

#- Realizar un análisis descriptivo de las variables de un dataframe

#### Requisitos

#1. R, RStudio
#2. Haber realizado el prework y seguir el curso de los ejemplos de la sesión
#3. Curiosidad por investigar nuevos tópicos y funciones de R

#### Desarrollo

"Utilizando el dataframe `boxp.csv` realiza el siguiente análisis descriptivo.
No olvides excluir los missing values y transformar las variables a su tipo y 
escala correspondiente."
df <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-03/Data/boxp.csv")
library(dplyr)
library(DescTools)
library(ggplot2)
library(moments)

"1) Calcula e interpreta las medidas de tendencia central de la variable `Mediciones`"
#Primero analizamos la estructura y el resumen:
str(df)
summary(df)
#El sumary arroja que hay 24 NAs
#analizar si la info esta correcta y completa
complete.cases(df)
sum(complete.cases(df))
#Limpiar la base de datos
df.clean <- df[complete.cases(df),]

#Calcular medidas de tendencia central
Mode(df.clean$Mediciones); median(df.clean$Mediciones); mean(df.clean$Mediciones)


"2) Con base en tu resultado anterior, ¿qué se puede concluir respecto al sesgo 
de `Mediciones`?"
#Está sesgado a la derecha porque la moda es MENOR a la mediana y la mediana MENOR a la media

"3) Calcula e interpreta la desviación estándar y los cuartiles de la 
distribución de `Mediciones`"

sd(df.clean$Mediciones)
cuartiles <- quantile(df.clean$Mediciones, probs = c(0.25,0.5,0.75))
cuartiles


"4) Con ggplot, realiza un histograma separando la distribución de `Mediciones` 
por `Categoría`
¿Consideras que sólo una categoría está generando el sesgo?"
#No, todas las categorias tienen un Sesgo similar

ggplot(df.clean, aes(x = Mediciones, fill = Categoria)) + 
  geom_histogram(bins=6)+
  labs(title = "Histograma",
       x = "Mediciones",
       y = "Frequency") + 
  theme_classic()

"5) Con ggplot, realiza un boxplot separando la distribución de `Mediciones` por `Categoría` 
y por `Grupo` dentro de cada categoría. ¿Consideras que hay diferencias entre categorías? ¿Los grupos al interior de cada categoría 
podrían estar generando el sesgo?"
boxplot(df.clean$Mediciones ~ df.clean$Categoria, horizontal = TRUE)
