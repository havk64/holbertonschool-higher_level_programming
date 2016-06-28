from threading import Thread, Lock, activeCount

class Sum():
    result = 0
    def __init__(self, nb_threads, numbers):
        Sum.result = 0
        if not isinstance(nb_threads, int):
            raise Exception("nb_threads is not an integer")
        if not isinstance(numbers, list) and not all(isinstance(i, int) for i in numbers):
            raise Exception("numbers is not an array of integers")
        size = int(len(numbers)/nb_threads)
        for i in range(nb_threads - 1):
            thread = SumThread(numbers[size * i : size * (i + 1)])
            thread.start()
        thread = SumThread(numbers[size * (nb_threads - 1):])
        thread.start()


    def isComputing(self):
        return False if activeCount() == 1 else True

    def __str__(self):
        with Lock():
            return str(Sum.result)

class SumThread(Thread):
    def __init__(self, numbers):
        Thread.__init__(self)
        if not isinstance(numbers, list) and not all(isinstance(i, int) for i in numbers):
            raise Exception("numbers is not an array of integers")
        self.__numbers = numbers

    def run(self):
        with Lock():
            Sum.result += sum(self.__numbers)
