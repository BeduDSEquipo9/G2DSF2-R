# Postwork Sesión 3

#### Objetivo

#- Realizar un análisis descriptivo de las variables de un dataframe

#### Requisitos

#1. R, RStudio
#2. Haber realizado el prework y seguir el curso de los ejemplos de la sesión
#3. Curiosidad por investigar nuevos tópicos y funciones de R

#### Desarrollo



install.packages("DescTools") #Mode
library(DescTools)
library(ggplot2)


"Utilizando el dataframe `boxp.csv` realiza el siguiente análisis descriptivo. No olvides excluir los missing values y transformar las variables a su
tipo y escala correspondiente."
df <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-03/Data/boxp.csv")

str(df) # Visualización de las caracteristicas de las variables

complete.cases(df) # Analizan valores si existen valores faltantes

df_limpio <- df[complete.cases(df),] # Obtenemos un dataset sin datos faltantes


summary(df_limpio)

df_limpio$Categoria <- factor(df_limpio$Categoria) #Se convierte a factor para poder trabajar como valor cuantitativo

#1) Calcula e interpreta las medidas de tendencia central de la variable `Mediciones`

#Media es hacia donde tienden los datos
media_mediciones <- mean (df_limpio$Mediciones)
media_mediciones


# La mitad de los datos 
mediana_mediciones <- median(df_limpio$Mediciones)
mediana_mediciones

moda_mediciones <- Mode(df_limpio$Mediciones) #El valor con mayor frecuencia
moda_mediciones

moda_mediciones[1]  #El valor que mas se repite

moda_mediciones; mediana_mediciones; media_mediciones;

#2) Con base en tu resultado anterior, ¿qué se puede concluir respecto al sesgo de `Mediciones`?
  "El sesgo de la distribución es a la Derecha (moda<mediana<moda), esto quiere decir que los datos estan distribuidos
   a la derecha de la media, "
#3) Calcula e interpreta la desviación estándar y los cuartiles de la distribución de `Mediciones`
sd(df_limpio$Mediciones)
"4) Con ggplot, realiza un histograma separando la distribución de `Mediciones` por `Categoría`
¿Consideras que sólo una categoría está generando el sesgo?" 

# no influye 

g <- ggplot(df_limpio, aes(x = Mediciones, fill = Categoria))  
  
g + geom_histogram(bins=6)+
  labs(title = "Histograma",
       x = "Mediciones",
       y = "Frequency") + 
  theme_classic()
"5) Con ggplot, realiza un boxplot separando la distribución de `Mediciones` por `Categoría` 
y por `Grupo` dentro de cada categoría. ¿Consideras que hay diferencias entre categorías? 
¿Los grupos al interior de cada categoría 
podrían estar generando el sesgo?"

ggplot(df_limpio, aes(x=Categoria, y=Mediciones, fill=Grupo))+
  geom_boxplot()+
  labs(title="Boxplot de mediciones por categoría y grupo")+
  theme_classic()

boxplot(df_limpio$Mediciones ~ df_limpio$Categoria, horizontal = TRUE)
