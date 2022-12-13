"DESARROLLO
  Utilizando el siguiente vector numérico, realiza lo que se indica:"

url = "https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-07/Data/global.txt"
Global <- scan(url, sep="")
head(Global)
class(Global)

"1 Crea una objeto de serie de tiempo con los datos de Global. La serie debe ser mensual comenzado en Enero de 1856"
Serie1.ts <- ts(Global[], start = c(1856,1), frequency = 12)
class(Serie1.ts)

"2 Realiza una gráfica de la serie de tiempo anterior de 2005)"
plot(Serie1.ts, 
     main = "Datos", 
     xlab = "Tiempo",
     sub = "Enero de 1856 - Diciembre de 2005")

"3 Ahora realiza una gráfica de la serie de tiempo anterior, transformando a la primera diferencia:"
plot(diff(Serie1.ts), type = "l", main = "Primera diferencia de la Serie", 
     xlab = "t", ylab = expression(Serie1.ts[t]), 
     sub = expression(Serie1.ts[t]==Serie1.ts[t-1]+w[t]))


"4 ¿Consideras que la serie es estacionaria en niveles o en primera diferencia?"

"5 Con base en tu respuesta anterior, obten las funciones de autocorrelación y autocorrelación parcial?"
acf(diff(Serie1.ts))
pacf(diff(Serie1.ts))

"6) De acuerdo con lo observado en las gráficas anteriores, se sugiere un modelo ARIMA
con AR(1), I(1) y MA desde 1 a 4 rezagos Estima los diferentes modelos ARIMA propuestos:"
arima(Serie1.ts, order = c(1, 1, 1))
arima(Serie1.ts, order = c(1, 1, 2))
arima(Serie1.ts, order = c(1, 1, 3))
arima(Serie1.ts, order = c(1, 1, 4))


"7) Con base en el criterio de Akaike, estima el mejor modelo ARIMA y realiza una 
predicción de 12 periodos (meses)"
fit <- arima(Serie1.ts, order = c(1, 1, 4))
pr <- predict(fit, 12)$pred 

ts.plot(cbind(window(Serie1.ts, start = 1856), exp(pr)), col = c("blue", "red"), xlab = "")
title(main = "Predicción para la serie de producción de Datos",
      xlab = "Mes",
      ylab = "Producción")
