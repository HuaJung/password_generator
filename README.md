# Password Generator

## Overview

This project is built upon the original structure of a new Phoenix project, with additional functionalities developed on top for the practice purpose. Two methods are offered for generating passwords: a server-side rendered approach using HEEx templates and a REST API. 


## Server-side Rendered Password Generation

In order to utilize the form helpers provided by Phoenix in our HEEx templates, the line import `Phoenix.HTML.Form` was added in `html_helpers/0` in the `web.ex` file.  
  
The HEEx implementation for the server-side rendered of the application. 

1. Run the application using the `mix phx.server` command.
2. Open a web browser and navigate to `http://localhost:4000`.
3. Follow the on-screen instructions to generate a password.
   
   ![image](https://github.com/HuaJung/password_generator/blob/main/password_generator.png)

## API-based Password Generation

To use the API, make a POST request to `http://localhost:4000/api/password-generator`, passing the desired password strength, whether nubmers, uppsercase, symbols is requried (set to true) in the request body.

Here's an example using curl:

```
curl -X POST -H "Content-Type: application/json" -d '{"length": "10", "number": "true", "uppercase": "true", "symbols": "true"}' http://localhost:4000/api/password-generator
```

The API will return a JSON response containing the generated password. The status codes of the responses will also indicate whether the password generation was successful or not.

Implemented unit tests to ensure the API is functioning correctly.

## Installation

1. Clone the repository.
2. Install dependencies with `mix deps.get`.
3. Configure the database in config/dev.exs and run `mix ecto.create`.
4. Start Phoenix endpoint with `mix phx.server`.

Now you can visit [`localhost:4000/password-generator`](http://localhost:4000/password-generator) from your browser.

## Running Tests

Tests can be run using the `mix test test/password_generator_web/controllers/api` command.

## Contact

mspanda1026@gmail.com

---

