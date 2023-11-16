#Shortener Service - Oivan test

## Introduction
- Application for shorten url
- Login/Register
- if the URL has been shortened, Application just query and response url has been shortened (Not generate new shorten URL)

## Prerequisites

  |       Rails       |      Ruby        | Postgres     |
  | :------------:|:-------------:|:-----:|
  |    7.0.8          |        3.1.4       |  13    |

## Installation & Configuration

  1. Step 1: Create .env file *example:

  ```sh
  RAILS_ENV=development
  APP_HOST=146.190.107.33
  JWT_SECRET=de846910c295f4394ac29580bcd47637f62bc03a5abcd6adcdd025872e35af11526d577a0886b2d2973cc8b8b957457b0ceea6399e4d38f96ecec1f446cac7c1
  DATABASE_USERNAME=postgres
  DATABASE_PASSWORD=postgres
  ```

  2. Step 2: Create Database & Migration

  ```sh
  rails db:create
  rails db:migrate
  ```

## Unit test
- Gem: factory_bot_rails, rspec-rails
  ```sh
  RAILS_ENV=test bundle exec rspec
  ```

## Usage
** Change to http://localhost:3000/ if run application on local
1. Step 1: Use Postmain to register:
 - endpoin: http://146.190.107.33/api/register
 - body:
    ```sh
    {
        "first_name": "example",
        "last_name": "name",
        "email": "example01@example.com",
        "password": "123456"
    }
    ```
  - response:
    ```sh
    {
        "id": 2,
        "email": "example01@example.com",
        "first_name": "example",
        "last_name": "name"
    }
    ```
2. Step 2: Use Postmain to login:
 - endpoin: http://146.190.107.33/api/login
 - body:
    ```sh
    {
        "email": "example01@example.com",
        "password": "123456"
    }
    ```
  - respone:
    ```sh
    {
      "user": {
          "id": 2,
          "email": "example01@example.com",
          "first_name": "example",
          "last_name": "name"
      },
      "auth_token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.s_VhAx9n322eHsCWA8a63NWdeRfRYnxEDkCaf5ovRvQ"
    }
    ```
3. Step 3: Use Postmain to shorten url:
 - endpoin: http://146.190.107.33/api/shortens
 - In tab Headers: add filed "Authorization" with value is auth_token in step 2
 - body:
    ```sh
    {
        "original_url": "https://www.youtube.com/watch?v=fwfF6KRLKDw"
    }
    ```

3. Step 4: Copy and paste shortened_url response from the data respone to Browser.
