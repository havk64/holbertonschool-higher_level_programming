
"""Class definition"""
class Person():
    EYES_COLORS = ["Blue", "Green", "Brown"]
    GENRES = ["Female", "Male"]

    """Initialization"""
    def __init__(self, id, first_name, date_of_birth, genre, eyes_color):

        if type(id) is not int or id < 0:
            raise Exception("id is not an integer")

        if type(first_name) is not str:
            raise Exception("first_name is not a string")

        assert type(date_of_birth) is list
        for i in date_of_birth:
            if type(i) is not int:
                raise Exception("date_of_birth is not a valid date")

        if   date_of_birth[0] < 1 or date_of_birth[0] > 12 or date_of_birth[1] > 31 or date_of_birth[1] < 1 or date_of_birth[2] < 1800: # or 1 >= date_of_birth[1] >= 31 or 1 >= date_of_birth[2]:
                raise Exception("date_of_birth is not a valid date(debug)")

        if type(genre) is not str or genre not in self.GENRES:
            raise Exception("genre is not valid")

        if type(eyes_color) is not str or eyes_color not in self.EYES_COLORS:
            raise Exception("eyes_color is not valid")

        self.__id = id
        self.__first_name = first_name
        self.__date_of_birth = date_of_birth
        self.__genre = genre
        self.__eyes_color = eyes_color

        self.last_name = ""
        if type(self.last_name) is not str:
            raise Exception("last_name is not a string")


    """Getter for first_name"""
    def get_first_name(self):
        return self.__first_name

    def get_id(self):
        return self.__id

    def get_eyes_color(self):
        return self.__eyes_color

    def get_date_of_birth(self):
        return self.__date_of_birth

    def get_genre(self):
        return self.__genre
