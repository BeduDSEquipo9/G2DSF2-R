# Script Postwork Sesión 1.

# Desarrollo

#1. Del siguiente enlace, descarga los datos de soccer de la temporada 2019/2020de la primera división de la liga española: https://www.football-data.co.uk/spainm.php

#2. Importa los datos a R como un Dataframe. NOTA: No olvides cambiar tu dirección de trabajo a la ruta donde descargaste tu archivo
sp1 <- read.csv("./data/SP1.csv")
str(sp1);
head(sp1);
class(sp1)
#3. Del dataframe que resulta de importar los datos a `R`, extrae las columnas que contienen los números de goles anotados por los equipos que jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG); guárdalos en vectores separados
FTHG<-sp1$FTHG;#números de goles anotados por los equipos que jugaron en casa
FTAG<-sp1$FTAG;#los goles anotados por los equipos que jugaron como visitante
#4. Consulta cómo funciona la función `table` en `R`. Para ello, puedes ingresar los comandos `help("table")` o `?table` para leer la documentación.
?table
table(FTHG,FTAG)
#5. Responde a las siguientes preguntas:
#  a) ¿Cuántos goles tuvo el partido con mayor empate?
" Marcador 1-1 49 partidos"
#  b) ¿En cuántos partidos ambos equipos empataron 0 a 0?
"Marcador 0-0 33 partido"
#  c) ¿En cuántos partidos el equipo local (HG) tuvo la mayor goleada sin dejar que el equipo visitante (AG) metiera un solo gol?
"Marcador 6-1 1 partido"
#  __Notas para los datos de soccer:__ https://www.football-data.co.uk/notes.txt