# Desarrollo
library(dplyr)
library(DescTools)
library(ggplot2)
library(moments)
" Un centro de salud nutricional está interesado en analizar estadísticamente y 
probabilísticamente los patrones de gasto en alimentos saludables y no 
saludables en los hogares mexicanos con base en su nivel socioeconómico, en si 
el hogar tiene recursos financieros extras al ingreso y en si presenta o no 
inseguridad alimentaria. Además, está interesado en un modelo que le permita 
identificar los determinantes socioeconómicos de la inseguridad alimentaria.

La base de datos es un extracto de la Encuesta Nacional de Salud y Nutrición 
(2012) levantada por el Instituto Nacional de Salud Pública en México. 
La mayoría de las personas afirman que los hogares con menor nivel 
socioeconómico tienden a gastar más en productos no saludables que las personas 
con mayores niveles socioeconómicos y que esto, entre otros determinantes, lleva
a que un hogar presente cierta inseguridad alimentaria.

# La base de datos contiene las siguientes variables:"

# nse5f (Nivel socioeconómico del hogar): 1 "Bajo", 2 "Medio bajo", 3 "Medio",
#                                         4 "Medio alto", 5 "Alto"
# area (Zona geográfica): 0 "Zona urbana", 1 "Zona rural"
# numpeho (Número de persona en el hogar)
# refin (Recursos financieros distintos al ingreso laboral): 0 "no", 1 "sí"
# edadjef (Edad del jefe/a de familia)
# sexoje (Sexo del jefe/a de familia): 0 "Hombre", 1 "Mujer"
# añosedu (Años de educación del jefe de familia)
# IA (Inseguridad alimentaria en el hogar): 0 "No presenta IA", 1 "Presenta IA"
# ln_als (Logaritmo natural del gasto en alimentos saludables)
# ln_alns (Logaritmo natural del gasto en alimentos no saludables)


 df <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-08/Postwork/inseguridad_alimentaria_bedu.csv")
class(df)   #Id tipo de dato
str(df);    #Identificar structura del dataframe
head(df);   #Leer inicio del datagrama
tail(df);   #leer final del datagrama

dim(df);    #Dimensiones del Objeto 
names(df);  #Etiquetas tags del objeto
length(df); #Longitud del Objeto
View(df);   #Data Viewer
 
"1) Plantea el problema del caso 
Una estimación de las inseguridad alimentaria en el hogar, con base en loas 
datos. 

La mayoría de las personas afirman que los hogares con menor nivel 
socioeconómico tienden a gastar más en productos no saludables que las personas 
con mayores niveles socioeconómicos y que esto, entre otros determinantes, lleva
a que un hogar presente cierta inseguridad alimentaria.
Ho: A nse5f <= X (ln_alns>ln_als) IA==1
Ha: A nse5f > X  (ln_alns<ln_als) IA==0 

2)  Realiza un análisis descriptivo de la información 
(Analisis Variable a Variable o todas de golpe)"
varianzas,


df$nse5f<-factor(df$nse5f, labels = c("Bajo","Medio bajo", "Medio", "Medio alto", "Alto"))
df$refin<-factor(df$refin, labels = c("No", "Si"))
df$sexojef<-factor(df$sexojef, labels = c("Hombre", "Mujer"))
df$IA<-factor(df$IA, labels = c("No presenta IA", "Presenta IA")) 
df$
class(df)   #Id tipo de dato
str(df);    #Identificar structura del dataframe
head(df);   #Leer inicio del datagrama
tail(df);   #leer final del datagrama

dim(df);    #Dimensiones del Objeto 
names(df);  #Etiquetas tags del objeto
length(df); #Longitud del Objeto
View(df);   #Data Viewer
complete.cases(df)
sum(complete.cases(df))


freq <- table(df$nse5f)
transform(freq, 
          rel.freq=prop.table(Freq))

ggplot(df, aes(x = nse5f)) +
  geom_bar()

k = ceiling(sqrt(length(df$nse5f)))
ac = (max(df$nse5f)-min(df$nse5f))/k

freq <- table(df$numpeho)
transform(freq, 
          rel.freq=prop.table(Freq))

ggplot(df, aes(x = numpeho)) +
  geom_bar()

k = ceiling(sqrt(length(df$numpeho)))
ac = (max(df$numpeho)-min(df$numpeho))/k

"3) Calcula probabilidades que nos permitan entender el problema en México"
tC: lns ls ingreso IA

"4) Plantea hipótesis estadísticas y concluye sobre ellas para entender el 
problema en México"

"5) Estima un modelo de regresión, lineal o logístico, para identificar los 
determinantes de la inseguridad alimentaria en México"

Logaritmica

betas cruzadas cmparacion de modelos. para obtener modelo MASS::
  m1<-lm(IA ~VAriable de estudio + ...    +e ) 
anova varinzas iguales


"6) 



Escribe tu análisis en un archivo README.MD y tu código en un script de R y 
pública ambos en un repositorio de Github.
Todo tu planteamiento deberá estar correctamente desarrollado y deberás 
analizar e interpretar todos tus resultados para poder dar una conclusión final 
al problema planteado."
