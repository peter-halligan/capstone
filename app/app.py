from flask import Flask, json

app = Flask(__name__)

@app.route('/')
def helloWorld():
    return  json.dumps({'hello': 'world'})
    
if __name__ == "__main__":
    app.run(host='0.0.0.0', port=8081, debug=True)
