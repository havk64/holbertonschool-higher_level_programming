from json import loads
from car import Car

"""Opening the json file"""
with open('./6-main.json') as f:
    data = loads(f.read())

"""Creating the car objects:"""
cars = []
for car in data:
    obj = Car(car)
    cars.append(obj)

"""Printing each object"""
for car in cars:
    print car.to_comma()
