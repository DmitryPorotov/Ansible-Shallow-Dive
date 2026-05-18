from src.example.app import app

DEBUG=True
HOST='0.0.0.0'
PORT=8000

app.run(host=HOST,port=PORT,debug=DEBUG)