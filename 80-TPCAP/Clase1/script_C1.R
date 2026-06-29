# TPCAP - Clase 1: primeros pasos en R con la base "PARA JUGAR"
# Maestria en Politica y Economia Internacionales (MPEI), UdeSA
# La base la armamos entre todos cargando nuestros datos. Hoy la exploramos.


# -------------------------------------------------------------------
"1. R como calculadora"
# -------------------------------------------------------------------

# Lo mas basico: R hace cuentas. Escriban esto y aprieten Ctrl+Enter
# (Cmd+Enter en Mac) para ejecutar la linea.
2 + 2
10 / 4
3 ^ 2

# Podemos guardar un resultado en un "objeto" con la flecha <-
# El objeto queda en memoria (lo ven arriba a la derecha, en Environment).
mi_edad <- 26
mi_edad

# Un vector es varios valores juntos. La funcion c() los combina.
edades <- c(28, 31, 25, 40)
mean(edades)   # promedio
max(edades)    # el mayor
edad_prom <- mean(edades) 

# -------------------------------------------------------------------
"2. Cargar la base de datos"
# -------------------------------------------------------------------

# Nuestra base esta en un Excel, asi que necesitamos el paquete readxl.
# Instalar se hace UNA sola vez (por eso queda comentado). Cargar con
# library() hay que hacerlo cada vez que abrimos R.
# install.packages("readxl")
library(readxl)

# R necesita saber en que carpeta estamos trabajando. Para fijarla:
# Session > Set Working Directory > To Source File Location
# (o descomenten la linea de abajo con la ruta de su computadora).
setwd("/Users/lautaro/Documents/MPEI2/80-TPCAP/Clase1")

datos <- read_excel("PARA JUGAR 2026.xlsx")

# El Excel trae los nombres "lindos" en la primera fila y abreviaturas en
# la segunda. Le ponemos nombres cortos y comodos a cada columna.
names(datos) <- c("apellido", "nombre", "correo", "edad", "sexo",
                  "nacionalidad", "provincia", "altura", "titulo",
                  "estado_civil", "hijos", "futbol", "equipo",
                  "exp_milei", "eval_milei", "zoom", "prendas",
                  "conoc_R", "serie", "mascota",
                  "idolo_futbol", "extra")

# La primera fila quedo con las abreviaturas, no es un alumno: la sacamos.
datos <- datos[-1, ]

# El Excel tiene muchas filas vacias. Nos quedamos solo con las
# personas que cargaron su edad.
datos <- datos[!is.na(datos$edad), ]

# -------------------------------------------------------------------
"3. Primer vistazo a la base"
# -------------------------------------------------------------------

# View(datos)        # abre la base como una planilla
# head(datos)        # las primeras filas
# dim(datos)         # cuantas filas (personas) y columnas (variables)
# names(datos)       # nombres de las variables
str(datos)         # tipo de cada variable (numero, texto, etc.)

# Para acceder a una sola variable usamos el signo $
datos$edad


# -------------------------------------------------------------------
"4. Arreglar tipos de variable"
# -------------------------------------------------------------------

# Al venir de Excel, algunas columnas numericas quedaron como texto.
# as.numeric las convierte. Si alguien escribio algo raro en vez de un
# numero, R lo deja como NA (dato faltante) y avisa. Es esperable.
datos$edad       <- as.numeric(datos$edad)
datos$hijos      <- as.numeric(datos$hijos)
datos$prendas    <- as.numeric(datos$prendas)
datos$exp_milei  <- as.numeric(datos$exp_milei)
datos$eval_milei <- as.numeric(datos$eval_milei)

str(datos)

# -------------------------------------------------------------------
"5. Variables categoricas: conteos y tablas de frecuencia"
# -------------------------------------------------------------------

# table() cuenta cuantos casos hay de cada categoria.
table(datos$sexo)
table(datos$mascota)        # P = perro, G = gato
table(datos$idolo_futbol)
table(datos$futbol)

# Fijense que aparecen respuestas mal cargadas ("NA", "N/A", "Ambos").
# La tabla tambien sirve para descubrir errores de carga.

# Para verlo en porcentajes en vez de en conteos:
prop.table(table(datos$sexo))
round(100 * prop.table(table(datos$mascota)), 1)

# Y lo mismo en un grafico de barras:
barplot(table(datos$idolo_futbol),
        main = "Idolo del futbol",
        col = "steelblue")

# Tabla cruzada: dos categoricas a la vez.
# Ej.: los del equipo "perro", son mas de Messi o de Maradona?
table(datos$mascota, datos$idolo_futbol)


# -------------------------------------------------------------------
"6. Variables numericas: tendencia central y dispersion"
# -------------------------------------------------------------------

# Medidas centrales de la edad
mean(datos$edad)      # promedio
median(datos$edad)    # mediana (el del medio)

# Medidas de dispersion (que tan distintos son entre si)
sd(datos$edad)        # desvio estandar
min(datos$edad)
max(datos$edad)
range(datos$edad)

# summary() da varias de un saque: minimo, cuartiles, media y maximo.
summary(datos$edad)
summary(datos$prendas)


# -------------------------------------------------------------------
"7. Histogramas"
# -------------------------------------------------------------------

# Un histograma muestra como se reparten los valores.
hist(datos$edad,
     main = "Distribucion de la edad",
     xlab = "Edad",
     col  = "lightblue")

hist(datos$prendas,
     main = "Cuanta ropa nos pusimos hoy",
     xlab = "Prendas de vestir",
     col  = "lightgreen")

unique(datos$prendas) 
class(datos$prendas)
datos$prendas <- as.numeric(datos$prendas)
class(datos$prendas)


# Boxplot: comparar una numerica entre grupos. Ej.: edad segun sexo.
boxplot(edad ~ sexo, data = datos,
        main = "Edad segun sexo",
        ylab = "Edad")


# -------------------------------------------------------------------
"8. Correlaciones"
# -------------------------------------------------------------------

# La correlacion mide si dos variables se mueven juntas.
# Va de -1 (relacion negativa perfecta) a 1 (positiva perfecta); 0 = nada.

# Quien tiene mas hijos tiende a tener mas edad?
cor(datos$edad, datos$hijos, use = "complete.obs")

plot(datos$edad, datos$hijos,
     main = "Edad vs. numero de hijos",
     xlab = "Edad", ylab = "Hijos")

# La expectativa sobre Milei predice como lo evaluamos ahora?
cor(datos$exp_milei, datos$eval_milei, use = "complete.obs")

plot(datos$exp_milei, datos$eval_milei,
     main = "Expectativa vs. evaluacion actual (Milei)",
     xlab = "Lo que esperaba (1-10)",
     ylab = "Como lo evaluo ahora (1-10)")


# -------------------------------------------------------------------
"9. Ayuda en R"
# -------------------------------------------------------------------

# Para saber que hace una funcion y que opciones tiene:
?mean
?hist

# Si no recuerdan el nombre exacto, buscar por palabra:
# ??histogram


# Acuerdense de guardar el script (Ctrl+S / Cmd+S) para no perder el trabajo.
