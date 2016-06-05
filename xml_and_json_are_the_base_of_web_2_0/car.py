from xml.dom.minidom import Document

class Car:
    """Definition of the Car class"""
    def __init__(self, *args, **kwargs):
        if len(args) == 1 and type(args[0]) is str and len(args[0].split(",")) == 3:
            name, brand, nb_doors = args[0].split(",", 3)
            nb_doors = int(nb_doors)
        elif len(args) > 0 and isinstance(args[0], dict):
            mhash = args[0]
            name = str(mhash.get('name'))
            brand = str(mhash.get('brand'))
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

    def to_json_string(self):
        return '{"nb_doors": ' + str(self.__nb_doors) + ', "brand": "' + self.__brand + ', "name": "' + self.__name + '"}'

    def to_xml_node(self, doc):
        car = doc.createElement('car')
        car.setAttribute('nb_doors', str(self.__nb_doors))
        #doc.appendChild(car)
        name = doc.createElement('name')
        name.appendChild(doc.createCDATASection(self.__name))
        car.appendChild(name)

        brand = doc.createElement('brand')
        brand_content = doc.createTextNode(self.__brand)
        brand.appendChild(brand_content)
        car.appendChild(brand)

        return car
