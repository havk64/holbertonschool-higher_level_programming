from threading import Thread, Lock


class StrLengthThread(Thread):
    def __init__(self, word):
        Thread.__init__(self)
        if not isinstance(word, str):
            raise Exception("word is not a string")
        self.__word = word

    total_str_length = 0

    def run(self):
        with Lock():
            self.total_str_length += len(self.__word)
