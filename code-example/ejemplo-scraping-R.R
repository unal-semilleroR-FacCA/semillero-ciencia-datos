# ======================== Bibliotecas =============================
library(tidyverse) # manipulación de datos
library(rvest)     # web scraping
library(polite)    # verificación de robots.txt para web scraping
library(lubridate) # manipulación de fechas
library(wordcloud) # Nube de palabras
library(tidytext)  # Tokens 
library(tm)        # Manipulación de texto - StopWordss
library(jcolors)   # Colores

# ======================== COLOMBIA GENERAL ========================
url_colombia <-
  "https://news.google.com/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNREZzY3pJU0JtVnpMVFF4T1NnQVAB?hl=es-419&gl=CO&ceid=CO%3Aes-419"

# Validcación
url_colombia %>% 
  bow()

# Títulos de noticias
titulo_noticia <-
  url_colombia %>%
  read_html() %>%
  html_elements("body") %>%
  html_elements("a.WwrzSb")  %>%
  html_attr("aria-label")

# Fuente
fuente_noticia <- 
  url_colombia %>% 
  read_html() %>% 
  html_elements("body") %>% 
  html_elements("div.MCAGUe") %>% 
  html_text()

# Hora
hora_noticia <-
  url_colombia %>%
  read_html() %>%
  html_elements("body") %>%
  html_elements("div.UOVeFe") %>%
  html_text()

# Tabla noticias
df_noticias_col <-
  data.frame(
    titulo = titulo_noticia,
    fuente = fuente_noticia,
    hora = hora_noticia,
    fecha_consulta = Sys.time()
  ) 


fecha_hora_consulta <- Sys.time() %>% 
  as.character() %>% 
  str_replace_all(pattern = ":", replacement = "-")

write_csv(df_noticias_col, file = str_c("noticias-app/noticias-Colombia",
                                        fecha_hora_consulta, ".csv"))

# ======================== NEGOCIOS ========================
url_negocios <-
  "https://news.google.com/topics/CAAqLAgKIiZDQkFTRmdvSUwyMHZNRGx6TVdZU0JtVnpMVFF4T1JvQ1EwOG9BQVAB?hl=es-419&gl=CO&ceid=CO%3Aes-419"

# Validación
url_negocios %>% 
  bow()

# Título
titulo_noticia_neg <-
  url_negocios %>%
  read_html() %>%
  html_elements("body") %>%
  html_elements("a.WwrzSb")  %>%
  html_attr("aria-label")

# Fuente
fuente_noticia_neg <-
  url_negocios %>%
  read_html() %>%
  html_elements("body") %>%
  html_elements("div.MCAGUe") %>%
  html_text()

# Hora
hora_noticia_neg <-
  url_negocios %>%
  read_html() %>%
  html_elements("body") %>%
  html_elements("div.UOVeFe") %>%
  html_text()

# Tabla noticias
df_noticias_col_neg <-
  data.frame(
    titulo = titulo_noticia_neg,
    fuente = fuente_noticia_neg,
    hora = hora_noticia_neg,
    fecha_consulta = Sys.time()
  )


write_csv(df_noticias_col_neg, file = str_c("noticias-app/noticias-Negocios",
                                            fecha_hora_consulta, ".csv"))


# ======================== DEPORTES ========================
url_deportes <-
  "https://news.google.com/topics/CAAqLAgKIiZDQkFTRmdvSUwyMHZNRFp1ZEdvU0JtVnpMVFF4T1JvQ1EwOG9BQVAB?hl=es-419&gl=CO&ceid=CO%3Aes-419"

# Validación
url_deportes %>% 
  bow()

# Título
titulo_noticia_dep <-
  url_deportes %>%
  read_html() %>%
  html_elements("body") %>%
  html_elements("a.WwrzSb")  %>%
  html_attr("aria-label")

# Fuente
fuente_noticia_dep <-
  url_deportes %>%
  read_html() %>%
  html_elements("body") %>%
  html_elements("div.MCAGUe") %>%
  html_text()

# Hora
hora_noticia_dep <-
  url_deportes %>%
  read_html() %>%
  html_elements("body") %>%
  html_elements("div.UOVeFe") %>%
  html_text()

# Tabla noticias
df_noticias_col_dep <-
  data.frame(
    titulo = titulo_noticia_dep,
    fuente = fuente_noticia_dep,
    hora = hora_noticia_dep,
    fecha_consulta = Sys.time()
  ) 

write_csv(df_noticias_col_dep, file = str_c("noticias-app/noticias-Deportes", 
                                            fecha_hora_consulta, ".csv"))

# ======================== Nubes de palabras =================================

# Stop words es español
stop_words_spanish <- data.frame(word = stopwords("spanish"))

# Gráfico
ngrama <-
  df_noticias_col %>%
  select(titulo) %>%
  unnest_tokens(output = "word", titulo, token = "ngrams", n = 1) %>% 
  anti_join(stop_words_spanish) %>% 
  count(word)

wordcloud(
  words = ngrama$word,
  freq = ngrama$n,
  max.words = 100,
  random.order = FALSE,
  colors = jcolors("pal3")
)