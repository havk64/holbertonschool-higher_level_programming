from threading import Thread
from sys import argv

class StrLenThread(Thread):
    def __init__(self, word):
        Thread.__init__(self)
        if not isinstance(word, str):
            raise Exception("word is not a string")
        self.__word = word

    def run(self):
        total_str_length = 0;
        StrLenThread.total_str_length += len(self.__word)


if len(argv) > 2:
    print "Usage: \n$ python {} 'word'".format(argv[0])
    exit

words = argv[1].split(" ")
str_length_threads = []

StrLenThread.total_str_length = len(words) - 1

for word in words:
    str_length_thread = StrLenThread(word)
    str_length_threads += [str_length_thread]
    str_length_thread.start()

for t in str_length_threads:
    t.join()

print "%d" % StrLenThread.total_str_length
