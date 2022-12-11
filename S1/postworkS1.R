# Postwork Sesión 1.

Christian Millán

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
  
#1. Del siguiente enlace, descarga los datos de soccer de la temporada 2019/2020
#de la primera división de la liga española: https://www.football-data.co.uk/spainm.php

#2. Importa los datos a R como un Dataframe. NOTA: No olvides cambiar tu dirección
#de trabajo a la ruta donde descargaste tu archivo
sp1 <- read.csv("SP1.csv")
# Después de cargar el dataframe es importante explorar un poco su contenido
str(sp1)
View(sp1)
names(sp1)
#4. Del dataframe que resulta de importar los datos a `R`, extrae las columnas 
#que contienen los números de goles anotados por los equipos que jugaron en casa
#(FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG); 
#guárdalos en vectores separados
fthg <- sp1$FTHG
fthg
ftag <- sp1$FTAG
ftag

#4. Consulta cómo funciona la función `table` en `R`. Para ello, puedes ingresar
#los comandos `help("table")` o `?table` para leer la documentación.
help("table")

#5. Responde a las siguientes preguntas:
#  a) ¿Cuántos goles tuvo el partido con mayor empate?
goals_major  <- 0
for (i in 1:length(fthg)){
 
  if (fthg[i] == ftag[i] & goals_major < fthg[i]) {
    #print(fthg[i], ftag[i])
    #if (goals_major < fthg[i]){
      goals_major <- fthg[i]
    #}
  }
}
goals_major

#  b) ¿En cuántos partidos ambos equipos empataron 0 a 0?
count_tie  <- 0
for (i in 1:length(fthg)){
  if (fthg[i] == ftag[i] & fthg[i] == 0) {
    #if (fthg[i] == 0){
      count_tie <- count_tie + 1
    #}
  }
}
count_tie # 33

#  c) ¿En cuántos partidos el equipo local (HG) tuvo la mayor goleada sin dejar 
#que el equipo visitante (AG) metiera un solo gol?

# Primero extraemos las mayores goleadas de cada equipo como local
unique.names <- unique(sp1$HomeTeam)
major.goals.home <- matrix(0, length(unique.names), 2)
home.teams <- sp1$HomeTeam

for (i in 1:length(unique.names)) {
  for (j in 1:length(home.teams)) {
    if( (unique.names[i] == home.teams[j]) & 
        fthg[j] > major.goals.home[i,1] &
        fthg[j] > ftag[j]){
      major.goals.home[i, 1] <- fthg[j]
      major.goals.home[i, 2] <- ftag[j]
      #print(major.goals.home[i,1])
    }
  }
}
major.goals.home

# Contamos aquellos partidos donde el equipo visitante no anotó goles.
count.major.goals <-0
for (i in 1:length(unique.names)) {
  if(major.goals.home[i,2] == 0){
    count.major.goals <- count.major.goals + 1
  }
}
count.major.goals # 8
  
#  __Notas para los datos de soccer:__ https://www.football-data.co.uk/notes.txt
