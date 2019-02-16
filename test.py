from contextlib import closing
from selenium.webdriver import Firefox # pip install selenium
from selenium.webdriver.support.ui import WebDriverWait
from BeautifulSoup import BeautifulSoup
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.firefox.options import Options
from selenium import webdriver
import time

# use firefox to get page with javascript generated content
options = Options()
options.headless = True
driver = webdriver.Firefox(options=options, executable_path=r'/usr/bin/geckodriver')
driver.get("https://www.submarino.com.br/categoria/celulares-e-smartphones/f/marca-motorola")
button2 = driver.find_element_by_link_text('2')
button3 = driver.find_element_by_link_text('3')
button4 = driver.find_element_by_link_text('4')
source_code2 = button2.get_attribute("outerHTML")
source_code3 = button3.get_attribute("outerHTML")
source_code4 = button4.get_attribute("outerHTML")
print(button2)
print(button3)
print(button4)
print(source_code2)
print(source_code3)
print(source_code4)
button3.click() # Clica na pagina 3

time.sleep(5)

page_source = driver.page_source
soup = BeautifulSoup(page_source)
print(soup.prettify())
driver.quit()
