from threading import Thread, Lock
from requests import get

class IPThread(Thread):
    def __init__(self, ip, callback):
        """IPThread class definition"""
        Thread.__init__(self)
        self.__ip = ip
        self.__callback = callback

    def run(self):
        """Starting the threads"""
        print "Search: {0}".format(self.__ip)
        try:
            res = get("https://api.ip2country.info/ip?" + self.__ip)
        except:
            raise Exception("Connection error")
        data = res.json()["countryName"]
        self.__callback(data)
        print "CountryName: {}".format(data)
