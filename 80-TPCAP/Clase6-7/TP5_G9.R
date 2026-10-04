################################################################################
#   TP5 - Regresión múltiple: Corrupción, Desigualdad y dummy de América Latina
################################################################################

library(readxl)
library(dplyr)
library(tidyr)

# -----------------
# Carga y limpieza de datos
# -----------------
datos <- read_excel("datos.xlsx")

# Nos quedamos con las variables necesarias para AMBOS modelos
# (CPI, Gini y región), y sacamos los NA de las tres,
# para que los dos modelos se estimen sobre la misma muestra.
base <- datos %>%
  select(cname_qog, ti_cpi, wdi_gini, ht_region) %>%
  drop_na(ti_cpi, wdi_gini, ht_region)

# -----------------
# Construcción de la dummy Latam
# -----------------
# ht_region == 2  ->  América Latina (QoG incluye Cuba, Haití y Rep. Dominicana)
# Resto de las regiones (incluido el Caribe, código 10) -> categoría base (0)

base <- base %>%
  mutate(Latam = ifelse(ht_region == 2, 1, 0))

table(base$Latam)

# -----------------
# Modelo TP5: modelo con la dummy agregada
# -----------------
# Gini_i = alpha + beta1 * CPI_i + beta2 * Latam_i + u_i

modelo_tp5 <- lm(wdi_gini ~ ti_cpi + Latam, data = base)
summary(modelo_tp5)
