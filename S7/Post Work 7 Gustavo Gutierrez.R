"Postwork. Predicciones de la temperatura global
OBJETIVO
Estimar modelos ARIMA y realizar predicciones
DESARROLLO
Utilizando el siguiente vector numérico, realiza lo que se indica:"

url = "https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-07/Data/global.txt"
Global <- scan(url, sep="")
Global


"1. Crea una objeto de serie de tiempo con los datos de Global. La serie debe 
ser mensual comenzado en Enero de 1856"

Global.ts <- ts(Global, start = c(1856, 1), frequency = 12)

"2. Realiza una gráfica de la serie de tiempo anterior de 2005"
Global.ts

plot(Global.ts,
     main = "Temperatura Global", 
     xlab = "Tiempo",
     ylab = " °C ",
     sub = "Enero de 1856 - Diciembre de 2005")

"3. Ahora realiza una gráfica de la serie de tiempo anterior, transformando a 
la primera diferencia:"

plot(diff(Global.ts), type = "l", main = "Primera diferencia de Temperatura Global", 
     xlab = "t", ylab = expression(x[t]), 
     sub = expression(x[t]==x[t-1]+w[t]))


"4. ¿Consideras que la serie es estacionaria en niveles o en primera diferencia?"
#Primera inferencia

"5. Con base en tu respuesta anterior, obten las funciones de autocorrelación 
y autocorrelación parcial?"
acf(diff(Global.ts))


pacf(diff(Global.ts))


