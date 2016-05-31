class TaskModel():
    """TaskModel is our model"""
    def __init__(self, title):
        if type(title) is not str or not title:
            raise Exception("title is not a string")
        self.__title = title
        self.__callback_title = None

    def get_title(self):
        return self.__title

    def set_callback_title(self, callback_title):
        self.__callback_title = callback_title


    def toggle(self):
        self.__title = self.__title[::-1]
        if self.__callback_title:
            self.__callback_title(self.__title)

    def __str__(self):
        return self.__title
