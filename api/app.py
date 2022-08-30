import os
import flask

# Load the libraries
from flask import jsonify, request
from joblib import load

import pandas as pd
import numpy as np

# Load the model
model = load(open('./model/pickle_model.pkl','rb'))

# Initialize an instance of FastAPI
app = flask.Flask(__name__)

# Define the default route 
@app.route('/', methods=['GET'])
def index():
    return "Machine Learning API Inference for Flight Delay prediction"

# Define the prediction route 
@app.route('/prediction', methods=['POST'])
def prediction():
    try:
        feature_vector = request.json['feature_vector'].split(",")
        feature_vector = pd.DataFrame([int(x) for x in feature_vector]).T.to_numpy()
    
        prediction = model.predict(feature_vector)

        predicted_class = ""

        if(prediction[0] == 0):
           predicted_class = "No Atraso"

        elif(prediction[0] == 1):
           predicted_class = "Atraso"

        return jsonify({'prediction': int(prediction[0]),'predicted_class': predicted_class}), 200

    except Exception as e:
	    return f"Ha ocurrido un error: {e}"

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=8080)
