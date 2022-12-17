#######################

# Postwork Sesión 1.

#######################

#### Objetivo

"El Postwork tiene como objetivo que practiques los comandos básicos aprendidos 
durante la sesión, de tal modo que sirvan para reafirmar el conocimiento. Recuerda 
que la programación es como un deporte en el que se debe practicar, habrá caídas, 
pero lo importante es levantarse y seguir adelante. Éxito"


#### Desarrollo

#1. Del siguiente enlace, descarga los datos de soccer de la temporada 2019/2020 de la primera división de la liga española: https://www.football-data.co.uk/spainm.php

#2. Importa los datos a R como un Dataframe. NOTA: No olvides cambiar tu dirección de trabajo a la ruta donde descargaste tu archivo
sp1 <- read.csv("./data/SP1.csv")
#sp1 <- read.csv("SP1.csv")

# Después de cargar el dataframe es importante explorar un poco su contenido

class(sp1)  #Identificar tipo de dato que estamos usando
str(sp1);   #Identificar structura del dataframe
head(sp1);  #Leer inicio del datagrama
tail(sp1);  #leer final del datagrama

dim(sp1);   #Dimensiones del Objeto 
names(sp1); #Etiquetas tags del objeto
length(sp1);#Longitud del Objeto

#3. Del dataframe que resulta de importar los datos a `R`, extrae las columnas que contienen los números de goles anotados por los equipos que jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG); guárdalos en vectores separados
# Crear vectores
FTHG <- sp1$FTHG #números de goles anotados por los equipos que jugaron en casa
FTAG <- sp1$FTAG #los goles anotados por los equipos que jugaron como visitante

#4. Consulta cómo funciona la función `table` en `R`. Para ello, puedes ingresar los comandos `help("table")` o `?table` para leer la documentación.
# Costruir tabla de contingencia
?table
(resultados <- table(FTHG,FTAG))

#5. Responde a las siguientes preguntas:
#  a) ¿Cuántos goles tuvo el partido con mayor empate?
"RESPUESTA:
          Mayor empate a 4 goles, total de goles 8"
goals_major  <- 0
for (i in 1:length(FTHG)){
  
  if (FTHG[i] == FTAG[i] & goals_major < FTHG[i]) {
    #print(fthg[i], ftag[i])
    #if (goals_major < fthg[i]){
    goals_major <- FTHG[i]
    #}
  }
}
goals_major

#  b) ¿En cuántos partidos ambos equipos empataron 0 a 0?
"RESPUESTA: 
          En 33 partidos hubo empate a 0 goles"

empates.acero <- empate[empate$FTHG == 0,]
print(length(empates.acero$FTHG))

#  c) ¿En cuántos partidos el equipo local (HG) tuvo la mayor goleada sin dejar que el equipo visitante (AG) metiera un solo gol?
"RESPUESTA:
          1 partido con resultado 6-0"
resultados

count = 0
goles_local_con_visita_0 <- marcador[marcador[,"FTAG"] == 0,"FTHG"]
for(i in goles_local_con_visita_0){
  if(i == max(goles_local_con_visita_0)){
    count = count + 1
  }
}
count
