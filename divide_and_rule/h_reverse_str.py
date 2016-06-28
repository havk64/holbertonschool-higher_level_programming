from threading import Thread, Lock, enumerate

class ReverseStrThread(Thread):
    def __init__(self, word):
        Thread.__init__(self)
        if not isinstance(word, str):
            raise Exception("word is not a string")
        self.__word = word

    sentence = ''

    def run(self):
        with Lock():
            ReverseStrThread.sentence += self.__word[::-1] + " "
