from json import loads
from car import Car

with open('./6-main.json') as f:
    data = loads(f.read())

cars = []

for car in data:
    obj = Car(car)
    cars.append(obj)

for car in cars:
    print car.to_comma()
