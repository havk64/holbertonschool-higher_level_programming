"""
 ===----------------------------------------------------------===
        Divide and Rule Project by Guillaume
        Concurrency in Python.
        Task 1: Split and count faster...

        by Alexandro de Oliveira for Holberton School.
 ===----------------------------------------------------------===
"""

from threading import Thread

class StrLengthThread(Thread):
    """Class definition"""
    def __init__(self, word):
        Thread.__init__(self)
        if not isinstance(word, str):
            raise Exception("word is not a string")
        self.__word = word

    total_str_length = 0

    def run(self):
        """Adding the length of each word to public attribute"""
        StrLengthThread.total_str_length += len(self.__word)
