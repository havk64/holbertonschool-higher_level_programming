from xml.dom.minidom import Document
from car import Car
from json import loads

doc = Document()
x_cars = doc.createElement('cars')
doc.appendChild(x_cars)

with open('./7-main.json') as f:
    data = loads(f.read())

for car in data:
    item = Car(car)
    c_xml = item.to_xml_node(doc)
    year = doc.createElement('year')
    year_value = doc.createTextNode('2015')
    year.appendChild(year_value)
    c_xml.appendChild(year)
    c_xml.setAttribute('weight', str(1000))
    brand = doc.createElement('brand')
    brand_value = doc.createCDATASection(u"\u00a9" + item.get_brand())
    brand.appendChild(brand_value)
    c_xml.replaceChild(brand, c_xml.getElementsByTagName('brand')[0])
    x_cars.appendChild(c_xml)

print doc.toxml(encoding='utf-8')
