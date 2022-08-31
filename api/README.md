# Flight Delay Prediction API

## Description

This REST API is responsible for predicting the delay or non-delay of flights that land or take off from the Santiago de Chile airport (SCL).

---

## Structure  

The REST API file structure is the following: 

* `model/pickle_model.pkl` - previously trained logistic regression model
* `app.py` - API source code, It is responsible for reading the model and making the prediction
* `Dockerfile` - uses a lightweight Python 3.8 image
* `requirements.txt` - file with the necessary python libraries

---

## REST request

To access the API prediction a JSON POST request is needed with the following structure:

```
{
    "feature_vector": "0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1"
}
```

The feature_vector value needs to be a csv styled string with 0's and 1's separated by commas, its length cant be lower or higher than 73 and the number of digits must be equal to 37.

---
## REST response

The response from the API is a JSON response with the following structure if predicts a flight delay ("Atraso"):

```
{
    "predicted_class": "Atraso",
    "prediction": 1
}
```

If thats not the case ("No Atraso"), the response is the following:

```
{
    "predicted_class": "No Atraso",
    "prediction": 0
}
```

---

## Local debugging  

To run the API locally: 

* Install the API requirements:

    ```
    pip install -r requirements.txt
    ```

* Run the Gunicorn server:

    ```
    gunicorn --bind :8080 --workers 1 --threads 8 app:app
    ```

* Generate a POST request (E.g. Postman):

    ![POST request](/media/postman.png)