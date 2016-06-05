from xml.dom.minidom import Document
from json import loads
from car import Car

doc = Document()
cars = doc.createElement('cars')
doc.appendChild(cars)

with open('5-main.json') as f:
    data = loads(f.read())

mycars = []
for i in data:
    obj = Car(i)
    mycars.append(obj)

brands = []
doors = 0
for car in mycars:
    brand = car.get_brand()
    nb_door = car.get_nb_doors()
    doors += nb_door
    item = car.to_xml_node(doc)
    cars.appendChild(item)
    if not brand in brands:
        brands.append(brand)

print len(brands)
print doors
print mycars[3]

print doc.toxml(encoding='utf-8')
