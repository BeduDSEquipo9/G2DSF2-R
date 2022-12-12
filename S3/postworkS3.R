# Postwork Sesión 3
# Christian Millán
#### Objetivo

#- Realizar un análisis descriptivo de las variables de un dataframe

#### Requisitos

#1. R, RStudio
#2. Haber realizado el prework y seguir el curso de los ejemplos de la sesión
#3. Curiosidad por investigar nuevos tópicos y funciones de R

#### Desarrollo
library(DescTools)

"Utilizando el dataframe `boxp.csv` realiza el siguiente análisis descriptivo. No olvides excluir los missing values y transformar las variables a su
tipo y escala correspondiente."
df <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-03/Data/boxp.csv")
str(df)
summary(df)

View(df)

df$Categoria <- factor(df$Categoria)
df$Grupo <- factor(df$Grupo, labels = c("No", "Si"))

sum(complete.cases(df))

df.clean <- df[complete.cases(df),]

str(df.clean)
sum(complete.cases(df.clean))
#1) Calcula e interpreta las medidas de tendencia central de la variable `Mediciones`
mean(df.clean$Mediciones)
median(df.clean$Mediciones)
Mode(df.clean$Mediciones)
# Existen datos atíípicos en la derecha de las mediciones. 
#Dado que mode < mediana < media los datos estan sesgados a la derecha.

#2) Con base en tu resultado anterior, ¿qué se puede concluir respecto al sesgo de `Mediciones`?
# Dado que mode < mediana < media los datos estan sesgados a la derecha.


#3) Calcula e interpreta la desviación estándar y los cuartiles de la distribución de `Mediciones`

sd(df.clean$Mediciones)

cuartiles <- quantile(df.clean$Mediciones, probs = c(0.25, 0.50, 0.75))
cuartiles
# La desviación estándar 53.7698 esta cerca de la media
# El 25% de los datos tienen como máximo una medida de 23.45
# El 50% de los datos tienen como máximo una medida de 49.30
# EL 75% de los datos tienen como máximo una medida de 82.85

"4) Con ggplot, realiza un histograma separando la distribución de `Mediciones` por `Categoría`
¿Consideras que sólo una categoría está generando el sesgo?"
library(ggplot2)

ggplot(df.clean, aes(x=Mediciones, color=(Categoria)))+
  geom_histogram()+
  labs(x="Mñediciones", y="Frecuenci de la medición",
       title="Frec mediciones")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

ggplot(df.clean, aes(x=Mediciones, color=(Categoria)))+
  geom_histogram(fill="white", alpha=0.5, position="identity")+
  labs(x="Mñediciones", y="Frecuenci de la medición",
       title="Frec mediciones")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

"5) Con ggplot, realiza un boxplot separando la distribución de `Mediciones` por `Categoría` 
y por `Grupo` dentro de cada categoría. ¿Consideras que hay diferencias entre categorías? ¿Los grupos al interior de cada categoría 
podrían estar generando el sesgo?"

ggplot(df.clean, 
       aes(x = Mediciones,
           y = Categoria,
           fill = Grupo))+
  geom_boxplot(alpha = 0.6)+
  labs(x = "Mediciones", 
       y = "Categoria",
       title = "CAtegoria y mediciones")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())
