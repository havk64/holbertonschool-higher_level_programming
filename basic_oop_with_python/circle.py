""" Importing const pi from math module """
from math import pi

#Defining the Circle Object.
class Circle():

    def __init__(self, radius):
        self.__radius = radius 
        self.__center = []
        self.__color = ""

        self.name = ""

    def area(self):
        radius = self.__radius
        return pi * radius * radius

    def get_color(self):
        return self.__color

    def set_color(self, color):
        self.__color = color

    def get_center(self):
        return self.__center

    def set_center(self, val):
        self.__center = val
