# ----------------------------------------------------------
# 0. CARGA DE PAQUETES Y BASE DE DATOS
# ----------------------------------------------------------
library(readxl)
library(dplyr)
library(ggplot2)

# Importamos la base de datos (ajustá el path/nombre del archivo si hace falta)
datos <- read_excel("datos.xlsx")

# ----------------------------------------------------------
# Creación de la variable democracy
# 1 = democrático (bti_ds >= 6)
# 0 = no democrático (bti_ds < 6)
# ----------------------------------------------------------
datos <- datos %>%
  mutate(
    democracy = case_when(
      is.na(bti_ds) ~ NA_real_,
      bti_ds >= 6 ~ 1,
      bti_ds < 6 ~ 0
    )
  )

# Control de la nueva variable
table(datos$democracy, useNA = "ifany")

# ----------------------------------------------------------
# Eliminamos las observaciones sin información en democracy
# ----------------------------------------------------------
datos_filtrados <- datos %>%
  filter(!is.na(democracy))

# Creamos etiquetas comprensibles (opcional para este TP4,
# pero las dejamos por si querés graficar)
datos_filtrados <- datos_filtrados %>%
  mutate(
    democracy_label = factor(
      democracy,
      levels = c(0, 1),
      labels = c("No democrático", "Democrático")
    )
  )

# Separamos el PBI per cápita según grupo
pbi_dem <- datos_filtrados$wdi_gdpcapcon2015[datos_filtrados$democracy == 1]
pbi_no_dem <- datos_filtrados$wdi_gdpcapcon2015[datos_filtrados$democracy == 0]

# Test t de dos muestras independientes, unilateral
# alternative = "greater" porque H1 plantea que la media de los
# países democráticos (primer argumento) es mayor
test_hipotesis <- t.test(
  pbi_dem,
  pbi_no_dem,
  alternative = "greater"
)

# test_hipotesis

#    0    1 <NA> 
#   84   51   59 

# 	Welch Two Sample t-test

# data:  pbi_dem and pbi_no_dem
# t = 1.529, df = 127.8, p-value = 0.06437
# alternative hypothesis: true difference in means is greater than 0
# 95 percent confidence interval:
#  -219.1992       Inf
# sample estimates:
# mean of x mean of y 
#  9189.048  6568.374 

# ----------------------------------------------------------
# PARTE 2: REGRESIÓN SIMPLE
# PBI_i = alpha + beta * democracia_i + u_i
# ----------------------------------------------------------
modelo <- lm(wdi_gdpcapcon2015 ~ bti_ds, data = datos_filtrados)
summary(modelo)

ggplot(datos_filtrados, aes(x = bti_ds, y = wdi_gdpcapcon2015)) +
  geom_point(na.rm = TRUE, alpha = 0.6) +
  geom_smooth(
    method = "lm",
    formula = y ~ x,
    se = FALSE,
    color = "red",
    na.rm = TRUE
  ) +
  labs(
    title = "PBI per cápita según estatus de democracia",
    x = "Estatus de democracia (escala de 1 a 10)",
    y = "PBI per cápita (dólares constantes de 2015)",
    caption = "Fuente: elaboración propia en base a Quality of Government Basic 
Dataset 2026."
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5),
    plot.caption = element_text(hjust = 0.5)
  )
