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

#1. Del siguiente enlace, descarga los datos de soccer de la temporada 2019/2020 de la primera división de la liga española: https://www.football-data.co.uk/spainm.php

#2. Importa los datos a R como un Dataframe. NOTA: No olvides cambiar tu dirección de trabajo a la ruta donde descargaste tu archivo
sp1 <- read.csv("SP1.csv")

#3. Del dataframe que resulta de importar los datos a `R`, extrae las columnas que contienen los números de goles anotados por los equipos que jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG); guárdalos en vectores separados
# Crear vectores
FTHG <- sp1$FTHG#casa
FTAG <- sp1$FTAG#visitante

#4. Consulta cómo funciona la función `table` en `R`. Para ello, puedes ingresar los comandos `help("table")` o `?table` para leer la documentación.
# Costruir tabla de contingencia
(resultados <- table(FTHG,FTAG))

#5. Responde a las siguientes preguntas:
#  a) ¿Cuántos goles tuvo el partido con mayor empate?
Mayor empate a 4 goles 8
#  b) ¿En cuántos partidos ambos equipos empataron 0 a 0?
33
#  c) ¿En cuántos partidos el equipo local (HG) tuvo la mayor goleada sin dejar que el equipo visitante (AG) metiera un solo gol?
1 resultado 6-0


# ¿Cuántos goles tuvo el partido con mayor empate?

# 49 partidos con marcador de (1-1)
(table(FTHG,FTAG)==1) & nrow(table(FTHG,FTAG))==ncol(table(FTHG,FTAG))

which(resultados == 1, arr.ind = TRUE)

# ¿En cuántos partidos ambos equipos empataron 0 a 0?
# 33 partidos
resultados[1,1]
which(resultados == max(resultados),arr.ind = F)-1


# ¿En cuántos partidos el equipo local (HG) tuvo la mayor goleada sin dejar que el equipo visitante (AG) metiera un solo gol?
# Un partido (6-1)
max(FTHG)
resultados[max(FTHG)+1,FTAG=1]
m.3 > 8 & m.3 < 13

resultados > max(FTHG)+1
resultados == 1 & resultados == max(dim(resultados)-1)
max(dim(resultados)-1)

wich(resultados[max(dim(resultados)),1]==1,arr.ind = TRUE)
which(resultados == 1, arr.ind = T, useNames = F)

#
#marginal filas
prop.table(resultados, margin=1)
#marginal columna
prop.table(resultados, margin=2)
#conjunta
prop.table(resultados, margin=NULL)
addmargins(resultados)
