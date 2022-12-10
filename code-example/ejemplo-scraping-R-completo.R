# ======================== Bibliotecas =============================
library(tidyverse) # manipulación de datos
library(rvest)     # web scraping
library(lubridate) # manipulación de fechas

prueba <- read_csv("../code-py/tabla_noticias_python.csv")

# ======================== COLOMBIA GENERAL ========================
url_colombia <-
  "https://news.google.com/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNREZzY3pJU0JtVnpMVFF4T1NnQVAB?hl=es-419&gl=CO&ceid=CO%3Aes-419"

url_negocios <-
  "https://news.google.com/topics/CAAqLAgKIiZDQkFTRmdvSUwyMHZNRGx6TVdZU0JtVnpMVFF4T1JvQ1EwOG9BQVAB?hl=es-419&gl=CO&ceid=CO%3Aes-419"

url_deportes <-
  "https://news.google.com/topics/CAAqLAgKIiZDQkFTRmdvSUwyMHZNRFp1ZEdvU0JtVnpMVFF4T1JvQ1EwOG9BQVAB?hl=es-419&gl=CO&ceid=CO%3Aes-419"

googleNoticiasR <- function(url) {
  titulo_noticia <-
    url %>%
    read_html() %>%
    html_elements("body") %>%
    html_elements(xpath = '//a[@class = "WwrzSb"]')  %>%
    html_attr("aria-label")
  
  fuente_noticia <-
    url %>%
    read_html() %>%
    html_elements("body") %>%
    html_elements(xpath = '//span[@class = "vr1PYe"]') %>%
    html_text()
  
  fecha_noticia <-
    url %>%
    read_html() %>%
    html_elements("body") %>%
    html_elements(xpath = '//time[@class = "hvbAAd"]') %>%
    html_attr("datetime") %>%
    ymd_hms()
  
  df_noticias <-
    data.frame(
      noticia = titulo_noticia,
      fuente = fuente_noticia,
      fecha = fecha_noticia,
      fecha_consulta = Sys.time()
    )
  
  return(df_noticias)
  
}

# Tabla noticias
tabla_noticias <- googleNoticiasR(url = url_colombia)


# Exportando tabla final
write_csv(tabla_noticias, file = "tabla_noticias_google.csv")
