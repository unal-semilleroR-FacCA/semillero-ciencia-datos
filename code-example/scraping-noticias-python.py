# ========= Bibliotecas =========================================
from scrapy import Selector    # Selector de componentes
import requests                # Peticiones a la página web
from datetime import datetime  # Conversión de fechas
import numpy as np             # Cálculos numéricos
import pandas as pd            # Manipulación de datos

# ========= Noticias Colombia =========================================

# URL
url = 'https://news.google.com/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNREZzY3pJU0JtVnpMVFF4T1NnQVAB?hl=es-419&gl=CO&ceid=CO%3Aes-419'

# Acceso al contenido de la página web
html = requests.get(url).content
sel = Selector(text = html)

# Total de elementos en la página web
len(sel.xpath('//*'))

# ========= Títulos de noticias =========================================

# Con xPath
titulos_xpath = sel.xpath('//a[@class = "WwrzSb"]/@aria-label').extract()

# Con CSS
titulos_css = sel.css('a.WwrzSb::attr(aria-label)').extract()

# ¿Tienen la misma longitud?
len(titulos_xpath) == len(titulos_css)

# Primeras 5 noticias
titulos_css[0:5]

# ========= Fuente de noticias =========================================

# xPath
fuente_xpath = sel.xpath('//span[@class = "vr1PYe"]/text()').extract()

# CSS
fuente_css = sel.css('span.vr1PYe::text').extract()

# ¿Tienen la misma longitud?
len(fuente_xpath) == len(fuente_css)

# Primeras 5 fuentes
fuente_xpath[0:5]

# ========= Fecha de noticias =========================================

# xPath
fecha_xpath = sel.xpath('//time[@class = "hvbAAd"]/@datetime').extract()

for i in range(len(fecha_xpath)):
  fecha_xpath[i] = datetime.strptime(fecha_xpath[i], '%Y-%m-%dT%H:%M:%SZ')

# CSS
fecha_css = sel.css('time.hvbAAd::attr(datetime)').extract()

for i in range(len(fecha_css)):
  fecha_css[i] = datetime.strptime(fecha_css[i], '%Y-%m-%dT%H:%M:%SZ')

# ¿Tienen la misma longitud?
len(fecha_xpath) == len(fecha_css)

# Fecha mínima
print(np.min(fecha_css))

# Fecha máxima
print(np.max(fecha_css))

# ========= Tabla final de noticias =========================================
lista_noticias = [titulos_xpath, fuente_xpath, fecha_xpath]

df_noticias = pd.DataFrame(lista_noticias).transpose()
df_noticias.columns = ['noticia', 'fuente', 'fecha']

df_noticias.head(n=2)