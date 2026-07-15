# Importo librerias
library(dplyr)
library(readxl)
library(readr)
library(janitor)
library(openxlsx)

# Cargo el archivo de excel
datos_sucios <- read_excel("PARA JUGAR 2026.xlsx")

# 1. Limpie los nombres de las variable para que todos tengan el mismo formato
datos <- clean_names(datos_sucios, "snake")

# 2. Renombre de variables
datos <- rename(datos, milei_expectativa = cuando_gano_milei_como_esperabas_que_fuera_el_mandato_del_1_al_10)
datos <- rename(datos, milei_realidad = ahora_como_crees_que_esta_siendo_el_mandato_del_1_al_10)
datos <- rename(datos, n_prendas = cuantas_prendas_de_vestir_te_pusiste_hoy_conta_todo)
datos <- rename(datos, conocimiento_sobre_r = grado_de_conocimiento_sobre_r)

# 3. En las columnas que tienen datos de tipo character, si hay observaciones que dicen
# N/A, NA, −, cámbienlas por missing values.
datos <- datos %>%
  # recorro todas las columnas
  mutate(across(
    # si es un caracter
    where(is.character),
    # me fijo si es N/A, NA o − y lo cambio por NA, sino lo dejo igual
    ~ if_else(.x %in% c("N/A", "NA", "-"), NA_character_, .x)
  ))
