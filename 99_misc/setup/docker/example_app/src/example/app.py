import random
import time
from flask import Flask
from src.example.lib.util import error_codes

codes= error_codes
app = Flask(__name__)

@app.route('/')
def index():
    return f'''
<html>
    <head>
        <title>Home Page - Py app test</title>
    </head>
    <body>
        <h1>hello world</h1>
    </body>  
    ''', 200
@app.route('/alive')
def alive():
    time.sleep(2)
    error_code = random.choice(codes)
    return f'''
<html>
    <head>
        <title>Home Page - Py app test</title>
    </head>
    <body>
        <h1>{error_code} </h1>
    </body>    
    ''', error_code


