

"Utilizando la variable total_intl_charge de la base de datos telecom_service.csv 
de la sesión 3, realiza un análisis probabilístico. Para ello, debes determinar 
la función de distribución de probabilidad que más se acerque el comportamiento 
de los datos. Hint: Puedes apoyarte de medidas descriptivas o técnicas de visualización."

#Una vez que hayas seleccionado el modelo, realiza lo siguiente:

df <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-03/Data/telecom_service.csv")
  
  Grafica la distribución teórica de la variable aleatoria total_intl_charge
¿Cuál es la probabilidad de que el total de cargos internacionales sea menor a 1.85 usd?
  ¿Cuál es la probabilidad de que el total de cargos internacionales sea mayor a 3 usd?
  ¿Cuál es la probabilidad de que el total de cargos internacionales esté entre 2.35usd y 4.85 usd?
  Con una probabilidad de 0.48, ¿cuál es el total de cargos internacionales más alto que podría esperar?
  ¿Cuáles son los valores del total de cargos internacionales que dejan exactamente al centro el 80% de probabilidad?