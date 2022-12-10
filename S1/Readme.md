# Postwork Sesión 1

"El siguiente postwork, te servirá para ir desarrollando habilidades como si se tratara de un proyecto que evidencie el progreso del aprendizaje durante el módulo, sesión a sesión se irá desarrollando.

A continuación aparecen una serie de objetivos que deberás cumplir, es un ejemplo real de aplicación y tiene que ver con datos referentes a equipos de la liga española de fútbol (recuerda que los datos provienen siempre de diversas naturalezas), en este caso se cuenta con muchos datos que se pueden aprovechar, explotarlos y generar análisis interesantes que se pueden aplicar a otras áreas. Siendo así damos paso a las instrucciones:"

##### 1. Del siguiente enlace, descarga los datos de soccer de la temporada 2019/2020 de la primera división de la liga española: <https://www.football-data.co.uk/spainm.php>

-Subdirectorio ./data

##### 2. Importa los datos a R como un Dataframe. NOTA: No olvides cambiar tu dirección de trabajo a la ruta donde descargaste tu archivo

sp1 <- read.csv("./data/SP1.csv")
str(sp1);
head(sp1);
class(sp1)

![DataframeStructure](./assets/PostworkS1i1.png)

##### 3. Del dataframe que resulta de importar los datos a `R`, extrae las columnas que contienen los números de goles anotados por los equipos que jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG); guárdalos en vectores separados

```
FTHG<-sp1$FTHG; #números de goles anotados por los equipos que jugaron en casa
FTAG<-sp1$FTAG; #los goles anotados por los equipos que jugaron como visitante
```

![DataframeDisplay](./assets/PostworkS1i2.png)

##### 4. Consulta cómo funciona la función `table` en `R`. Para ello, puedes ingresar los comandos `help("table")` o `?table` para leer la documentación

```
?table
table(FTHG,FTAG)
```

![TableDisplay](./assets/PostworkS1i3.png)

##### 5. Responde a las siguientes preguntas

a) ¿Cuántos goles tuvo el partido con mayor empate?

- " Marcador 1-1 49 partidos"

![Answer 5a](./assets/PostWorkS1i4-5a.png)
b) ¿En cuántos partidos ambos equipos empataron 0 a 0?

- "Marcador 0-0 33 partido"

![Answer 5b](./assets/PostWorkS1i4-5b.png)
c) ¿En cuántos partidos el equipo local (HG) tuvo la mayor goleada sin dejar que el equipo visitante (AG) metiera un solo gol?

- "Marcador 6-1 1 partido"

![Answer 5c](./assets/PostWorkS1i4-5c.png)

Notas para los datos de soccer: <https://www.football-data.co.uk/notes.txt>>
