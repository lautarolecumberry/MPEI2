# Grupo 9
# Maria Jose Gonzalez Torres
# Lautaro Lecumberry
# Emiliano Morgante

# Importamos la libreria wooldridge
library(wooldridge)

# Definimos la variable datos con la informacion de salarios
data("wage1")
datos <- wage1

# 2. Calculen la media, la mediana y la varianza de wage

# Calculamos la media de wage
mean(datos$wage)
# [1] 5.896103

# Calculamos la mediana de wage
median(datos$wage)
# [1] 4.65

# Calculamos la varianza de wage
var(datos$wage)
# [1] 13.63888

# 3. Calculen el salario promedio de varones y de mujeres 
# (la esperanza condicional E(wage | female))

# female vale 1 si es mujer, 0 si es varon.
# E(wage | female) es el salario promedio dentro de cada grupo.
tapply(datos$wage, datos$female, mean)

# Salario promedio de los varones: 7.09 usd/h
# Salario promedio de las mujeres: 4.58 usd/h

# 4. Binomial. Cada uno de los n = 12 estudiantes entra a la clase por Zoom con
# probabilidad p = 0,3. Sea X el número que entra. Escriban E(X) y Var(X), y
# calculen P(X = 4) con dbinom().

# Si 12 personas entran al Zoom, cada una con probabilidad 0,3:
# Esperanza y varianza teoricas:
12 * 0.3             # Usamos la formula E(X) = n*p. Nos da un resultado de: 3.6
12 * 0.3 * (1 - 0.3) # Usamos la formula Var(X) = n*p*(1-p). Nos da un resultado de: 2.52

# Probabilidad de que entren exactamente 4: 
dbinom(4, size = 12, prob = 0.3)
# Resultado: P(X = 4) = 0.2311397

# 5. Normal. Sobre wage: calculen la media y el desvío estándar, y estandaricen la
# variable (creen wage_z). Suponiendo que wage sigue una distribución Normal con
# esa media y ese desvío, calculen P(wage > 10) usando pnorm() y comparen ese
# resultado con la proporción observada de personas que efectivamente ganan más
# de 10 en los datos. ¿Hay diferencias? Grafiquen el histograma de wage con la
# curva Normal correspondiente superpuesta: ¿ajusta bien?

# calculamos media y desvio estandar
m <- mean(datos$wage)
s <- sd(datos$wage)

# estandarizamos wage
datos$wage_z <- (datos$wage - m) / s

# calculamos P(wage > 10) usando pnorm()
pnorm(10, mean = m, sd = s, lower.tail = FALSE)

# calculamos la proporción observada de personas que efectivamente ganan más de 10
mean(datos$wage > 10)
# ??? que onda esto? porque esto calcula eso?

# Histograma con la curva Normal encima:
hist(datos$wage, freq = FALSE, col = "lightblue",
     main = "Salario por hora", xlab = "wage")
curve(dnorm(x, mean = m, sd = s), add = TRUE, col = "red", lwd = 2)

# 6. Covarianza y correlación. Calculen la covarianza y la correlación entre wage y
# educ, hagan un gráfico de dispersión e interpreten el signo y la magnitud.

# calculamos la covarianza entre wage y educ
cov(datos$wage, datos$educ)
# calculamos la correlación entre wage y educ
cor(datos$wage, datos$educ)

# hacemos un gráfico de dispersión
plot(datos$educ, datos$wage,
     xlab = "Anios de educacion", ylab = "Salario por hora",
     main = "Educacion vs. salario")
