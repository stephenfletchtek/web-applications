# Commands issued during exercies

## 1. Intro to http
```bash
brew install curl

curl https://jsonplaceholder.typicode.com/todos/1
```

## 2. requests and responses
```bash
curl -X POST https://jsonplaceholder.typicode.com/todos/1

curl -X GET https://jsonplaceholder.typicode.com/todos/12

curl -X POST https://jsonplaceholder.typicode.com/todos
```

## 3. Postman
Use Postman to send a GET request to the URL https://postman-echo.com/get.

In the "Query params" section, set a query parameter with key title and value 'Welcome'. Then send the request.

You should get the following JSON response, and the status code should be 200 OK:


Use Postman to send a POST request to the URL https://postman-echo.com/post.In the "Body" tab below the URL field, select the option "form-data", and set a parameter with key title and value 'Welcome'. Then send the request.

You should get the following JSON response, and the status code should be 200 OK:

