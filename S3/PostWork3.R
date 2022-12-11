# Postwork Sesión 3

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
# Leer base de datos
df <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-03/Data/boxp.csv")

# Excluir datos faltantes
df <- na.omit(df)
summary(df)
str(df)

# Transformar variables necesarias en factores
df$Categoria <- factor(df$Categoria)
df$Grupo <- factor(df$Grupo)
summary(df)

#1) Calcula e interpreta las medidas de tendencia central de la variable `Mediciones`
library(DescTools)
Mode(df$Mediciones); median(df$Mediciones); mean(df$Mediciones)

#2) Con base en tu resultado anterior, ¿qué se puede concluir respecto al sesgo de `Mediciones`?


#3) Calcula e interpreta la desviación estándar y los cuartiles de la distribución de `Mediciones`
sd(df$Mediciones) # La medición tiene una dispersión promedio, respecto a la media, de 53.7697

quantile(df$Mediciones, probs = c(0.25, 0.50, 0.75))
# 25% de los diamantes tienen una medición de 23.45 o menos
# 50% de los diamantes tienen una medición de 49.40 o menos
# 75% de los diamantes tienen una medición de 82.85 o menos

"4) Con ggplot, realiza un histograma separando la distribución de `Mediciones` por `Categoría`
¿Consideras que sólo una categoría está generando el sesgo?"
ggplot(df, aes(x=Mediciones, fill=Categoria)) + 
  geom_histogram(bins = 10, alpha=0.5)

"5) Con ggplot, realiza un boxplot separando la distribución de `Mediciones` por `Categoría` 
y por `Grupo` dentro de cada categoría. ¿Consideras que hay diferencias entre categorías? 
¿Los grupos al interior de cada categoría 
podrían estar generando el sesgo?"

ggplot(df, aes(x=Categoria, y=Mediciones, fill=Grupo)) + 
  geom_boxplot() +
  theme_classic()