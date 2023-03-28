from flask import Flask, jsonify
from pymongo import MongoClient
import random

app = Flask(__name__)

client = MongoClient(
    'mongodb://localhost:27021/?directConnection=true')
db = client.stajdb
collection = db.iller


@app.route('/')
def hello_world():
    return 'Merhaba Python!'


@app.route('/staj')
def get_random_city():
    cities = list(collection.find({}, {'_id': False}))
    random_city = random.choice(cities)
    return jsonify(random_city)


app.run(host='0.0.0.0', port=4444)
