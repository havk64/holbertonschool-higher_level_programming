from subprocess import Popen, PIPE
import os


def process_request(input_file, output_file):
    args = ['tesseract', input_file, output_file] #Create the arguments
    proc = Popen(args, stdout=PIPE, stderr=PIPE) #Open process
    ret = proc.communicate() #Launch it

    code = proc.returncode
    if code != 0:
        if code == 2:
            raise TesseractException, "File not found"
        if code == -11:
            raise TesseractException, "Language code invalid: " + ret[1]
        else:
            raise TesseractException, ret[1]

def check_path(): #Check if tesseract is in the path raise TesseractNotFound otherwise
    for path in os.environ.get('PATH', '').split(':'):
        filepath = os.path.join(path, 'tesseract')
        if os.path.exists(filepath) and not os.path.isdir(filepath):
            return True
    raise TesseractNotFound

def image_to_string(file):
    check_path() #Check if tesseract available in the path
    process_request(file, 'tmp') #Process command
    f = open("tmp.txt","r") #Open back the file
    txt = f.read()
    os.remove("tmp.txt")
    return txt
