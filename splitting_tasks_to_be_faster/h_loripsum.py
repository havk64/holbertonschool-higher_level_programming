from threading import Thread, Lock
from requests import get
import sys
class LoripsumThread(Thread):
    """Definition of LoripsumThread"""
    def __init__(self, filename):
        Thread.__init__(self)
        self.__filename = filename

    def run(self):
        """Catching exceptions"""
        with Lock():
            reload(sys)
            sys.setdefaultencoding("latin-1")
            try:
                res = get("http://loripsum.net/api/1/short")
            except:
                raise Exception("GET request failed")
            try:
                with open(self.__filename, 'a') as f:
                    f.write(res.text)
            except:
                raise Exception("Could not open the file")
