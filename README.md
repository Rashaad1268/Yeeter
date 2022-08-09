# Yeeter - A Twitter parody

> #### Run `git clone https://github.com/Rashaad1268/Yeeter.git` to clone the repo


# Project structure
### The `src/` directory contains the source code
- `src/backend` is a django project
- `src/frontend` is a flutter app


# Setting up the backend
- `cd` Into the main directory

Run the following commands separately
```
pipenv install
pipenv shell
cd src/backend
python manage.py migrate
python manage.py createsuperuser
python manage.py runserver
```

And now the backend should be running at http://127.0.0.1:8000/


# Setting up the frontend
- `cd` Into the main directory

Run these commands
```
flutter pub get
flutter run -d device
```

> ### NOTE: The web version doesn't work due to CORS issues


# Making A web version of Yeeter

Currently Yeeter's mobile app version is made using flutter.
If anyone tries to run Yeeter on the web using flutters web version it won't work due to CORS errors.

#### So will there be a web version?
> Short answer: Yes hopefolly in the future

### Some notes on the web version
- Flutter won't be used for the web version of Yeeter. Instead a JavaScript framework will be used
- In the future the web version will be in the `src/` directory named `web_frontend`
- This will be using a JavaScript framework instead of flutter. But until that is created only a mobile version of this app will exist

> Feel free to create a web version of Yeeter by yourself using the existing backend


# Contributing
Any contributions are welcome!
I will write documentation later but until that you will have to figure stuff out alone 😔