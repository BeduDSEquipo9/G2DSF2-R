# Postwork Sesión 1.

#### Desarrollo

"El siguiente postwork, te servirá para ir desarrollando habilidades como si se 
tratara de un proyecto que evidencie el progreso del aprendizaje durante el 
módulo, sesión a sesión se irá desarrollando.
A continuación aparecen una serie de objetivos que deberás cumplir, es un 
ejemplo real de aplicación y tiene que ver con datos referentes a equipos de la
liga española de fútbol (recuerda que los datos provienen siempre de diversas 
naturalezas), en este caso se cuenta con muchos datos que se pueden aprovechar, 
explotarlos y generar análisis interesantes que se pueden aplicar a otras áreas.
Siendo así damos paso a las instrucciones:" 

"#1. Del siguiente enlace, descarga los datos de soccer de la temporada 2019/2020 
de la primera división de la liga española: 
https://www.football-data.co.uk/spainm.php"


"#2. Importa los datos a R como un Dataframe. NOTA: No olvides cambiar tu dirección 
de trabajo a la ruta donde descargaste tu archivo"
library(dplyr)

sp1 <- read.csv('C:/Users/gusgu/Documents/Gus/Data An/BEDU -SANTANDER/Etapa 2/R/Sesion 1/SP1.CSV')

class(sp1)
str(sp1)
head(sp1)

"4. Del dataframe que resulta de importar los datos a `R`, 
extrae las columnas que contienen los números de goles anotados por los equipos 
que jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron como
visitante (FTAG); guárdalos en vectores separados"

FTHG <- sp1[6]
FTAG <- sp1[7]


"4. Consulta cómo funciona la función `table` en `R`. Para ello, puedes 
ingresar los comandos `help('table')` o `?table` para leer la documentación."
help(table)

"5. Responde a las siguientes preguntas:
#  a) ¿Cuántos goles tuvo el partido con mayor empate?"

empate <- sp1 %>%
  filter(FTR == "D")  %>% 
  mutate(FTTG = FTHG + FTAG)
max(empate$FTTG)

#Respuesta = 8


#Para observa cual partido fue y que marcador se obtuvo
partido.del.mayor.empate <- sp1 %>%
  select(HomeTeam, AwayTeam, FTR, FTHG, FTAG) %>%
  filter(FTR == "D")  %>% 
  mutate(FTTG = FTHG + FTAG) %>%
  slice(which.max(FTTG))
print(partido.del.mayor.empate)

  
#  b) ¿En cuántos partidos ambos equipos empataron 0 a 0?
empates.acero <- empate[empate$FTHG == 0,]
print(length(empates.acero$FTHG))
# RESPUESTA = 33

"c) ¿En cuántos partidos el equipo local (HG) tuvo la mayor goleada sin dejar 
que el equipo visitante (AG) metiera un solo gol?"

local.en.cero <- subset(sp1, sp1$FTAG == 0)
mayor.goleada.local <- local.en.cero[which.max(local.en.cero$FTHG),]
print(nrow(mayor.goleada.local))
#RESPUESTA = 1 juego 

#  __Notas para los datos de soccer:__ https://www.football-data.co.uk/notes.txt