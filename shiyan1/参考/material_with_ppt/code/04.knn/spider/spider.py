#coding = utf-8
#Python3.X

"""
This is just a simple spider which helps you to
download the CAPTCHA images from the website
http://jwbinfosys.zju.edu.cn/CheckCode.aspx.
"""

#import urllib2
import os
import time
import urllib
import urllib.parse
import urllib.request


for i in range(0, 1000):
	url = "http://jwbinfosys.zju.edu.cn/CheckCode.aspx"
	user_agent = 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT)'
	headers = {'User-Agent': user_agent}
	values = {"input1": "SeeKHit",
				"input2": "123456",
				"__EVENTTARGET": "btnLogin",
				"__EVENTARGUMENT": ""}

	data = urllib.parse.urlencode(values).encode("utf-8")
	req = urllib.request.Request(url, data, headers)
	response = urllib.request.urlopen(req)
	picture = response.read()
	#path = ['./pic/', '%04d'%i, '.png']
	#path = ''.join(path)
	path = os.path.join("./pic", "{:0>4d}.png".format(i))
	local = open(path, 'wb')
	local.write(picture)
	local.close()
	time.sleep(5)
