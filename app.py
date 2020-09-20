import os
from wsgiref.simple_server import make_server

from flask import Flask, request
from selenium import webdriver
from bs4 import BeautifulSoup
import json
from bean.Result import Result

app = Flask(__name__)

currentPath = os.path.abspath(os.path.dirname(__file__))
logPath = currentPath + '/log/geckodriver.log'
# driver = webdriver.Firefox(service_log_path=logPath)
ce = "http://j1adong.tpddns.cn:4444/wd/hub"
driver = webdriver.Remote(command_executor=ce, desired_capabilities={
    "browserName": os.environ.get("browser", "firefox"),
    "platform": "Linux"
})

mhPrefix = 'http://www-mipengine-org.mipcdn.com/i/p3.manhuapan.com'


@app.route('/')
def hello_world():
    return 'Hello World!'


@app.route("/getcomic", methods=['get', 'post'])
def getCommic():
    # url = "https://manhua.fzdm.com/2/990/index_16.html"

    data = json.loads(request.get_data(as_text=True))
    url = data['url']

    driver.get(url)
    soup = BeautifulSoup(driver.page_source, 'lxml')

    imgDiv = soup.find(id="mhimg0")

    imgUrl = mhPrefix + str(imgDiv.find('img').attrs['src']).replace("http://", "")

    resData = {
        'imgurl': imgUrl
    }

    result = Result(code=1, data=resData).__dict__

    resultStr = json.dumps(result)

    return resultStr


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
