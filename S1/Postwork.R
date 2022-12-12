# Postwork Sesión 1.

#### Objetivo

"El Postwork tiene como objetivo que practiques los comandos básicos aprendidos 
durante la sesión, de tal modo que sirvan para reafirmar el conocimiento. Recuerda 
que la programación es como un deporte en el que se debe practicar, habrá caídas, 
pero lo importante es levantarse y seguir adelante. Éxito"

#### Requisitos
#- Concluir los retos
#- Haber estudiado los ejemplos durante la sesión

#### Desarrollo

"El siguiente postwork, te servirá para ir desarrollando habilidades como si se 
tratara de un proyecto que evidencie el progreso del aprendizaje durante el módulo, 
sesión a sesión se irá desarrollando.
A continuación aparecen una serie de objetivos que deberás cumplir, es un ejemplo 
real de aplicación y tiene que ver con datos referentes a equipos de la liga española 
de fútbol (recuerda que los datos provienen siempre de diversas naturalezas), en 
este caso se cuenta con muchos datos que se pueden aprovechar, explotarlos y generar 
análisis interesantes que se pueden aplicar a otras áreas. Siendo así damos paso a las instrucciones:" 
  
#1. Del siguiente enlace, descarga los datos de soccer de la temporada 2019/2020 de la primera división de la liga española: https://www.football-data.co.uk/spainm.php
###YA###

#2. Importa los datos a R como un Dataframe. NOTA: No olvides cambiar tu dirección de trabajo a la ruta donde descargaste tu archivo
sp1 <- read.csv("SP1.csv")

#3. Del dataframe que resulta de importar los datos a `R`, extrae las columnas que contienen los números de goles anotados por los equipos que jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG); guárdalos en vectores separados
fthg <- sp1$FTHG
ftag <- sp1$FTAG

#4. Consulta cómo funciona la función `table` en `R`. Para ello, puedes ingresar los comandos `help("table")` o `?table` para leer la documentación.
###YA###

#5. Responde a las siguientes preguntas:
#  a) ¿Cuántos goles tuvo el partido con mayor empate?
max = 0
for(i in 1:length(fthg)){
  if(fthg[i] == ftag[i] & fthg[i] > max){
    max = fthg[i]
  }
}
max

"o bien, con un dataframe:"

marcador <- cbind(fthg, ftag)
max(marcador[marcador[,"fthg"] == marcador[,"ftag"],])

"EL EMPATE QUE MÁS VECES SE REPITE"
for(i in 0:max(marcador[marcador[,"fthg"] == marcador[,"ftag"],])){
  cat('Empate a ',i,': ',length(marcador[(marcador[,"fthg"] == marcador[,"ftag"]) & (marcador[,"fthg"] == i),"fthg"]),"\n")
}

#  b) ¿En cuántos partidos ambos equipos empataron 0 a 0?
length(marcador[(marcador[,"fthg"] == marcador[,"ftag"]) & (marcador[,"fthg"] == 0),"fthg"])

"o bien:"

sum((marcador[,"fthg"] == 0) & (marcador[,"ftag"] == 0))

#  c) ¿En cuántos partidos el equipo local (HG) tuvo la mayor goleada sin dejar que el equipo visitante (AG) metiera un solo gol?
count = 0
goles_local_con_visita_0 <- marcador[marcador[,"ftag"] == 0,"fthg"]
for(i in goles_local_con_visita_0){
  if(i == max(goles_local_con_visita_0)){
    count = count + 1
  }
}
count

"o bien:"

sum(marcador[marcador[,"ftag"] == 0,"fthg"] == max(marcador[marcador[,"ftag"] == 0,"fthg"]))
#  __Notas para los datos de soccer:__ https://www.football-data.co.uk/notes.txt