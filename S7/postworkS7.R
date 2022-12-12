#POSTWORK Sesión 07

url = "https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-07/Data/global.txt"
Global <- scan(url, sep="")
class(Global)
class(Global)   #Id tipo de dato
str(Global);    #Identificar structura del dataframe
head(Global);   #Leer inicio del datagrama
tail(Global);   #leer final del datagrama

dim(Global);    #Dimensiones del Objeto 
names(Global);  #Etiquetas tags del objeto
length(Global); #Longitud del Objeto
View(Global);   #Data Viewer
summary(Global)
"1) Crea una objeto de serie de tiempo con los datos de Global. La serie debe ser mensual 
comenzado en Enero de 1856"
?ts;
Global.ts <- ts(Global, st = c(1856, 1), fr = 12)
class(Global.ts) 
"2) Realiza una gráfica de la serie de tiempo anterior"
?plot;
plot(Global.ts,
      main = "Serie de Temperatura Global",
      sub = "Serie mensual (Ene 1856-Dic 2005)"
      xlab = "Tiempo", 
      ylab = "Temperaturas (°C)", 
      )
 
"3) Ahora realiza una gráfica de la serie de tiempo anterior, transformando a la 
primera diferencia:"
?diff
plot(diff(Global.ts),
       xlab = "", 
       ylab = "")
      title(main = "Serie de Temperatura Global",
            xlab = "Tiempo", ylab = "Dif log-Serie",
            sub = "Gráfica de la serie de tiempo anterior, transformando a la 1era diferencia:")
 
#4) ¿Consideras que la serie es estacionaria en niveles o en primera diferencia?
# En primera diferencia
 
#5) Con base en tu respuesta anterior, obten las funciones de autocorrelación y 
#autocorrelación parcial?
?acf;
acf(diff(Global.ts))
?pacf;
pacf(diff(Global.ts))
 
"6) De acuerdo con lo observado en las gráficas anteriores, se sugiere un modelo ARIMA
con AR(1), I(1) y MA desde 1 a 4 rezagos Estima los diferentes modelos ARIMA propuestos:"
?arima;
arima(Global.ts, order = c(1, 1, 1))
arima(Global.ts, order = c(1, 1, 2))
arima(Global.ts, order = c(1, 1, 3))
arima(Global.ts, order = c(1, 1, 4))
 
"7) Con base en el criterio de Akaike, estima el mejor modelo ARIMA y realiza una 
predicción de 12 periodos (meses)"

fit <- arima(Global.ts, order = c(1, 1, 4))
?predict?
pr <- predict(fit, 12)$pred 
 

