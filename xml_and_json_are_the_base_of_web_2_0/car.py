class Car:
    """Definition of the Car class"""
    def __init__(self, *args, **kwargs):
        if len(args) > 0 and isinstance(args[0], dict):
            mhash = args[0]
            name = mhash.get('name')
            brand = mhash.get('brand')
            nb_doors = mhash.get('nb_doors')
        else:
            name = kwargs.get('name')
            brand = kwargs.get('brand')
            nb_doors = kwargs.get('nb_doors')

        if not name or not isinstance(name, str):
            raise Exception("name is not a string")

        if not brand or not isinstance(brand, str):
            raise Exception("brand is not a string")

        if nb_doors <= 0 or not isinstance(nb_doors, int):
            raise Exception("nb_doors is not > 0")

        self.__name = name
        self.__brand = brand
        self.__nb_doors = nb_doors

    def get_name(self):
        return self.__name

    def get_brand(self):
        return self.__brand

    def get_nb_doors(self):
        return self.__nb_doors

    def to_hash(self):
        return {
        'name': self.__name,
        'brand': self.__brand,
        'nb_doors': self.__nb_doors
        }

    def __str__(self):
        return self.__name + " " + self.__brand + " (" + str(self.__nb_doors) + ')'

    def set_nb_doors(self, n):
        self.__nb_doors = n

c = Car(name="Rogue", brand="Nissan", nb_doors=5)
print "c: %s" % c

c2 = Car(c.to_hash())
c2.set_nb_doors(3)
print "c2: %s" % c2
print "c: %s" % c
