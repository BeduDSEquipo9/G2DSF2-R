#POSTWORK Sesión 07

url = "https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-07/Data/global.txt"
Global <- scan(url, sep="")

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
      main = "Serie de Temperatura (°C) vs Tiempo",
      sub = "Serie mensual (Ene 1856-Dic 2005)",
      xlab = "Tiempo", 
      ylab = "Temps (°C)", 
      )
 
"3) Ahora realiza una gráfica de la serie de tiempo anterior, transformando a la 
primera diferencia:"
?diff #Lagged Differences
plot(diff(Global.ts),
       xlab = "", 
       ylab = "")
      title(main = "Serie de Temperatura (°C) vs Tiempo 1era Diff",
            xlab = "Tiempo", ylab = "DifFerencia en base log",
            sub = "Gráfica de la serie de tiempo en 1era diferencia:")
 
#4) ¿Consideras que la serie es estacionaria en niveles o en primera diferencia?
# En 1era
 
#5) Con base en tu respuesta anterior, obten las funciones de autocorrelación y 
#autocorrelación parcial?
?acf; #Auto- and Cross- Covariance and -Correlation Function Estimation
acf(diff(Global.ts))
?pacf; #Partial Auto- and Cross- Covariance and -Correlation Function Estimation
pacf(diff(Global.ts))
 
"6) De acuerdo con lo observado en las gráficas anteriores, se sugiere un modelo ARIMA
con AR(1), I(1) y MA desde 1 a 4 rezagos Estima los diferentes modelos ARIMA propuestos:"
?arima;
arima(Global.ts, order = c(1, 1, 1))
"
Call:
arima(x = Global.ts, order = c(1, 1, 1))

Coefficients:
         ar1      ma1
      0.3797  -0.8700
s.e.  0.0433   0.0293

sigma^2 estimated as 0.01644:  log likelihood = 1142.13,  aic = -2278.26
> arima(Global.ts, order = c(1, 1, 2))

Call:
arima(x = Global.ts, order = c(1, 1, 2))

Coefficients:
         ar1      ma1     ma2
      0.7593  -1.2992  0.3190
s.e.  0.0354   0.0487  0.0452

sigma^2 estimated as 0.01616:  log likelihood = 1157.48,  aic = -2306.96"

arima(Global.ts, order = c(1, 1, 2))

"
Call:
arima(x = Global.ts, order = c(1, 1, 3))

Coefficients:
         ar1      ma1     ma2     ma3
      0.8171  -1.3518  0.3087  0.0575
s.e.  0.0406   0.0490  0.0407  0.0326

sigma^2 estimated as 0.01613:  log likelihood = 1158.94,  aic = -2307.88"

arima(Global.ts, order = c(1, 1, 3))
"
Call:
arima(x = Global.ts, order = c(1, 1, 4))

Coefficients:
         ar1      ma1     ma2     ma3     ma4
      0.8704  -1.4030  0.3478  0.0053  0.0600
s.e.  0.0335   0.0411  0.0438  0.0401  0.0273

sigma^2 estimated as 0.01609:  log likelihood = 1161.2,  aic = -2310.39"

arima(Global.ts, order = c(1, 1, 4))
"
Call:
arima(x = Global.ts, order = c(1, 1, 4))

Coefficients:
         ar1      ma1     ma2     ma3     ma4
      0.8704  -1.4030  0.3478  0.0053  0.0600
s.e.  0.0335   0.0411  0.0438  0.0401  0.0273

sigma^2 estimated as 0.01609:  log likelihood = 1161.2,  aic = -2310.39"

 
"7) Con base en el criterio de Akaike, estima el mejor modelo ARIMA y realiza una 
predicción de 12 periodos (meses)"

modelo<-arima(Global.ts, order = c(1, 1, 4))
?predict
pr <- predict(modelo, 12)$pred 
 
"> pr
           Jan       Feb       Mar       Apr       May       Jun       Jul
2006 0.3944191 0.4109006 0.4241679 0.4249647 0.4256583 0.4262620 0.4267875
           Aug       Sep       Oct       Nov       Dec
2006 0.4272449 0.4276430 0.4279895 0.4282911 0.4285537"

