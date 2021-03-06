from datetime import date
from os.path import isfile
from json import dumps
from json import load

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

        if date_of_birth[0] < 1 or date_of_birth[0] > 12 or date_of_birth[1] > 31 or date_of_birth[1] < 1 or date_of_birth[2] < 1800:
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

        assert type(self.is_married_to) is int
        self.is_married_to = 0


    """Getter for first_name"""
    def get_first_name(self):
        return self.__first_name
    """Getter for id"""
    def get_id(self):
        return self.__id
    """Getter for eyes color"""
    def get_eyes_color(self):
        return self.__eyes_color
    """Getter for date of birth"""
    def get_date_of_birth(self):
        return self.__date_of_birth
    """Getter for genre"""
    def get_genre(self):
        return self.__genre

    def __str__(self):
        return self.__first_name + " " + self.last_name

    def is_male(self):
        return self.__genre == "Male"

    """Checks the actual age"""
    def age(self):
        birth = date(self.__date_of_birth[2], self.__date_of_birth[0], self.__date_of_birth[1])
        day = date(2016, 5, 20)
        return ((day - birth).days/365)

    """Functions to compare"""
    def __cmp__(self, right):
        return cmp(self.age(), right.age())

    def __gt__(self,other):
        return self.age() > other.age()

    def __lt__(self, other):
        return self.age() < other.age()

    def __ge__(self, other):
        return self.age() >= other.age()

    def __le__(self, other):
        return self.age() <= other.age()

    def __eq__(self, other):
        return self.age() == other.age()

    def __ne__(self, other):
        return self.age() != other.age()

    """json function"""
    def json(self):
        return {
        'id': self.get_id(),
        'eyes_color': self.get_eyes_color(),
        'genre': self.get_genre(),
        'date_of_birth': self.get_date_of_birth(),
        'first_name': self.get_first_name(),
        'last_name': self.last_name,
        'is_married_to': self.is_married_to
        }
    """Function Load from Json"""
    def load_from_json(self, json):
        if type(json) is not dict:
            raise Exception("json is not valid")

        self.__id = json['id']
        self.__first_name = json['first_name']
        self.__date_of_birth = json['date_of_birth']
        self.__genre = json['genre']
        self.__eyes_color = json['eyes_color']
        self.last_name = json['last_name']
        self.is_married_to = json['is_married_to']


"""Baby Definition"""
class Baby(Person):
    def can_run(self):
        return False
    def need_help(self):
        return True
    def is_young(self):
        return True
    def can_vote(self):
        return False
    def can_be_married(self):
        return False
    def is_married(self):
        return self.is_married_to != 0
    def divorce(self, p):
        self.is_married_to = 0
        p.is_married_to = 0
    def just_married_with(self, p):
        if (self.is_married_to != 0)  or (p.is_married_to !=0):
            raise Exception("Already married")
        if(not self.can_be_married()) or  (not p.can_be_married()):
            raise Exception("Can't be married")
        self.is_married_to = p.get_id()
        p.is_married_to = self.get_id()
        if(self.get_genre == 'Female'):
            self.last_name = p.last_name
        else:
            p.last_name = self.last_name

"""Teenager definition"""
class Teenager(Person):
    def can_run(self):
        return True
    def need_help(self):
        return False
    def is_young(self):
        return True
    def can_vote(self):
        return False
    def can_be_married(self):
        return False
    def is_married(self):
        return self.is_married_to != 0
    def divorce(self, p):
        self.is_married_to = 0
        p.is_married_to = 0
    def just_married_with(self, p):
        if (self.is_married_to != 0)  or (p.is_married_to !=0):
            raise Exception("Already married")
        if(not self.can_be_married()) or  (not p.can_be_married()):
            raise Exception("Can't be married")
        self.is_married_to = p.get_id()
        p.is_married_to = self.get_id()
        if(self.get_genre == 'Female'):
            self.last_name = p.last_name
        else:
            p.last_name = self.last_name

"""Adult definition"""
class Adult(Person):
    def can_run(self):
        return True
    def need_help(self):
        return False
    def is_young(self):
        return False
    def can_vote(self):
        return True
    def can_be_married(self):
        return True
    def is_married(self):
        return self.is_married_to != 0
    def divorce(self, p):
        self.is_married_to = 0
        p.is_married_to = 0
    def just_married_with(self, p):
        if (self.is_married_to != 0)  or (p.is_married_to !=0):
            raise Exception("Already married")
        if(not self.can_be_married()) or  (not p.can_be_married()):
            raise Exception("Can't be married")
        self.is_married_to = p.get_id()
        p.is_married_to = self.get_id()
        if(self.get_genre == 'Female'):
            self.last_name = p.last_name
        else:
            p.last_name = self.last_name


"""Senior definition"""
class Senior(Person):
    def can_run(self):
        return False
    def need_help(self):
        return True
    def is_young(self):
        return False
    def can_vote(self):
        return True
    def can_be_married(self):
        return True
    def is_married(self):
        return self.is_married_to != 0
    def divorce(self, p):
        self.is_married_to = 0
        p.is_married_to = 0
    def just_married_with(self, p):
        if (self.is_married_to != 0)  or (p.is_married_to !=0):
            raise Exception("Already married")
        if(not self.can_be_married()) or  (not p.can_be_married()):
            raise Exception("Can't be married")
        self.is_married_to = p.get_id()
        p.is_married_to = self.get_id()
        if(self.get_genre == 'Female'):
            self.last_name = p.last_name
        else:
            p.last_name = self.last_name



"""Function save to file"""
def save_to_file(list, filename):
    if not isfile(filename) or type(filename) is not str:
        raise Exception("filename is not valid or doesn't exist")

    with open(filename, 'w') as f:
        output = []
        for item in list:
            data = item.json()
            data['type'] =  item.__class__.__name__
            output.append(data)
        f.write(dumps(output))

"""Function load from file"""
def load_from_file(filename):
    if not isfile(filename) or type(filename) is not str:
        raise Exception("filename is not valid or doesn't exist")

    with open(filename) as f:
        output = []
        data = load(f)
        for item in data:
            if item['type'] == 'Baby':
                n = Baby(0, 'test', [1, 1, 1900], "Male", "Blue")
            if item['type'] == 'Teenager':
                n = Teenager(0,'test', [1, 1, 1900], "Male", "Blue")
            if item['type'] == 'Adult':
                n = Adult(0, 'test', [1, 1, 1900], "Male", "Blue")
            if item ['type'] == 'Senior':
                n = Senior(0, 'test', [1, 1, 1900], "Male", "Blue")
            n.load_from_json(item)
            output.append(n)
        return output
