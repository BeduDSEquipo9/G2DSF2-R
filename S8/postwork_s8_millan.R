###################################
# Reto 8. 
###################################

###############################################################################
library(dplyr)
library(DescTools)
library(ggplot2)
library(moments)

setwd("~/dev/R/s8")
df <- read.csv("inseguridad_alimentaria_bedu.csv")
# Primera vista de los datos
names(df)
str(df)
summary(df)
#View(df)

# Limpieza de los datos
## Conversión de tipos
"Convertir nse5f a categórica ordinal"
df$nse5f <- factor(df$nse5f, 
                   levels = c(1, 2, 3, 4, 5),
                   labels = c("Bajo", "Medio bajo", "Medio", "Medio alto", "Alto"),
                   ordered =  TRUE)
"Convertir area a categórica"
df$area <- factor(df$area, 
                   levels = c(0, 1),
                   labels = c("Urbana", "Rural"))
"Convertir refin a categórica"
df$refin <- factor(df$refin, 
                  levels = c(0, 1),
                  labels = c("No", "Si"))
"Convertir sexojef a categórica"
df$sexojef <- factor(df$sexojef, 
                   levels = c(0, 1),
                   labels = c("Hombre", "Mujer"))
"Convertir IA a categórica"
df$IA <- factor(df$IA, 
                     levels = c(0, 1),
                     labels = c("No", "Si"))
df$als <- exp(df$ln_als) 
df$alns <- exp(df$ln_alns)

str(df)
summary(df)

## NAs
sum(complete.cases(df)) #20280 vs 40809 obs. el 50% esta incompleto
sum(complete.cases(df$edadjef)) # 35792 Borrar o media o mean
sum(complete.cases(df$sexojef)) # 35818 Borrar o llenar con
sum(complete.cases(df$ln_als))  # 40022 Borrar o llenar??
sum(complete.cases(df$ln_alns)) # 23305 Borrar o llenar??


### borrrar
df.clean <- df[complete.cases(df),]
#
str(df.clean)
summary(df.clean)
#View(df.clean)
# Exploración de los datos

## ADES

## graficas de puntos 
boxplot(df.clean$als,
        ylab="als",
        main="als")

ggplot(df, aes(x=IA, y = ln_als)) + 
  geom_point()
"Es mejor"
# ggplot(df.clean, 
#        aes(x=IA,
#            y=ln_als,
#            fill=IA))+
#   geom_boxplot()+
#   labs(x="IAs", 
#        y="ln_als",
#        title = "ln_als segun IA")+
#   theme(legend.position = "none")+
#   theme(panel.background = element_blank(), 
#         panel.grid.major = element_blank(),
#         panel.grid.minor = element_blank())

ggplot(df.clean, 
       aes(x=IA,
           y=als,
           fill=IA))+
  geom_boxplot(alpha=0.7)+
  labs(x="IA", 
       y="als",
       title = "als segun IA")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

ggplot(df.clean, 
       aes(x=refin,
           y=als,
           fill=refin))+
  geom_boxplot()+
  labs(x="refin", 
       y="als",
       title = "als segun refin")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

ggplot(df.clean, 
       aes(x=nse5f,
           y=ln_als,
           fill=nse5f))+
  geom_boxplot()+
  labs(x="nse5f", 
       y="ln_als",
       title = "ln_als segun nse5f")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

ggplot(df.clean, 
       aes(x=nse5f,
           y=als,
           fill=nse5f))+
  geom_boxplot()+
  labs(x="nse5f", 
       y="als",
       title = "als segun nse5f")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

ggplot(df.clean, 
       aes(x=refin,
           y=als,
           fill=refin))+
  geom_boxplot()+
  labs(x="refin", 
       y="als",
       title = "als segun refin")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

ggplot(df, aes(x=IA, y = ln_alns)) + 
  geom_point()
"Mejor"
ggplot(df,  
       aes(x=IA,
           y=ln_alns,
           fill=IA))+
  geom_boxplot()+
  labs(x="IAs", 
       y="ln_alns",
       title = "ln_alns segun IA")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

ggplot(df.clean, 
       aes(x=nse5f,
           y=ln_alns,
           fill=nse5f))+
  geom_boxplot()+
  labs(x="nse5f", 
       y="ln_alns",
       title = "ln_alns segun nse5f")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

ggplot(df.clean, 
       aes(x=refin,
           y=ln_alns,
           fill=refin))+
  geom_boxplot()+
  labs(x="refinf", 
       y="ln_alns",
       title = "ln_alns segun refin")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

ggplot(df.clean, 
       aes(x=refin,
           y=alns,
           fill=refin))+
  geom_boxplot()+
  labs(x="refinf", 
       y="alns",
       title = "alns segun refin")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

ggplot(df, aes(x=ln_als, y = ln_alns, color = IA, size = nse5f)) + 
  geom_point(shape = 1, alpha = 0.7)
## histogrmas
freq <- table(df$nse5f)
freq # Esto se tienen en str()
transform(freq, 
          rel.freq=prop.table(Freq)) #frecuencia relativa

# nse5f (Nivel socieconómico del hogar)
ggplot(df, aes(x = nse5f)) +
  geom_bar()

# refin (Recursos financieros distintos al ingreso laboral)
ggplot(df, aes(x = refin)) +
  geom_bar()

freq.IA <- table(df$IA)
freq.IA # Esto se tienen en str()
transform(freq.IA, 
          rel.freq=prop.table(Freq)) #frecuencia relativa
# IA (Inseguridad alimentaria en el hogar)
ggplot(df, aes(x = IA)) +
  geom_bar()

# 
k = ceiling(sqrt(length(df.clean$ln_als)))
ac = (max(df.clean$ln_als)-min(df.clean$ln_als))/k
bins <- seq(min(df.clean$ln_als), max(df.clean$ln_als), by = ac)
bins
ln_als.clases <- cut(df.clean$ln_als, breaks = bins, include.lowest=TRUE, dig.lab = 8)
ln_als.clases
dist.freq <- table(ln_als.clases)

transform(dist.freq, 
          rel.freq=prop.table(Freq), 
          cum.freq=cumsum(prop.table(Freq)))


# ggplot(df, aes(ln_als)) +
#   geom_histogram(bins = 50) + 
#   labs(title = "Histograma", 
#        x = "ln_als",
#        y = "Frequency") + 
#   theme_classic()


ggplot(df, 
       aes(als), fill='pink', color = 'red') +
  geom_histogram() + #bins = 50, binwidth = 1000
  labs(title = "Histograma", 
       x = "als",
       y = "Frequency") + 
  #xlim(c(0, 2000))+
  theme_classic()

# acmulado ggplo
# ggplot(df, aes(ln_als)) +
#   geom_histogram(aes(y = cumsum(..count..)), bins = 50) + 
#   labs(title = "Histograma acumulado", 
#        x = "ln_als",
#        y = "Frequency") + 
#   theme_classic()

ggplot(df, aes(als)) +
  geom_histogram(aes(y = cumsum(..count..)), bins = 50) + 
  labs(title = "Histograma acumulado", 
       x = "als",
       y = "Frequency") + 
  theme_classic()

# ggplot(df, aes(ln_alns)) +
#   geom_histogram(bins = 50) + 
#   labs(title = "Histogra ma", 
#        x = "ln_alns",
#        y = "Frequency") + 
#   theme_classic()

ggplot(df, aes(alns)) +
  geom_histogram(bins = 50) + 
  labs(title = "Histogra ma", 
       x = "alns",
       y = "Frequency") + 
  theme_classic()

# ggplot(df, aes(ln_alns)) +
#   geom_histogram(aes(y = cumsum(..count..)), bins = 50) + 
#   labs(title = "Histograma acumulado", 
#        x = "ln_als",
#        y = "Frequency") + 
#   theme_classic()

ggplot(df, aes(alns)) +
  geom_histogram(aes(y = cumsum(..count..)), bins = 50) + 
  labs(title = "Histograma acumulado", 
       x = "als",
       y = "Frequency") + 
  theme_classic()

ggplot(df, aes(numpeho)) +
  geom_histogram(bins = 16) + 
  labs(title = "Histogra ma", 
       x = "numpeho",
       y = "Frequency") + 
  theme_classic()

ggplot(df, aes(edadjef)) +
  geom_histogram(bins = 20) + 
  labs(title = "Histogra ma", 
       x = "edadjef",
       y = "Frequency") + 
  theme_classic()

ggplot(df, aes(añosedu)) +
  geom_histogram(bins = 5) + 
  labs(title = "Histogra ma", 
       x = "añosedu",
       y = "Frequency") + 
  theme_classic()


boxplot(df$ln_als, horizontal = TRUE)
boxplot(df$ln_alns, horizontal = TRUE)

boxplot(df.clean$nse5f, horizontal = TRUE)
boxplot(df.clean$ln_als, horizontal = TRUE) # Datos atípicos
boxplot(df.clean$ln_alns, horizontal = TRUE) # Datos atípìcos

boxplot(df.clean$als, horizontal = TRUE) # Datos atípicos
boxplot(df.clean$alns, horizontal = TRUE) # Datos atípìcos


# Medidas descriptivas para ln_als
## Medidas de tendencia central
mean(df.clean$ln_als)
median(df.clean$ln_als)
Mode(df.clean$ln_als)
# Medidas de dispersión
var(df.clean$ln_als)
sd(df.clean$ln_als)
#### Coeficiente de variación***
sd(df.clean$ln_als)/mean(df.clean$ln_als) * 100 #si > 25% ->no son homogéneos 10.40
# Medidad de posición
cuartiles <- quantile(df.clean$ln_als, probs = c(0.25, 0.50, 0.75))
cuartiles
deciles <-quantile(df.clean$ln_als, probs = c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9))
deciles
percentiles <- quantile(df.clean$ln_als, probs = seq(0.01,0.99, by=0.01))
percentiles
# Medidas de forma
skewness(df.clean$ln_als) # #s > 0 Sesgo a la derecha s = 0 Simétrica s < 0 Sesgo a la izquierda
kurtosis(df.clean$ln_als) # #Leptocúrtica k > 3 #Mesocúrtica k = 3 Platocúrtica k < 3

# Medidas descriptivas para als
## Medidas de tendencia central
mean(df.clean$als)
median(df.clean$als)
Mode(df.clean$als)
# Medidas de dispersión
var(df.clean$als)
sd(df.clean$als)
#### Coeficiente de variación***
sd(df.clean$als)/mean(df.clean$als) * 100 #si > 25% ->no son homogéneos 56.64 
# Medidad de posición
cuartiles <- quantile(df.clean$als, probs = c(0.25, 0.50, 0.75))
cuartiles
deciles <-quantile(df.clean$als, probs = c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9))
deciles
percentiles <- quantile(df.clean$als, probs = seq(0.01,0.99, by=0.01))
percentiles
# Medidas de forma
skewness(df.clean$als) # #s > 0 Sesgo a la derecha s = 0 Simétrica s < 0 Sesgo a la izquierda
kurtosis(df.clean$als) # #Leptocúrtica k > 3 #Mesocúrtica k = 3 Platocúrtica k < 3



# Medidas descriptivas para ln_alns
## Medidas de tendencia central
mean(df.clean$ln_alns) 
median(df.clean$ln_alns)
Mode(df.clean$ln_alns)
# Medidas de dispersión
var(df.clean$ln_alns)
sd(df.clean$ln_alns)
#### Coeficiente de variación***
sd(df.clean$ln_alns)/mean(df.clean$ln_alns) * 100 #si > 25% ->no son homogéneos 24.84
# Medidad de posición
cuartiles <- quantile(df.clean$ln_alns, probs = c(0.25, 0.50, 0.75))
cuartiles
deciles <-quantile(df.clean$ln_alns, probs = c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9))
deciles
percentiles <- quantile(df.clean$ln_alns, probs = seq(0.01,0.99, by=0.01))
percentiles
# Medidas de forma
skewness(df.clean$ln_alns) # #s > 0 Sesgo a la derecha s = 0 Simétrica s < 0 Sesgo a la izquierda
kurtosis(df.clean$ln_alns) # #Leptocúrtica k > 3 #Mesocúrtica k = 3 Platocúrtica k < 3


# Medidas descriptivas para alns
## Medidas de tendencia central
mean(df.clean$alns)
median(df.clean$alns)
Mode(df.clean$alns)
# Medidas de dispersión
var(df.clean$alns)
sd(df.clean$alns)
#### Coeficiente de variación***
sd(df.clean$alns)/mean(df.clean$alns) * 100 #si > 25% ->no son homogéneos 130.48
# Medidad de posición
cuartiles <- quantile(df.clean$alns, probs = c(0.25, 0.50, 0.75))
cuartiles
deciles <-quantile(df.clean$alns, probs = c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9))
deciles
percentiles <- quantile(df.clean$alns, probs = seq(0.01,0.99, by=0.01))
percentiles
# Medidas de forma
skewness(df.clean$alns) # #s > 0 Sesgo a la derecha s = 0 Simétrica s < 0 Sesgo a la izquierda
kurtosis(df.clean$alns) # #Leptocúrtica k > 3 #Mesocúrtica k = 3 Platocúrtica k < 3

# Coeficiente de correlación de Pearson
df.select1 <- select(df.clean, numpeho, edadjef, añosedu, ln_als, ln_alns)
corr_matrix <- round(cor(df.select1),4)
corr_matrix

df.select2 <- select(df.clean, numpeho, edadjef, añosedu, als, alns)
corr_matrix <- round(cor(df.select2),4)
corr_matrix

pairs(df.select1)
pairs(df.select2)


ggplot(df.select1, aes(x=ln_als, y=numpeho)) + 
  geom_point() +                                     
  stat_smooth(method = "lm",
              formula = y ~ x,
              geom = "smooth") +
  labs(title = "Gráfica de dispersión", 
       x = "ln_als",
       y = "numpeho") + 
  theme_classic()

ggplot(df.select2, aes(x=als, y=numpeho)) + 
  geom_point() +                                     
  stat_smooth(method = "lm",
              formula = y ~ x,
              geom = "smooth") +
  labs(title = "Gráfica de dispersión", 
       x = "als",
       y = "numpeho") + 
  theme_classic()

ggplot(df.select1, aes(x=ln_alns, y=numpeho)) + 
  geom_point() +                                     
  stat_smooth(method = "lm",
              formula = y ~ x,
              geom = "smooth") +
  labs(title = "Gráfica de dispersión", 
       x = "ln_alns",
       y = "numpeho") + 
  theme_classic()

ggplot(df.select2, aes(x=alns, y=numpeho)) + 
  geom_point() +                                     
  stat_smooth(method = "lm",
              formula = y ~ x,
              geom = "smooth") +
  labs(title = "Gráfica de dispersión", 
       x = "alns",
       y = "numpeho") + 
  theme_classic()

ggplot(df.select1, aes(x=ln_als, y=añosedu)) + 
  geom_point() +                                     
  stat_smooth(method = "lm",
              formula = y ~ x,
              geom = "smooth") +
  labs(title = "Gráfica de dispersión", 
       x = "ln_als",
       y = "añosedu") + 
  theme_classic()

ggplot(df.select2, aes(x=als, y=añosedu)) + 
  geom_point() +                                     
  stat_smooth(method = "lm",
              formula = y ~ x,
              geom = "smooth") +
  labs(title = "Gráfica de dispersión", 
       x = "als",
       y = "añosedu") + 
  theme_classic()

ggplot(df.select1, aes(x=ln_alns, y=añosedu)) + 
  geom_point() +                                     
  stat_smooth(method = "lm",
              formula = y ~ x,
              geom = "smooth") +
  labs(title = "Gráfica de dispersión", 
       x = "ln_alns",
       y = "añosedu") + 
  theme_classic()

ggplot(df.select2, aes(x=alns, y=añosedu)) + 
  geom_point() +                                     
  stat_smooth(method = "lm",
              formula = y ~ x,
              geom = "smooth") +
  labs(title = "Gráfica de dispersión", 
       x = "alns",
       y = "añosedu") + 
  theme_classic()

## Ensayo de Bernoulli y Distribución normal
n <- 11471
p <- 0.67
count <- c()
for (i in seq(n)) {
  x <- sample(c("Si", "No"), size = 1, prob = c(p, 1-p))
  if (x == "Si") {
    count[i] <- 1
  }
  else
    count[i] <- 0
  
}

barplot(table(count)/length(count), 
        main = "Experimento de Bernoulli", 
        xlab = "Resultado",
        names = c("Si", "No"))


binom <- rbinom(n = 111471, size = 10, prob = 0.67)
barplot(table(binom)/length(binom),
        main = "Distribución Binomial", 
        xlab = "# de familias con Inseguridad Alimentaria en el hogar")

"Un familia tiene una probabilidad de 0.67 de presentar Inseguridad Alimentaria 
en el hogar en México. Si al día se evaluan 10 familias, 

¿cuál es la probabilidad de que menos de 4 familias presenten Inseguridad Alimentaria 
en el hogar?"
pbinom(q = 3, size = 10, prob = 0.67, lower.tail = TRUE) #P(X<=x)  0.01854895

"¿cuál es la probabilidad de que más de 8 familias presenten Inseguridad Alimentaria 
en el hogar?"
pbinom(q = 8, size = 10, prob = 0.67, lower.tail = FALSE) #P(X<=x) 0.1080099

"¿cuál es la probabilidad de que 7 familias presenten Inseguridad Alimentaria 
en el hogar?" 
dbinom(x = 7, size = 10, prob = 0.67) #  0.2613646


## Distribución normal
"El gasto als de una familia mexicana tiene una distribución normal cuya media 
es 651.0853 unidades con desviación estándar de 368.805"
#als
{
  curve(dnorm(x, mean = 651.0853, sd = 368.805), from = 0, to = 2000, 
      col='blue', main = "Densidad Normal - als",
      ylab = "f(x)", xlab = "X")
  abline(v =651.0853 , lwd = 0.5, lty = 2)
  }

mean <- 651.0853
sd <- 368.805
x <- seq(-4, 4, 0.01)*sd + mean
y <- dnorm(x, mean = mean, sd = sd) 

plot(x, y, type = "l", xlab = "X", ylab = "f(x)",
     main = "Densidad de Probabilidad Normal", 
     sub = expression(paste(mu == 651.0853, " y ", sigma == 368.805)))

integrate(dnorm, lower = x[1], upper = x[length(x)], mean=mean, sd = sd)

"Calcula P(X <= 312): (salario mínimo 2023 frontera, 207 resto país) " 
pnorm(q = 312, mean = mean, sd = sd, lower.tail = TRUE) # 0.178939

par(mfrow = c(2, 2))
plot(x, y, type = "l", xlab = "", ylab = "")
title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == 651.0853, " y ", sigma == 368.805)))

polygon(c(min(x), x[x<=312], 312), c(0, y[x<=312], 0), col="red")

"Calcula P(X <= 312): (salario mínimo 2023)" 
pnorm(q = 312, mean = mean, sd = sd, lower.tail = TRUE) #

"Calcula P(0 <= X <= 312):"
pnorm(q = 312, mean = mean, sd = sd) - pnorm(q = 0, mean = mean, sd = sd) #  0.14019

plot(x, y, type = "l", xlab="", ylab="")
title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == 651.0853, " y ", sigma == 368.805)))

polygon(c(0, x[x>=0 & x<=312], 312), c(0, y[x>=0 & x<=312], 0), col="green")


"Calcula P(X >= 312):"
pnorm(q = 312, mean = mean, sd = sd, lower.tail = FALSE) # 0.821061

plot(x, y, type = "l", xlab="", ylab="")
title(main = "Densidad de Probabilidad Normal", sub = expression(paste(mu == 651.0853, " y ", sigma == 368.805)))

polygon(c(312, x[x>=312], max(x)), c(0, y[x>=312], 0), col="blue")

dev.off()

"Como con cualquier otra distribución, también podemos calcular los cuantiles de la 
distribución, es decir podemos encontrar el valor b, tal que P(X <= b) = 0.75:"
b <- qnorm(p = 0.75, mean = mean, sd = sd)
b
