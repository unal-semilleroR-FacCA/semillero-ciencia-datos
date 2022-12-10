# ========= Bibliotecas =========================================
from scrapy import Selector    # Selector de componentes
import requests                # Peticiones a la página web
from datetime import datetime  # Conversión de fechas
import numpy as np             # Cálculos numéricos
import pandas as pd            # Manipulación de datos

# ========= Automatización inicial ===============================
def noticiasGoogle(url):
  
  html = requests.get(url).content
  sel = Selector(text = html) 
  
  titulos_xpath = sel.xpath('//a[@class = "WwrzSb"]/@aria-label').extract()
  fuente_xpath = sel.xpath('//span[@class = "vr1PYe"]/text()').extract()
  fecha_xpath = sel.xpath('//time[@class = "hvbAAd"]/@datetime').extract()
  for i in range(len(fecha_xpath)):
    fecha_xpath[i] = datetime.strptime(fecha_xpath[i], '%Y-%m-%dT%H:%M:%SZ')
    
  lista_noticias = [titulos_xpath, fuente_xpath, fecha_xpath]
  df_noticias = pd.DataFrame(lista_noticias).transpose()
  df_noticias.columns = ['noticia', 'fuente', 'fecha']
  
  return df_noticias    
    
# ========= Ejecución automatizada =========================================  
url_colombia = 'https://news.google.com/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNREZzY3pJU0JtVnpMVFF4T1NnQVAB?hl=es-419&gl=CO&ceid=CO%3Aes-419'
url_negocios = 'https://news.google.com/topics/CAAqLAgKIiZDQkFTRmdvSUwyMHZNRGx6TVdZU0JtVnpMVFF4T1JvQ1EwOG9BQVAB?hl=es-419&gl=CO&ceid=CO%3Aes-419'
url_deportes = 'https://news.google.com/topics/CAAqLAgKIiZDQkFTRmdvSUwyMHZNRFp1ZEdvU0JtVnpMVFF4T1JvQ1EwOG9BQVAB?hl=es-419&gl=CO&ceid=CO%3Aes-419'

tabla_noticias = noticiasGoogle(url = url_colombia)  
tabla_noticias.head(n=5)  

# Exportando tabla final de noticias
tabla_noticias.to_csv('tabla_noticias_python.csv', index=False) 