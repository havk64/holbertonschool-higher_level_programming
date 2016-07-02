from threading import Thread, Semaphore
from random import randint
from time import sleep


class Store(Thread):
    """Definition of Class Store"""
    def __init__(self, item_number, person_capacity):
        Thread.__init__(self)
        self.__item_number = item_number
        self.__pool = Semaphore(value = person_capacity)

    def enter(self):
        self.__pool.acquire()

    def buy(self):
        sleep(randint(5,10))
        bought = False
        if self.__item_number > 0:
            self.__item_number -= 1
            bought = True
        self.__pool.release()
        return bought
