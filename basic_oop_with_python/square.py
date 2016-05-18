class Square:
    """Defining the Square Object"""
    def __init__(self, arg):
        self.__side_length = arg
        self.__center = None
        self.__color = ""
        self.name = ""

    def get_color():
        return self.__color

    def set_color(self, color):
        self.__color = color

    def get_center():
        return self.__color

    def set_center(self, value):
        self.__center = value

    def area(self):
        return self.__side_length * self.__side_length



    def __call__(n):
        return "Not printing yet"


    def __str__(self):
        return "Printing Square next..."
