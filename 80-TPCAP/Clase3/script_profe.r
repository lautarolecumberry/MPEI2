# TPCAP - Clase 3: variables aleatorias y distribuciones en R
# Maestria en Politica y Economia Internacionales (MPEI), UdeSA
# Base: wage1, del paquete wooldridge (salario, educacion, experiencia).

# El paquete wooldridge trae las bases del libro. Instalar una sola vez:
# install.packages("wooldridge")
library(wooldridge)

data("wage1")
datos <- wage1

# Primer vistazo
head(datos)
summary(datos$wage)


# ------------------------------------------------------------------
# 1. La media muestral estima la esperanza
# ------------------------------------------------------------------

# E(wage) no la conocemos; la estimamos con el promedio de la muestra.
mean(datos$wage)

# La esperanza es lineal: si reescalamos la variable, el promedio se
# reescala igual. mean(a*X + b) = a*mean(X) + b.
mean(100 * datos$wage + 1)
100 * mean(datos$wage) + 1      # da lo mismo

# Con la varianza pasa distinto: Var(a*X) = a^2 * Var(X).
var(100 * datos$wage)
100^2 * var(datos$wage)         # da lo mismo


# ------------------------------------------------------------------
# 2. Esperanza condicional: el promedio dentro de cada grupo
# ------------------------------------------------------------------

# female vale 1 si es mujer, 0 si es varon.
# E(wage | female) es el salario promedio dentro de cada grupo.
tapply(datos$wage, datos$female, mean)

# La diferencia entre los dos promedios es una primera senal de brecha salarial. 


# ------------------------------------------------------------------
# 3. Una simulacion corta: de donde sale la probabilidad
# ------------------------------------------------------------------

# Fijamos la semilla para que a todos nos de el mismo resultado.
set.seed(2026)

# Tiramos una moneda justa (0 = ceca, 1 = cara) muchas veces. La frecuencia
# relativa de caras deberia acercarse a la probabilidad, 0.5.
mean(sample(c(0, 1), size = 10,    replace = TRUE))
mean(sample(c(0, 1), size = 100,   replace = TRUE))
mean(sample(c(0, 1), size = 10000, replace = TRUE))

# Con pocas tiradas el promedio oscila; con muchas se pega a 0.5. Ese 0.5 es a
# la vez la probabilidad de cara y la esperanza de la variable:
# probabilidad = frecuencia en el largo plazo; esperanza = promedio en el largo plazo.


# ------------------------------------------------------------------
# 4. Distribuciones en R
# ------------------------------------------------------------------

# --- Binomial ---
# Si 10 personas entran al Zoom, cada una con probabilidad 0.6, el numero que
# entra es Binomial(n = 10, p = 0.6). Probabilidad de que entren exactamente 7:
dbinom(7, size = 10, prob = 0.6)

# Toda la distribucion de un vistazo:
barplot(dbinom(0:10, size = 10, prob = 0.6),
        names.arg = 0:10,
        xlab = "Numero que entra al Zoom", ylab = "Probabilidad",
        col = "steelblue")

# Esperanza y varianza teoricas:
10 * 0.6             # E(X) = n*p
10 * 0.6 * (1 - 0.6) # Var(X) = n*p*(1-p)

# --- Normal y estandarizacion ---
m <- mean(datos$wage)
s <- sd(datos$wage)

# Estandarizamos: cada salario, en cuantos desvios esta de la media.
datos$wage_z <- (datos$wage - m) / s
head(datos$wage_z)

# Suponiendo Normal, probabilidad de ganar mas de 10 dolares la hora:
pnorm(10, mean = m, sd = s, lower.tail = FALSE)

# Histograma con la curva Normal encima:
hist(datos$wage, freq = FALSE, col = "lightblue",
     main = "Salario por hora", xlab = "wage")
curve(dnorm(x, mean = m, sd = s), add = TRUE, col = "red", lwd = 2)

# El salario esta sesgado a la derecha, no es exactamente Normal: buen
# recordatorio de que no toda variable sigue una Normal.


# ------------------------------------------------------------------
# 5. Covarianza y correlacion
# ------------------------------------------------------------------

# Relacion entre salario y anios de educacion.
cov(datos$wage, datos$educ)
cor(datos$wage, datos$educ)

plot(datos$educ, datos$wage,
     xlab = "Anios de educacion", ylab = "Salario por hora",
     main = "Educacion vs. salario")

# La correlacion es positiva, pero solo mide la parte lineal de la relacion.
