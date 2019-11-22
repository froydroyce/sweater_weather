# Project: Sweater Weather

## Visit the app on Heroku:
https://hidden-savannah-05612.herokuapp.com/api/v1
(Endpoints required)

## About the Project  
* Sweater Weather is an API with endpoints that produce weather data for specific locations, meant to be consumed by a hypothetical front end, pictured above. It utilizes APIs from Google, Dark Sky and Flickr to gather relevant information, and formats it for consumption.

## Tech Stack
- Ruby on Rails
- ActiveRecord
- Fast JSON API
- PostgreSQL

## Local Setup
  ### Instructions:
  1. Clone the GitHub repository
  2. Go to the directory with the new repo  
  3. Run `bundle install`
  4. Setup database: `rails db:{create,migrate}`
  5. Set up environment variables in `config/application.yml`:
  
      a) [Dark Sky API key](https://darksky.net/dev/) `DARKSKY_API: <API_KEY>`
      
      b) [Flickr API key](https://www.flickr.com/services/api/) `FLICKR_API: <API_KEY`
      
      c) [Google API key](https://developers.google.com/maps/documentation/embed/get-api-key/) `GOOGLE_KEY: <API_KEY>`
  6. To run the server: `rails s`
  7. Open your browser, and visit `http://localhost:3000/`

  ### Run tests:
  1. Run `rspec`
  2. To generate coverage report: `open coverage/index.html`


## Endpoints

#### 1) Forcast for a location

***Request:***
```
GET /api/v1/forcast?location=<city,state>
Content-Type: application/json
Accept: application/json
```

***Response Example:***
```
{
    "data": {
        "id": null,
        "type": "location_forecast",
        "attributes": {
            "address": "Denver, CO, USA",
            "summary": "Partly Cloudy",
            "icon": "partly-cloudy-day",
            "date": "07-31",
            "time": "07:13PM",
            "temp": 88,
            "feels_like": 88,
            "forecast_high": 86,
            "forecast_low": 65,
            "percent_humidity": 28,
            "visibility_miles": 4.55,
            "uv_index": 9,
            "hourly_forecast": [
                {
                    "time": "07:13PM",
                    "temp": 88
                },
                {
                    "time": "07:13PM",
                    "temp": 88
                },
                {
                    "time": "07:13PM",
                    "temp": 88
                },
                {
                    "time": "07:13PM",
                    "temp": 88
                },
                {
                    "time": "07:13PM",
                    "temp": 88
                },
                {
                    "time": "07:13PM",
                    "temp": 88
                },
                {
                    "time": "07:13PM",
                    "temp": 88
                },
                {
                    "time": "07:13PM",
                    "temp": 88
                }
            ],
            "daily_forecast": [
                {
                    "day": "Wednesday",
                    "summary": "Partly Cloudy",
                    "icon": "partly-cloudy-day",
                    "percent_humidity": 28,
                    "forecast_high": 86,
                    "forecast_low": 65
                },
                {
                    "day": "Wednesday",
                    "summary": "Partly Cloudy",
                    "icon": "partly-cloudy-day",
                    "percent_humidity": 28,
                    "forecast_high": 86,
                    "forecast_low": 65
                },
                {
                    "day": "Wednesday",
                    "summary": "Partly Cloudy",
                    "icon": "partly-cloudy-day",
                    "percent_humidity": 28,
                    "forecast_high": 86,
                    "forecast_low": 65
                },
                {
                    "day": "Wednesday",
                    "summary": "Partly Cloudy",
                    "icon": "partly-cloudy-day",
                    "percent_humidity": 28,
                    "forecast_high": 86,
                    "forecast_low": 65
                },
                {
                    "day": "Wednesday",
                    "summary": "Partly Cloudy",
                    "icon": "partly-cloudy-day",
                    "percent_humidity": 28,
                    "forecast_high": 86,
                    "forecast_low": 65
                }
            ]
        }
    }
}
```

#### 2) Background image for a location 

***Request:***
```
GET /api/v1/forcast?location=<city,state>
Content-Type: application/json
Accept: application/json
```

***Response Example:***
```
{
    "data": {
        "id": null,
        "type": "background",
        "attributes": {
            "image": {
                "url": "https://farm1.staticflickr.com/930/43691964192_4ff507454d.jpg"
            }
        }
    }
}
```

#### 3) User Creation

***Request:***
```
POST /api/v1/users
params: {
  email: "example@example.com",
  password: "password",
  password_confirmation: "password"
}
Content-Type: application/json
Accept: application/json
```

***Response Example:***
```
{
    "data": {
        "id": "3",
        "type": "user",
        "attributes": {
            "api_key": "YQZQcg0Wg2TrDkfwYGUYXQ"
        }
    }
}
```

#### 4) Session Creation

***Request:***
```
POST /api/v1/sessions
params: {
  email: "example@example.com",
  password: "password",
}
Content-Type: application/json
Accept: application/json
```

***Response Example:***
```
{
    "data": {
        "id": "3",
        "type": "user",
        "attributes": {
            "api_key": "YQZQcg0Wg2TrDkfwYGUYXQ"
        }
    }
}
```

#### 5) Forecast for a destination at the time of arrival

***Request:***
```
POST /api/v1/road_trip
params: {
  origin: "example@example.com",
  destination: "password",
  api_key: "YQZQcg0Wg2TrDkfwYGUYXQ"
}
Content-Type: application/json
Accept: application/json
```

***Response Example:***
```
{
    "data": {
        "id": null,
        "type": "road_trip",
        "attributes": {
            "travel_time": {
                "duration": {
                    "text": "1 hour 48 mins",
                    "value": 6450
                }
            },
            "forecast": {
                "time": 1574473298,
                "summary": "Overcast",
                "icon": "cloudy",
                "precipIntensity": 0.0019,
                "precipProbability": 0.02,
                "precipType": "snow",
                "precipAccumulation": 0.0183,
                "temperature": 25.55,
                "apparentTemperature": 25.55,
                "dewPoint": 21.5,
                "humidity": 0.84,
                "pressure": 1020.3,
                "windSpeed": 1.86,
                "windGust": 2.32,
                "windBearing": 33,
                "cloudCover": 1,
                "uvIndex": 0,
                "visibility": 10,
                "ozone": 297.9
            }
        }
    }
}
```
