# Flight Delay Prediction API

## Description

This REST API, developed with the [Flask](https://flask.palletsprojects.com/en/2.2.x/) web framework in Python and exposed with a [Gunicorn](https://gunicorn.org) WSGI HTTP Server, is responsible for predicting the delay or non-delay of flights that land or take off from the Santiago de Chile airport (SCL).

---

## Structure  

The REST API file structure is the following: 

```bash
└── api
    ├── model
    │   └── pickle_model.pkl
    ├── app.py
    ├── Dockerfile
    ├── requirements.txt
    └── README.md
```

* `model/pickle_model.pkl` - previously trained Logistic Regression model
* `app.py` - API source code, is responsible for reading the model and making the prediction based on a request
* `Dockerfile` - uses a lightweight Python 3.8 image
* `requirements.txt` - file with the necessary python libraries

---

## REST request

To access the API prediction a JSON POST request is needed to the following endpoint:

```bash
API_ENDPOINT/prediction
```

The **API_ENDPOINT** value can be found at the end of the terraform log.

Example:

```bash
https://flight-prediction-yhenhj7rpq-uc.a.run.app/prediction
```

The request have the following JSON structure:

```json
{
    "feature_vector": "0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1"
}
```

The **feature_vector** value needs to be a csv styled string with 0's and 1's separated by commas, its length cant be lower or higher than 73 and the number of digits must be equal to 37.

---
## REST response

The response from the API is a JSON response with the following structure if predicts a flight delay ("Atraso"):

```json
{
    "predicted_class": "Atraso",
    "prediction": 1
}
```

If thats not the case ("No Atraso"), the response is the following:

```json
{
    "predicted_class": "No Atraso",
    "prediction": 0
}
```

---

## Local debugging  

To run the API locally: 

* Install the API requirements:

    ```bash
    pip install -r requirements.txt
    ```

* Run the Gunicorn server:

    ```bash
    gunicorn --bind :8080 --workers 1 --threads 8 app:app
    ```

* Generate a POST request to the (E.g. Postman):

    ```url
    http://0.0.0.0:8080/prediction
    ```

    ![POST request](/media/postman.png)