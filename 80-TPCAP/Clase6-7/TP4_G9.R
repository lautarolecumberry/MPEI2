# ----------------------------------------------------------
# 0. CARGA DE PAQUETES Y BASE DE DATOS
# ----------------------------------------------------------
library(readxl)
library(dplyr)
library(ggplot2)
library(tidyr)

# Importamos la base de datos (ajustá el path/nombre del archivo si hace falta)
datos <- read_excel("datos.xlsx")

# Nos quedamos solo con las variables que nos interesan y sacamos los NA
base <- datos %>%
  select(cname_qog, ti_cpi, wdi_gini) %>%
  drop_na(ti_cpi, wdi_gini)

# -----------------
# Armamos el grupo (categórica) a partir de ti_cpi
# -----------------
# ti_cpi: 0 = máxima corrupción percibida, 100 = mínima corrupción percibida
# Por lo tanto, por DEBAJO de la media = alta corrupción
media_cpi <- mean(base$ti_cpi)
media_cpi

base <- base %>%
  mutate(grupo_corrupcion = ifelse(ti_cpi < media_cpi,
                                    "alta_corrupcion",
                                    "baja_corrupcion"))

# Fijamos el orden de los grupos para que la comparación sea "alta - baja"
base$grupo_corrupcion <- factor(base$grupo_corrupcion,
                                 levels = c("alta_corrupcion", "baja_corrupcion"))
 
# Control de la nueva variable
table(base$grupo_corrupcion)

# -----------------
# Test de hipótesis
# -----------------
# Pregunta: ¿Los países con alta corrupción presentan, en promedio,
# una desigualdad de ingresos (Gini) mayor que los países con baja corrupción?
#
# H0: mu_alta_corrupcion <= mu_baja_corrupcion
# H1: mu_alta_corrupcion >  mu_baja_corrupcion
# Test unilateral (a la derecha / "greater")
 
t.test(wdi_gini ~ grupo_corrupcion,
       data = base,
       alternative = "greater",
       var.equal = FALSE)

# [1] 44.88793
# alta_corrupcion baja_corrupcion 
#              69              47 
# 	Welch Two Sample t-test
# data:  wdi_gini by grupo_corrupcion
# t = 4.064, df = 113.74, p-value = 4.454e-05
# alternative hypothesis: true difference in means between group alta_corrupcion and group baja_corrupcion is greater than 0
# 95 percent confidence interval:
#  2.646733      Inf
# sample estimates:
# mean in group alta_corrupcion mean in group baja_corrupcion 
#                      37.11594                      32.64468

# ----------------------------------------------------------
# PARTE 2: REGRESIÓN SIMPLE
# wdi_gini_i = alpha + beta * ti_cpi_i + u_i
# ----------------------------------------------------------
modelo <- lm(wdi_gini ~ ti_cpi, data = base)
summary(modelo)

# Call:
# lm(formula = wdi_gini ~ ti_cpi, data = base)

# Residuals:
#      Min       1Q   Median       3Q      Max 
# -12.5673  -3.9424  -0.3582   3.1274  18.7824 

# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 40.74211    1.48919  27.359  < 2e-16 ***
# ti_cpi      -0.12114    0.03063  -3.956 0.000133 ***
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# Residual standard error: 6.167 on 114 degrees of freedom
# Multiple R-squared:  0.1207,	Adjusted R-squared:  0.113 
# F-statistic: 15.65 on 1 and 114 DF,  p-value: 0.000133

ggplot(base, aes(x = ti_cpi, y = wdi_gini)) +
  geom_point(na.rm = TRUE, alpha = 0.6) +
  geom_smooth(
    method = "lm",
    formula = y ~ x,
    se = FALSE,
    color = "red",
    na.rm = TRUE
  ) +
  labs(
    title = "Desigualdad de ingresos según nivel de corrupción percibida",
    x = "Índice de Percepción de Corrupción (0 = máxima corrupción, 100 = mínima corrupción)",
    y = "Coeficiente de Gini (0 = igualdad perfecta, 100 = desigualdad perfecta)",
    caption = "Fuente: elaboración propia en base a Quality of Government Basic 
Dataset 2026."
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5),
    plot.caption = element_text(hjust = 0.5)
  )
