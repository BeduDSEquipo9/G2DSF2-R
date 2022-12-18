<div style="text-align: justify;">

# Postwork sesión 8

## Análisis de la Inseguridad Alimentaria en México

### DESARROLLO

#### 1. Plantea el problema del caso

De acuerdo a (Shamah-Levy, 2014) la inseguridad alimentaria se define como la disponibilidad limitada o incierta de alimentos nutricionalmente adecuados e inocuos; o la capacidad limitada e incierta de adquirir alimentos adecuados en formas socialmente aceptables. En México, casi una cuarta parte de la población enfrenta algún nivel de inseguridad alimentaria. [^1]

Por ello, un centro de salud nutricional está interesado en analizar estadísticamente y probabilísticamente el fenómeno de la inseguridad alimentaria para poder desarrollar un modelo que permita identificar los determinantes socioeconómicos detrás de ella.

Adicionalmente, se plantea el supuesto de que los hogares con menor nivel socioeconómico tienden a gastar más en productos no saludables que las personas con mayores niveles socioeconómicos y se quiere validar la veracidad de tal dicho.

En el presente trabajo, se analizará la información disponible a fin de concluir, con argumentos estadísticos y probabilísticos, si el supuesto planteado tiene mérito o no y se sugerirá un modelo que explique lo mejor posible el fenómeno de la inseguridad alimentaria en el hogar.

#### 2. Realiza un análisis descriptivo de la información

La base de datos proporcionada contiene un total de 40,809 observaciones con 10 variables. En la Tabla 1 se describen las variables.

Tabla 1. Descripción de los datos proporcionados.
<!-- ![Tabla 1. Descripción de los datos proporcionados.](./assets/Tabla_de_Variables.png) -->

<p align="center" width="100%">
    <img src="./assets/Tabla_de_Variables.png" width="70%" alt="Tabla 1. Descripción de los datos proporcionados."/>
</p>

Después de revisar los datos  originales en R, se realizó la limpieza de los datos y el cambio de algunos tipos de datos para facilitar la manipulación del análisis. En particular, se realizó el cambio de las variables: __logaritmo natural de gastos en alimentos saludables__ y __logaritmo natural de gastos en alimentos no saludables__ aplicando el antilogaritmo para una mejor interpretación de las cifras. Por último, se eliminaron 20,529 registros que presentaron datos incompletos en alguna variable.

Dado que en los requisitos del problema se solicita analizar los patrones de los __gastos en alimentos saludables (aln)__ y __gastos en alimentos no saludables (alns)__  en los hogares mexicanos en relación a la variables: nivel socioeconómico (nse), si el hogar tienen recursos financieros extras al ingreso (refin) y si presenta o no inseguridad alimentaria (IA). Se presentan las siguientes gráficas para realizar un análisis exploratorio de los datos previo al cálculo de las medidas descriptivas de las variables mencionadas anteriormente.

En la siguiente sección nos enfocamos en primer lugar, en las variables: als, alns.

<!-- ![Gráfica de boxplot de als](./assets/boxplot_als.png) -->
<p align="center" width="100%">
    <img src="./assets/boxplot_als.png" width="70%" alt="Gráfica de boxplot de als"/>
</p>
Gráfica 1. Los gasto en alimentos saludables (ln_als)  muestran un mínimo: 1.09, primer cuartil: 5.84, media: 6.19 , mediana: 6.27, tercer cuartil: 6.63 y máximo: 8.6

<!-- ![Gráfica de boxplot de alns](./assets/boxplot_alns.png) -->
<p align="center" width="100%">
    <img src="./assets/boxplot_alns.png" width="70%" alt="Gráfica de boxplot de alns."/>
</p>

<div align="center" width="100%">
Gráfica 2. Los gastos en alimentos saludables (alns) muestran un mínimo: 0.0, primer cuartil: 3.4, media: 4.11 , mediana: 4.0, tercer cuartil: 4.86 y máximo: 8.29
</div>
<br>
En las Gráficas 1 y 2, se muestran las medidas de tendencia central y de posición. Además, se calculó la desviación estándar para __als__:  0.68  y __alns__:  1.04, con la finalidad de calcular el coeficiente de variación. El __coeficiente de variación__ de als es 11.12% y de alns es de 25.28%. Ambos coeficientes de variación son menores o iguales a 25% por lo que se puede concluir que los datos para ambas variables son homogéneos. Este supuesto se puede inferir gráficamente debido a que las cajas son cortas en ambos gráficos (ver Gráfico 1 y Gráfico 2). Adicional se observar algunos datos atípicos en la parte inferior y superior de las cajas.

<br>
Para continuar con el análisis de estas dos variables se analizan  visualmente las gráficas de caja de aln de acuerdo al __nivel socioeconómico__ (__nse5f__), ver Gráfica 3,  de acuerdo al recursos financieros distintos al ingreso laboral (ver Gráfica 4) y de la misma forma para inseguridad alimentaria .

<br>
<!-- ![Gráfica de boxplot de als vs nes5f](./assets/boxplot_als_vs_nes5f.png) -->
<p align="center" width="100%">
    <img src="./assets/boxplot_als_vs_nes5f.png" width="70%" alt="Gráfica de boxplot de als vs nes5f"/>
</p>
<div align="center" width="100%">
Gráfica 3. En esta gráfica se muestran las medidas descriptivas de aln en cada nivel socioeconómico. Las medias son: (bajo = 5.8, medio bajo = 6.03, medio = 6.17, medio alto = 6.32 y alto = 6.53). Desviación estándar (bajo = 0.76, medio bajo = 0.66, medio = 0.60, medio alto = 0.59 y alto =  0.58). Coeficiente de variación (bajo =13.18%, medio bajo = 11.08%, medio = 9.84%, medio alto =  9.43% y alto =  8.93%).
</div>
<br>
Los promedio en la Gráfica 3 muestran que el promedio de __gasto de alimentos saludables__ (*__als__*) se incrementa de acuerdo al nivel socioeconómico.

<br>
<!-- ![Gráfica de boxplot de als vs refin](./assets/boxplot_als_vs_refin.png) -->
<p align="center" width="100%">
    <img src="./assets/boxplot_als_vs_refin.png" width="70%" alt="Gráfica de boxplot de als vs refin"/>
</p>
<br>
<div align="center" width="100%">
Gráfico 4. Muestra las medidas de tendencia central de als, si la familia indicó recursos financieros distintos al ingreso laboral. Media ( No = 6.17, Si =  6.24), Desviación estándar (No = 0.68, Si = 0.69. Coeficiente de variación (No = 11.20%, Si = 11.08%).
</div>
<br>
Las medias muestran niveles de consumo promedio similares tanto para los que individuos que reportaron ingresos financieros extra distintos al laboral y los que no los tienen. Por lo que se puede anticipar que esta variable no proporciona suficiente información para determinar el consumo de als.

<br>

<!-- ![gráfica de boxplot de als vs IA](./assets/boxplot_als_vs_IA.png) -->
<p align="center" width="100%">
    <img src="./assets/boxplot_als_vs_IA.png" width="70%" alt="Gráfica de boxplot de als vs IA"/>
</p>
<br>
<div align="center" width="100%">
Gráfica 5. Muestra las medidas de tendencia central de als, de acuerdo a si presentaron o no inseguridad alimentaria en el hogar (IA). Media ( No = 6.29, Si =  6.14), Desviación estándar (No = 0.69, Si = 0.69). Coeficiente de variación (No = 10.96%, Si = 11.22%).
</div>
<br>
Las medias muestran niveles de consumo promedio similares, con una ligero gasto mayor de als por las familias que no presentaron IA.
<br>

<!-- ![gráfica de boxplot de alns vs nes5f](./assets/boxplot_alns_vs_nes5f.png) -->
<p align="center" width="100%">
    <img src="./assets/boxplot_alns_vs_nes5f.png" width="70%" alt="Gráfica de boxplot de alns vs nes5f"/>
</p>
<br>
<div align="center" width="100%">
Gráfica 6. El gráfico muestra  las medidas de tendencia central de alns según el nivel socioeconómico de los hogares consultados. Las medias son: (bajo = 3.58, medio bajo = 3.91, medio = 3.91, medio alto = 4.17 y alto = 4.6). , Desviación estándar (bajo = 0.94, medio bajo = 0.94, medio = 0.98, medio alto = 1.02 y alto = 1.05). Coeficiente de variación (bajo =16.24%, medio bajo = 15.72%, medio = 15.89%, medio alto = 16.14% y alto = 16.19%).
</div>
<br>
Se observa que los promedios de consumo de als se incrementan conforme aumenta el nivel socioeconómico, sin embargo, ???.

<br>

<!-- ![gráfica de boxplot de alns vs  refin](./assets/boxplot_alns_vs_refin.png?width=2000) -->
<p align="center" width="100%">
    <img src="./assets/boxplot_alns_vs_refin.png" width="70%" alt="Gráfica de boxplot de alns vs  refin"/>
</p>
<br>
<div align="center" width="100%">
Gráfica 7. Muestra las medidas de tendencia central de alns, con respecto a las familia que indicaron recursos financieros distintos al ingreso laboral. Media ( No = 4.12, Si =  4.10), Desviación estándar (No = 1.04, Si = 1.04. Coeficiente de variación (No =  25.33%, Si = 25.44%).
</div>
En la gráfica 7 se puede observar que las medias muestran niveles de consumo promedio similares, sin embargo, el promedio de gastos de aquellos que no presentan recursos financieros al ingreso laborales es ligeramente mayor a los que sí lo presentan.
<div style="text-align: center;">

![gráfica de boxplot de alns vs IA](./assets/boxplot_alns_vs_IA.png)

Gráfica 8. Se observa que las medidas de tendencia central de alns, con respecto a las familias que presentan Inseguridad se acercan. Media ( No = 4.33, Si =  4.03), Desviación estándar (No = 1.07, Si = 1.07). Coeficiente de variación (No = 24.81%, Si = 26.64%).
</div>
Las medias muestran niveles de consumo promedio similares, con una  gasto promedio mayor de alns por las familias que no presentaron IA.

En las Gráficas 3 y 6 permiten comparar los gastos promedio en alimentos saludables y no saludables en los distintos niveles socioeconómicos. Se observa que a mayor nivel socioeconómico el promedio de gasto es mayor.

En cuanto al gasto promedio de alimentos saludables y no saludables de acuerdo a si existe recursos financieros distintos al ingreso laboral, son muy similares por lo que no parece se un indicador de comparación. En la gráfica 4 y 6 se observan una tendencia de promedios iguales, para ambos tipos de alimentos (saludables y no saludables).

Con respecto a al gasto promedio de alimentos saludables y no saludables de acuerdo a si presenta o no seguridad alimentaria, el análisis mostró que quienes gastan más en alimentos saludables son lo que pertenecen al grupo de que no presentan seguridad alimentaria (ver Gráfica 5). pero también son los que más gastan en alimentos no saludables (Gráfica 8).

Para continuar el análisis de als y alns se realizaron histogramas que permitan conocer la frecuencia de los gastos que reportaron las familias, tanto de alimentos saludables y no saludables.
<div style="text-align: center;">

![Histograma de als](./assets/histograma_als.png)

Gráfico 9. Histograma de frecuencia de gasto de alimentos saludables (als). Las medidas de forma indican que tienen un sesgo a la izquierda (skewness = -1.19) y una forma leptocúrtica (curtosis = 6.6).

![Histograma de alns](./assets/histograma_alns.png)

Gráfico 10. Histograma de frecuencia de gasto de alimentos no saludables (alns). Las medidas de forma indican que es simétrica (skewness = 0.24 ) y una forma platocúrtica (curtosis = 2.57).
</div>
Además de las medidas de tendencia central y dispersión se consideró importante calcular las medidas de forma. En el caso de als se tiene un skewness de 1.69 y una kurtosis de, lo que confirma la existencia de un sesgo de los datos a la izquierda; y además, un forma leptocúrtica.  Para alns se obtuvo un skewnwss de 4.91 y una kurtosis de 57.41, es decir, presenta un sesgo a la derecha y una forma leptocúrtica.

Otra variable que es importante analizar para conocer la frecuencia relativa es la Inseguridad alimentaria en el hogar (IA). En la Gráfica 11 se muestra la frecuencia de si se presenta o no inseguridad alimentaria de acuerdo con los datos proporcionados por la base de datos.
<div style="text-align: center;">

![Grafica de ia](./assets/grafica_ia.png)

Gráfica 11, se muestra que el 74% de las familias que participaron en la muestra presentan inseguridad alimentaria en el hogar. Por lo tanto, el 26% restante no presentó inseguridad alimentaria.
</div>
En esta segunda sección, primero se realizó un análisis visual de los datos, para después realizar un análisis descriptivo de los datos. Los resultados obtenidos en los coeficientes de variación indican que el promedio es confiable para realizar comparaciones entre distintos grupos (caso de Gráficas ) .

#### 3. Cálculo de probabilidades para entender el problema en México

__Cálculo de probabilidad de que una familia presente o no inseguridad alimentaria__

A partir de la Gráfica 11 que presenta la frecuencia relativa de que una familia pertenezca  o no al grupo de inseguridad alimentaria, se presenta un modelo probabilístico basado en el ensayo de Bernoulli y la distribución binomial.

Si se considera que una familia tiene una probabilidad de 0.74 (ver Gráfica 11) de presentar Inseguridad Alimentaria en el hogar en México. Si partimos del supuesto de que en el centro de salud nutricional se realizan 10 estudios a familias para determinar si presentan Inseguridad Alimentaria  (IA), ¿Cuál es la probabilidad de que menos de 4 familias presenten IA?

Para dar respuesta a esta pregunta, primero se realiza un distribución binomial de acuerdo a los datos de IA. Por lo que la Gráfica 12 presenta el resultado de dicha distribución.
<div style="text-align: center;">

![gráfica de distribucion ia](./assets/distribucion_ia.png)

Gráfica 12. Distribución Binomial resultante. La media = 0.74091 y la desviación estándar = 0.43815. La media teórica esperad es 0.74 y la desviación estándar es = $\sqrt{0.74 * (1-0.74)} =  0.43863$.
</div>
Por lo que con la función de distribución acumulada binomial podemos responder a la pregunta, se tien una probabilidad de  0.00446 que menos de 4 familias de las 10 atendidas en el centro de salud nutricional presenten IA.

Además, podemos calcular otros probabilidades, por ejemplo:

La probabilidad de que más de 8 de 10 familias presenten Inseguridad Alimentaria en el hogar es de 0.22224.
La probabilidad de que 7 familias presenten Inseguridad Alimentaria en el hogar es de  0.25628.

Cálculo de probabilidad de los gastos en alimentos no saludables de una familia de acuerdo a su nivel socioeconómico.

A partir de los gastos de alimentos no saludables (Gráfica 10) se realizan un análisis probabilístico basado una distribución normal.

Si se considera que los gastos promedio de familia en alimentos no saludables de la Tabla 2, los datos se ajustan a una distribución normal.
<div style="text-align: center;">

Tabla 2. Promedio y varianza de gasto de alimentos no saludables

|Nivel socioeconómico|Media|Mediana|Moda|Varianza|
|:--------------------|:-----:|:-------:|:----:|:--------:|
|Bajo|3.68|3.58|2.99|0.94|
|Medio bajo|3.9|3.91|3.40|0.94|
|Medio|4.05|3.91|3.40|0.98|
|Medio alto|4.23|4.17|3.91|1.02|
|Alto|4.61|4.6|4.60|1.05|
</div>
Por lo que si en México el salario mínimo para 2023 será de $207.00 pesos, se plantean las siguientes preguntas:

¿Cuál es la probabilidad de que el gasto en alimentos no saludables sea menor o igual a medio salario mínimo en cada nivel socioeconómico?

Para dar respuesta a esta pregunta, primero se utiliza la distribución normal para dar respuesta a la probabilidad del intervalo de valor P(X <= 103.5 ), dado que los datos estan en logaritmo natural se realiza la conversión a  P(X <= 4.63).  Las Gráficas 13, 14, 15, 16 y 17, muestran las probabilidades para los niveles socioeconómicos; bajo, medio bajo, medio, medio alto y alto, respectivamente.
<div style="text-align: center;">

![gráfica de densidad de alns)](./assets/prob_alns_bajo.png)

Gráfica 13. Probabilidad de que una familia de nivel bajo gaste 4.63 unidades equivalentes a $103.5 es  P(X <= 4.63) = 0.84105.

![gráfica de densidad de alns](./assets/prob_alns_medio_bajo.png)

Gráfica 14. Probabilidad de que una familia de nivel medio bajo gaste 4.63 unidades equivalentes a $103.5 es  P(X <= 4.63) = 0.77619.

![gráfica de densidad de alns](./assets/prob_alns_medio.png)

Gráfica 15. Probabilidad de que una familia de nivel medio gaste 4.63 unidades equivalentes a $103.5 es  P(X <= 4.63) = 0.72141.

![gráfica de densidad de alns](./assets/prob_alns_medio_alto.png)

Gráfica 16. Probabilidad de que una familia de nivel medio alto gaste 4.63 unidades equivalentes a $103.5 es  P(X <= 4.63) = 0.65151.

![gráfica de densidad de alns](./assets/prob_alns_alto.png)

Gráfica 17. Probabilidad de que una familia de nivel medio alto gaste 4.63 unidades equivalentes a $103.50 es  P(X <= 4.63) = 0.50718.
</div>
Tabla 3. Resumen de las probabilidades obtenidas de gastos de alimentos no saludables por niveles socioeconómicos.

|Nivel socioeconómico|Probabilidad|
|:--------------------|:------------:|
|Bajo|0.84105|
|Medio bajo|0.77619|
|Medio|0.72141|
|Medio alto|0.65151|
|Alto|0.50718|

En la Tabla 3 se muestran que el nivel socioeconómico con mayor probabilidad de gastar $103.50 es el nivel bajo (0.84105), y conforme se aumenta el nivel socioeconómico la probabilidad reduce, hasta llegar a la probabilidad mas baja por el nivel socioeconómico alto (0.50718).

#### 4.Plantea hipótesis estadísticas y concluye sobre ellas para entender el problema en México

sss

#### 5. Estima un modelo de regresión, lineal o logístico, para identificar los determinantes de la inseguridad alimentaria en México

Como se busca entender qué factores influyen en la inseguridad alimentaria se define IA como la variable objetivo o dependiente. Debido a que ésta es de tipo dicotómico, se sugiere utilizar una regresión logística como modelo, pues la regresión lineal es apropiada para variables numéricas continuas. Para una mejor interpretación, en la modelación se transformarán los logaritmos de gasto en alimentos saludables y no saludables, aplicando la exponencial, su función inversa, para que queden los gastos en unidades regulares.

Como primera aproximación, se compararon dos modelos: uno que explica la inseguridad alimentaria en términos de todas las variables disponibles como predictores y otro que, además, utilice todos los posibles términos de interacción con las variables categóricas  refin, nse5f, sexojef y area.

__Modelo 1__: IA ~ nse5f + area + numpeho + refin + edadjef + sexojef + añosedu + als + alns

__Modelo 2__: IA ~ nse5f + area + numpeho + refin + edadjef + sexojef + añosedu + als + alns + numpeho:refin + añosedu:refin + edadjef:refin + als:refin + alns:refin + nse5f:refin + area:refin + sexojef:refin + numpeho:area + añosedu:area + edadjef:area + als:area + alns:area + nse5f:area + sexojef:area + numpeho:sexojef + añosedu:sexojef + edadjef:sexojef + als:sexojef + alns:sexojef + nse5f:sexojef + numpeho:nse5f + añosedu:nse5f + edadjef:nse5f + als:nse5f + alns:nse5f

Los resultados fueron:

|Modelo|AIC|Pseudo R2|
|:------|:---:|:---------:|
|Modelo 1|22168|0.09125799|
|Modelo 2|22116|0.09555227|

Como el AIC es menor y la bondad de ajuste es más grande, se tiene que el modelo 2 es mejor que el 1; considerando además que hay términos de interacciones cuyos coeficientes son significativamente distintos de cero, se puede concluir que las interacciones sí aportan a la explicación de la variable objetivo.

No obstante, existen términos con un valor p mayor a 0.05, lo que indica que no hay evidencia estadística para rechazar que el valor de sus coeficientes es igual a cero, es decir, no son significativos, por lo que deben ser eliminados del modelo. Así pues, se sugiere un tercer modelo con las siguientes variables explicativas:

__Modelo 3__: IA ~ numpeho + refin + edadjef + sexojef + añosedu + als + alns + numpeho:area + añosedu:sexojef + edadjef:sexojef + añosedu:nse5f + edadjef:nse5f

Éste arroja un AIC de 22087 y una bondad de ajuste de 0.09483598, que si bien es menor que la del modelo 2, no se considera una diferencia tan significativa como sí lo es la del AIC a favor de este modelo, por lo que hasta ahora se proclama como el mejor. Cabe señalar que se probó este mismo modelo pero con la transformación logarítmica para als y alns, pero al arrojar un AIC de 22092 y una bondad de ajuste de 0.09463171, resulta peor.

Ahora bien, pese a que el modelo 3 resultó ser el de mejores métricas, tiene un problema grave de multicolinealidad que se descubrió aplicando la prueba de inflación de varianza (VIF). Como es importante tener un modelo que cumpla con los supuestos de la regresión logística, se eliminó el término sexojef, que tenía VIF de 27.01, el mayor de todos. Hay que recordar que VIF’s mayores a 10 son indicadores de multicolinealidad.  Así, se tiene.

__Modelo 4__:  IA ~ numpeho + refin + edadjef + añosedu + als + alns + numpeho:area + añosedu:sexojef + edadjef:sexojef + añosedu:nse5f + edadjef:nse5f

A continuación se validaron los supuestos para el modelo 4:
Multicolinealidad: No se obtuvo ningún VIF mayor que 10 para ninguno de los predictores, de modo que no hay evidencias de multicolinealidad y el supuesto se cumple.
Independencia:
<div style="text-align: center;">

![Residuales del modelo ajustado](./assets/residuales.png)

</div>

En el gráfico de residuales se observan más residuos negativos que positivos, sin embargo, no se ve ningún patrón definido que pudiera indicar un grado de dependencia entre las observaciones, por lo que el supuesto se cumple.
Linealidad: Para contrastar este supuesto se necesita ejecutar la regresión logística pero incluyendo como predictores adicionales el producto entre cada predictor y el logaritmo de sí mismo. Luego de crear dichos términos y correr el modelo correspondiente, se tiene que no existe evidencia estadística para rechazar la hipótesis de que los productos son igual a cero, de modo que el supuesto de linealidad se cumple.

Así pues, __¡el modelo 4 cumple con todos los supuestos de la regresión logística!__

Comparando ambos modelos, se tiene lo siguiente:

|Modelo|AIC|Pseudo R2|
|:------|:---:|:---------:|
|Modelo 3| 22087|0.09483598|
|Modelo 4|22089|0.09467564|

Nótese que incluso cuando ambas métricas del modelo 4 son ligeramente peores, es más importante que el modelo cumpla los supuestos debidos porque, de lo contrario, no podría concluirse nada con él. Entonces, se concluye que el modelo que cumple los supuestos de regresión logística y explica mejor el fenómeno de la inseguridad alimentaria en el hogar es el modelo 4 y que los factores que influyen en él son: el número de personas en el hogar, si se tiene o no recursos financieros distintos al ingreso laboral, los años de educación del jefe de familia, el gasto en alimentos saludables y el gasto en alimentos no saludables; también importan algunas interacciones como la edad y el sexo del jefe de familia y los años de educación con el nivel socioeconómico.

Una vez que se conocen las variables explicativas, tiene mérito establecer si influyen de manera positiva o negativa sobre la variable objetivo. Para ello, se analizan los coeficientes, pero deben ser elevados a la exponencial pues la regresión logística arroja coeficientes que tienen aplicados logaritmos:

<center>

|Variable|Coeficiente|Variable|Coeficiente|
|:--------|:-----------:|:--------|:-----------:|
|Intercepto|2.4644254|alns|0.9994064|
|numpeho|1.2080799|numpeho:area|0.9662002|
|refin|1.4956810|añosedu:sexojef|1.0320940|
|edadjef|1.0226579|edadjef:sexojef|0.9957723|
|añosedu|0.9695440|añosedu:nse5f|0.9917262|
|als|0.9997761|edadjef:nse5f|0.9938537|

</center>

Si el valor es mayor que 1, entonces indica que a medida que aumenta el predictor, las probabilidades de los resultados aumentan. A la inversa, un valor menor que 1 indica que a medida que aumenta el predictor, las probabilidades de los resultados disminuyen. Para efectos de esta investigación, se puede decir, por ejemplo, que las probabilidades de que un hogar sufra inseguridad alimentaria aumentarán 1.49 veces si está en una zona rural y no en una urbana. También se identifica que las variables con relación directa con la inseguridad alimentaria son numpeho, refin, edadjef y la interacción añosedu:sexojef, mientras que el resto tiene una relación inversa.

Finalmente, se calculan los intervalos de confianza para los coeficientes de los predictores:

|Variable|2.5%|97.5%|Variable|2.5%|97.5%|
|:--------|:----:|:-----:|:--------|:----:|:-----:|
|Intercepto|1.9933520|3.0480279|alns|0.9991845|0.9996264|
|numpeho|1.1820358|1.2349334|numpeho:area|0.9481619|0.9846686|
|refin|1.3706795|1.6334161|añosedu:sexojef|1.0199859|1.0443211|
|edadjef|1.0184790|1.0268991|edadjef:sexojef|0.9929893|0.9985863|
|añosedu|0.9526730|0.9865828|añosedu:nse5f|0.9879187|0.9955657|
|als|0.9996744|0.9998777|edadjef:nse5f|0.9929008|0.9947976|

Como ninguno de los intervalos de confianza cruza el 1, se puede afirmar con un 97.5% de confianza que la dirección de las relaciones observadas para cada variable es cierta en la población.

De este modo, se recomendó un modelo que explica el fenómeno de la inseguridad alimentaria en los hogares, identificando los factores que influyen más y en qué proporción, así como su relación con la variable estudiada.

## Recursos

[^1]:Inseguridad Alimentaria casi un cuarto de la población mexicana (<https://unamglobal.unam.mx/inseguridad-alimentaria-casi-un-cuarto-de-la-poblacion-mexicana>) Fecha de consulta: 12/12/2022.
</div>
