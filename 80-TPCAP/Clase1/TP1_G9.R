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

# View(datos) # por si queremos ver los datos

# ELIMINAR LA PRIMERA FILA QUE REPITE LOS ENCABEZADOS 
datos <- datos %>% slice(-1)

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

# 4. Verifique que la variable "Edad" este en formato numérico. Si no lo está, conviértala.
datos <- datos %>%
  mutate(
    edad = as.numeric(edad)
  )

# 5. Verifique los valores únicos de la variable "Sexo"
unique(datos$sexo)

# Los datos que hay son:
# > unique(datos$sexo)
# [1] "F" "M" NA

datos <- datos %>%
  mutate(sexo = case_when(
    sexo == "F" ~ "Femenino",
    sexo == "M" ~ "Masculino",
    TRUE ~ sexo  # deja igual cualquier otro valor no contemplado
  ))

# 6. Convierta la variable de "Sexo" a tipo factor.
datos <- datos %>%
  mutate(
    sexo = factor(sexo)
  )

# 7. Verifique que las siguientes variables este en formato numérico; altura,
# número de hijos, prendas de vestir y las dos variables referidas a Milei. 
# Si no lo están, conviértalas.
sapply(datos[c("milei_expectativa", "milei_realidad", "n_prendas")], class)

# Ninguna es numeric
# > sapply(datos[c("milei_expectativa", "milei_realidad", "n_prendas")], class)
# milei_expectativa    milei_realidad         n_prendas 
# "character"       "character"       "character" 

datos <- datos %>%
  mutate(across(c(milei_expectativa, milei_realidad, n_prendas), parse_number))

# 8. Verifique los valores únicos de la variable "Estado civil". Las categorías deben
# ser “Soltero/a”, “Casado/a”, "Divorciado/a", "Separado/a", "Viudo/a" y "Unión
# consensual". Si existen variaciones en la escritura (por ejemplo, “Separado” y “separada”), unifíquelas.
unique(datos$estado_civil)

# > unique(datos$estado_civil)
# [1] "S"          "Soltera"    "C"          "Soltero"    "Soltero(a)" "Casado"     NA 

datos <- datos %>%
  mutate(estado_civil = case_when(
    estado_civil %in% c("S", "Soltera", "Soltero", "Soltero(a)") ~ "Soltero/a",
    estado_civil %in% c("C", "Casado") ~ "Casado/a",
    TRUE ~ estado_civil
  ))

# 9. Convierta la variable "Estado civil" a tipo factor.
datos <- datos %>%
  mutate(
    estado_civil = factor(estado_civil)
  )

# 10. Verifique los valores únicos de la variable "Te gusta el futbol?". Convierta la
# variable "Te gusta el futbol?" a una dummy que valga 1 si la respuesta es "Sí" y 0
# si no. Transforme los casos intermedios en N A.
unique(datos$te_gusta_el_futbol)

# > unique(datos$te_gusta_el_futbol)
# [1] "No"                  "Si"                  "No, solo el mundial" "Sí"                 
# [5] NA    

datos <- datos %>%
  mutate(te_gusta_el_futbol = case_when(
    te_gusta_el_futbol %in% c("Si", "Sí") ~ 1,
    te_gusta_el_futbol == "No" ~ 0,
    TRUE ~ NA_real_ # Ponemos el default como NA porque son los casos intermedios
  ))

# 11. Verifique los valores únicos de la variable "Estas en zoom?". Reemplace la variable
# de "Estas en zoom?" por una variable en la cual No tome valor 0 y Sí valor 1.
unique(datos$estas_en_zoom)

# > unique(datos$estas_en_zoom)
# [1] "No" "no" "Sí" "Si" NA  

datos <- datos %>%
  mutate(estas_en_zoom = case_when(
    estas_en_zoom %in% c("Si", "Sí") ~ 1,
    tolower(estas_en_zoom) == "no" ~ 0, # usamos el tolower porque hay `No` y `no`
  ))

# 12. Verifique los valores únicos de la variable "Perro o Gato". Las categorías deben
# ser “Perro” y “Gato”. Si existen variaciones en la escritura (por ejemplo, “Perro” y
# “perro”), unifíquelas. Transforme los "na" en N A.
unique(datos$perro_o_gato)

# > unique(datos$perro_o_gato)
# [1] "Gato"  "Perro" "na"    NA

datos <- datos %>%
  mutate(perro_o_gato = case_when(
    perro_o_gato == "na" ~ NA_character_, # Si el valor es el string "na" → lo convierte en NA_character_
    TRUE ~ perro_o_gato # Cualquier otro valor ("Gato", "Perro", o los NA que ya eran NA) → lo deja igual.
  ))

# 13. Convierta la variable "Perro o Gato" a tipo factor.
datos <- datos %>%
  mutate(
    perro_o_gato = factor(perro_o_gato)
  )

# 14. Verifique los valores únicos de la variable "Maradona o Messi". Las categorías
# deben ser “Maradona” y “Messi”. Si existen variaciones en la escritura (por ejemplo,
# “Maradona” y “maradona”), unifíquelas.
unique(datos$maradona_o_messi)

# > unique(datos$maradona_o_messi)
# [1] "Messi"    "Maradona" NA  

# Ya estan bien asi que no nos hace falta unificarlos

# 15. Convierta la variable "Maradona o Messi" a tipo factor.
datos <- datos %>%
  mutate(
    maradona_o_messi = factor(maradona_o_messi)
  )

# 16. Guarde la base de datos en formato xlsx.
write.xlsx(
  datos,
  file = "PARA_JUGAR_2025_LIMPIA.xlsx",
  overwrite = TRUE
)