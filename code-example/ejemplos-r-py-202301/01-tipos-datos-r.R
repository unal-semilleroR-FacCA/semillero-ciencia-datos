# ---- Comentarios en R

# Toda línea que inice con un numeral será tomada como un comentario.
# Tener cuidado con el nombramiento de variables, ya que R
# discrimina minúsculas de mayúsculas.
# Ejecutar código con con CTRL + Enter.

# --- Cargando bibliotecas
library(lubridate)

# ---- Directorios

# Directorio actual
getwd()

# Cambiando el directorio
setwd("D:/Otros/Semillero-R/Ciclo-2/slides-r-py-202202")

# Consultando nuevamente el directorio
getwd()

# ---- Tipos de datos

# Texto (character)
texto <- "Hola mundo!"
texto

class(texto)

# Numéricos (double o numeric)
numero <- 123.45
numero

class(numero)

# Enteros (integer)
numero_entero <- 12
print(numero_entero)

class(numero_entero)

# ---- Fechas

# Obteniendo fecha actual del sistema
Sys.Date()

# Guardando la fecha actual en una variable
fecha_actual <- Sys.Date()
fecha_actual

class(fecha_actual)

# Conversión de texto a fecha
texto_fecha <- "2023-12-31"
texto_fecha

class(texto_fecha)

texto_fecha2 <- ymd(texto_fecha)
texto_fecha2

class(texto_fecha2)

texto_fecha3 <- as.Date(texto_fecha, "%Y-%m-%d")
texto_fecha3

class(texto_fecha3)

# Lógicos (TRUE o FALSE)
booleano_true <- TRUE
booleano_false <- FALSE

class(booleano_true)
class(booleano_false)

# ---- Ayudas - Documentación

# ¿Cómo consultar la documentación de funciones que desconozco o en las
# cuales deseamos profundizar más?
help(ymd)
?ymd
