"""
 ===----------------------------------------------------------===
        Divide and Rule Project by Guillaume
        Concurrency in Python.
        Task 0: Fibonacci concurrently

        by Alexandro de Oliveira for Holberton School.
 ===----------------------------------------------------------===
"""


from threading import Thread

class FibonacciThread(Thread):
    """Defining fibonaccy class"""
    def __init__(self, number):
        Thread.__init__(self)
        if not isinstance(number,int):
            raise Exception("number is not an integer")
        self.__number = number


    def run(self):
        """Action to be taken when the thread starts"""
        a, b = 1, 1
        for i in range(self.__number - 1):
            a, b = b, a + b
        print str(self.__number) + " => " + str(a)
