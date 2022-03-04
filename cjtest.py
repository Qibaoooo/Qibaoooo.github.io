from django.shortcuts import render
from flask import Flask, render_template
app=Flask(__name__)

# https://flask.palletsprojects.com/en/2.0.x/api/#url-route-registrations
@app.route('/cjtest/')
def index():
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True,port=5011)