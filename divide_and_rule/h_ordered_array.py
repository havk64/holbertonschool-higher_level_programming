from threading import Thread, Lock, activeCount

class OrderedArrayThread(Thread):
    def __init__(self, number):
        Thread.__init__(self)
        if not isinstance(number, int):
            raise Exception("number is not an integer")
        self.__number = number
    list = []

    def run(self):
        with Lock():
            OrderedArrayThread.list.append(self.__number)
            OrderedArrayThread.list.sort()



class OrderedArray():
    def __init__(self):
        pass
    def add(self, number):
        if not isinstance(number, int):
            raise Exception("number is not an integer")
        OrderedArrayThread(number).start()

    def isSorting(self):
        return False if activeCount() == 1 else True

    def __str__(self):
        with Lock():
            return str(OrderedArrayThread.list)
