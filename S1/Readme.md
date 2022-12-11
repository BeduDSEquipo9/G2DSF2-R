# Poswork Sesión 1

### **Objetivo**

El Postwork tiene como objetivo que practiques los comandos básicos aprendidos durante la sesión, de tal modo que sirvan para reafirmar el conocimiento. Recuerda que la programación es como un deporte en el que se debe practicar, habrá caídas, pero lo importante es levantarse y seguir adelante. Éxito

### **Requisitos**

- Concluir los retos
- Haber estudiado los ejemplos durante la sesión

### **Desarrollo**

El siguiente postwork, te servirá para ir desarrollando habilidades como si se tratara de un proyecto que evidencie el progreso del aprendizaje durante el módulo, sesión a sesión se irá desarrollando.

A continuación aparecen una serie de objetivos que deberás cumplir, es un ejemplo real de aplicación y tiene que ver con datos referentes a equipos de la liga española de fútbol (recuerda que los datos provienen siempre de diversas naturalezas), en este caso se cuenta con muchos datos que se pueden aprovechar, explotarlos y generar análisis interesantes que se pueden aplicar a otras áreas. Siendo así damos paso a las instrucciones:

1. Del siguiente enlace, descarga los datos de soccer de la temporada 2019/2020 de la primera división de la liga española: [https://www.football-data.co.uk/spainm.php](https://www.football-data.co.uk/spainm.php)
2. Importa los datos a R como un Dataframe
    
    ```r
    sp1 <- read.csv("SP1.csv")
    ```
    
    Después de cargar el dataframe es importante explorar un poco su contenido:
    
    ```r
    str(sp1)
    View(sp1)
    names(sp1)
    ```
    
    Con `str` exploramos la estructura del dataset en la consola para conocer el número de observaciones y el tipo de variable utilizado en cada variable, con `view`, se puden visualizar los datos tipo hoja de cálculo y con `names` conocer el nombre de cada variable.
    
3. Del dataframe que resulta de importar los datos a `R`, extrae las columnas que contienen los números de goles anotados por los equipos que jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG); guárdalos en vectores separados
    
    ```r
    fthg <- sp1$FTHG
    ftag <- sp1$FTAG
    ```
    
4. Consulta cómo funciona la función `table` en `R`. Para ello, puedes ingresar los comandos `help("table")` o `?table` para leer la documentación.
    
    ```r
    help("table")
    ```
    
5. Responde a las siguientes preguntas: 
    1. ¿Cuántos goles tuvo el partido con mayor empate? 
        
        ```r
        goals_major  <- 0
        for (i in 1:length(fthg)){
          if (fthg[i] == ftag[i] & goals_major < fthg[i]) {
              goals_major <- fthg[i]
          }
        }
        goals_major # 4
        ```
        
        La respuesta es: 4 goles por equipo en el partido Villa Real contra Granada. 
        
    2. ¿En cuántos partidos ambos equipos empataron 0 a 0? 
        
        ```r
        count_tie  <- 0
        for (i in 1:length(fthg)){
          if (fthg[i] == ftag[i] & fthg[i] == 0) {
            count_tie <- count_tie + 1
          }
        }
        count_tie # 33
        ```
        
        En 33 partidos el marcador quedo 0 - 0. 
        
    3. En cuántos partidos el equipo local (HG) tuvo la mayor goleada sin dejar que el equipo visitante (AG) metiera un solo gol?
        
        ```r
        count_major_goals  <- 0
        for (i in 1:length(fthg)){
          if (fthg[i] != ftag[i] & ftag[i] == 0) {
              count_major_goals <- count_major_goals + 1
          }
        }
        count_major_goals # 103
        ```
        
        En 103 partidos el marcador quedo a favor del equipo local, sin haber ninguna anotación por parte del equipo visitante.

## Conclusión

En este postwork se reforzarón los cocimiento adquiridos para:

* El uso de datasets en formato `csv`.
* Concer datos generales de un dataset con `str` y `view`.
* Utilizar `help` para obtener ayuda sobre cualquier función en R.
* El uso de estructuras de datos: vectores y matrices
* El uso de ciclos `for` y condicionales `if`, `if-else`
* El uso operadores lógicos y condicionales.