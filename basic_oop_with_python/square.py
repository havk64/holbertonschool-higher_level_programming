class Square:
    """Defining the Square Object"""
    def __init__(self, arg):
        self.__side_length = arg
        self.__center = None
        self.__color = ""
        self.name = ""

    def get_color():
        return self.__color

    def set_color(color):
        self.__color = color

    def get_center():
        return self.__color

    def set_center(value):
        self.__center = value

    def area(self):
        return self.__side_length * self.__side_length
