"""
 ===----------------------------------------------------------===
        Divide and Rule Project by Guillaume
        Concurrency in Python.
        Task 3: Keep the right order.

        by Alexandro de Oliveira for Holberton School.
 ===----------------------------------------------------------===
"""

from threading import Thread, Lock

class ReverseStrThread(Thread):
    """Class definition"""
    def __init__(self, word):
        Thread.__init__(self)
        if not isinstance(word, str):
            raise Exception("word is not a string")
        self.__word = word

    sentence = ''

    def run(self):
        """Action to be taken when the thread starts
           Revert the strings:"""
        with Lock():
            ReverseStrThread.sentence += self.__word[::-1] + " "
