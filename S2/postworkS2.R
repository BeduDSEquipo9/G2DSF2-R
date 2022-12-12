# Postwork Sesión 2.

# Desarrollo

# Librerias 

"dplyr es una de las librarías más utilizadas en R y forma parte de la familia 
de librerías de tidyverse.

La librería dplyr contiene diversas funciones para la manipulación y transformación 
de DataFrames, las cuales son muy intuitivas de aplicar ya que librería utiliza 
verbos para la ejecución de acciones"
library(dplyr); #Observar algunas características y manipular los DataFrames con `dplyr`

"Ggplot es otra librería bastante popular de Tidyverse, y al mismo tiempo una de 
las más utilizadas en R para realizar visualizaciones de datos.

La lógica de ggplot es realizar álgebra de gráficas, ya que cada elemento de la 
gráfica se va sumando de forma secuencial hasta obtener la gráfica final.

Una gráfica en ggplot debe contener al menos 3 elementos:
  - Datos: El Data set que se va a graficar
  - Estéticos: La escala sobre la cual vamos a mapear los datos
  - Geometrías: La forma en que se visualizarán los datos"
library(ggplot2);#Para realizar visualizaciones con `ggplot`

# Conocer algunas de las bases de datos disponibles en `R`
# 1) Inspecciona el DataSet iris_meaniris` disponible directamente en R. Identifica las variables que contiene y su tipo, asegúrate de que no hayan datos faltantes y que los datos se encuentran listos para usarse.

class(iris)   #Id tipo de dato
str(iris);    #Identificar structura del dataframe
head(iris);   #Leer inicio del datagrama
tail(iris);   #leer final del datagrama

dim(iris);    #Dimensiones del Objeto 
names(iris);  #Etiquetas tags del objeto
length(iris); #Longitud del Objeto
View(iris);   #Data Viewer

complete.cases(iris) #Return a logical vector indicating which cases are complete, i.e., have no missing values.
sum(complete.cases(iris)) #

# 2) Crea una gráfica de puntos que contenga `Sepal.Lenght` en el eje horizontal, `Sepal.Width` en el eje vertical, que identifique `Species` por color y que el tamaño de la figura está representado por `Petal.Width`. Asegúrate de que la geometría contenga `shape = 10` y `alpha = 0.5`.
#graficaIdSpeciesxColorTamanoSepalPetal 
"ggplot(mtcars, aes(x=cyl, y = hp)) + 
  geom_point()"

?ggplot #Create a new ggplot
?geom_point #to create scatterplots for displaying the relationship between two continuous variables.
?theme_light() #Complete themes grey, gray,blackwhite bw, linedraw, light y dark, etc
?aes #Aesthetic mappings describe how variables in the data are mapped to visual properties (aesthetics) of geoms. 

grafica1 <- ggplot(iris, 
                   aes(
                     x = Sepal.Length, 
                     y = Sepal.Width, 
                     color = Species, 
                     size = Petal.Width
                      )) +  
              geom_point(shape = 10, alpha = 0.5);

grafica1;
grafica1.1 <- ggplot(iris, 
                   aes(
                     x = Sepal.Length, 
                     y = Sepal.Width, 
                     color = Species, 
                     size = Petal.Width
                   )) +  
                geom_point(shape = 10, alpha = 0.5)+
                labs(title = "Iris",
                              x = "Sepal.Length",
                              y = "Sepal.Width"
                    ) +   theme_light();
grafica1.1 

# 3) Crea una tabla llamada `iris_mean` que contenga el promedio de todas las variables agrupadas por `Species`.
"'group_by()' y 'summarize()' o 'summarise()' son dos verbos que usualmente son usados en conjunto. 
El primero permite agrupar los datos con base en un factor (variable cualitativa), 
mientras que el segundo permite resumir la información a través de funciones y
el operador de pipeline 'dataframe %>% fun'"
iris_AgrupadoxSpecies <- iris %>% group_by(Species) #Agrupando Species del dataframe

"Analizando iris Agrupado por Species"
class(iris_AgrupadoxSpecies)   #Id tipo de dato
str(iris_AgrupadoxSpecies);    #Identificar structura del dataframe
head(iris_AgrupadoxSpecies);   #Leer inicio del datagrama
tail(iris_AgrupadoxSpecies);   #leer final del datagrama

dim(iris_AgrupadoxSpecies);    #Dimensiones del Objeto 
names(iris_AgrupadoxSpecies);  #Etiquetas tags del objeto
length(iris_AgrupadoxSpecies); #Longitud del Objeto
View(iris_AgrupadoxSpecies);  #Data Viewer

"Analizando iris Agrupado por Species y summarisando las columnas una por una.
Ayuda en: '?summarise', '?all', '?mean', '?summarise', '?all' y '?mean'
Probando:"
iris %>% group_by(Species) %>% summarise(mean = mean(Sepal.Length), n = n()) 

"Formulando summarise con todas las columnas, una por una"
iris_mean.1<-iris %>% group_by(Species) %>% summarise(Sepal.Length = mean(Sepal.Length),
                                         Sepal.Width = mean(Sepal.Width),
                                         Petal.Length = mean(Petal.Length),
                                         Petal.Width = mean(Petal.Width), n = n())  
iris_mean.1
"Analizando iris Agrupado por Species y summarise_all que lo palica a todas las
las columnas a una funciones, comparado con summarise arriba. 
Estas dos opciones hacen lo mismo.Ayuda en:'?summarise_' y '?summarise_all'"
iris_mean <- iris %>% group_by(Species) %>% summarize_all(mean)  
iris_mean
class(iris_mean)   #Id tipo de dato
str(iris_mean);    #Identificar structura del dataframe
head(iris_mean);   #Leer inicio del datagrama
tail(iris_mean);   #leer final del datagrama

dim(iris_mean);    #Dimensiones del Objeto 
names(iris_mean);  #Etiquetas tags del objeto
length(iris_mean); #Longitud del Objeto
View(iris_mean);  #Data Viewer

# 4) Con esta tabla, agrega a tu gráfica anterior otra geometría de puntos para agregar los promedios en la visualización. Asegúrate que el primer argumento de la geometría sea el nombre de tu tabla y que los parámetros sean `shape = 23`, `size = 4`, `fill = "black"` y `stroke = 2`. También agrega etiquetas, temas y los cambios necesarios para mejorar tu visualización.
grafica2 <- grafica1 +
        geom_point(
          data = iris_mean, #primer argumento de la geometría sea el nombre de tu tabla
          shape = 23, #`shape = 23`
          size = 4, #`size = 4`
          fill = "black", #`fill = 'black'`
          stroke = 2 #`stroke = 2`
          ) + labs(title = "Iris con Iris_Mean",
                   x = "Sepal.Length",
                   y = "Sepal.Width"
                   ) +   theme_light()
grafica2
