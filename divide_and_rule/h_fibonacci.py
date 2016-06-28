from threading import Thread

class FibonacciThread(Thread):
    def __init__(self, number):
        if not isinstance(number,int):
            raise Exception("number is not an integer")
        self.__number = number
        Thread.__init__(self)

    def run(self):
        a, b = 1, 1
        for i in range(self.__number - 1):
            a, b = b, a + b
        print str(self.__number) + " => " + str(a)
