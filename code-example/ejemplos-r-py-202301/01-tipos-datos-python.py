# ---- Comentarios en Python

# Toda línea que inice con un numeral será tomada como un comentario.
# Tener cuidado con el nombramiento de variables, ya que python
# discrimina minúsculas de mayúsculas.
# Ejecutar código con con CTRL + Shift o CTRL + Enter.

# --- Cargando bibliotecas
import os
from datetime import datetime

# ---- Directorios

# Directorio actual
print(os.getcwd())

# Cambiando el directorio
os.chdir("D:\Otros\Semillero-R\Ciclo-2\slides-r-py-202202")

# Consultando nuevamente el directorio
print(os.getcwd())

# ---- Tipos de datos

# Texto (string-objetc)
texto = "Hola mundo!"
print(texto)
print(type(texto))

# Numéricos (float)
numero = 123.45
print(numero)
print(type(numero))

# Enteros (int)
numero_entero = 12
print(numero_entero)
print(type(numero_entero)) 

# ---- Fechas

# Obteniendo fecha actual del sistema
print(datetime.now())

# Guardando la fecha actual en una variable
fecha_actual = datetime.now()
print(fecha_actual)
print(type(fecha_actual))

# Conversión de texto a fecha
texto_fecha = "2023-12-31"
print(type(texto_fecha))

texto_fecha2 = datetime.strptime(texto_fecha, "%Y-%m-%d")
print(texto_fecha2)
print(type(texto_fecha2))

# Booleanos (True o False)
booleano_true = True
booleano_false = False
print(type(booleano_true))
print(type(booleano_false))

# ¿Cómo consultar la documentación de funciones que desconozco o en las
# cuales deseamos profundizar más?
help(os.getcwd)
help(os.chdir)
help(datetime)