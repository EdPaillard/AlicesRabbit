# AlicesRabbit

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

# API endpoints
*When two clocks are posted for a single user, a workingtime is created for that user*

## Users
  - **GET:** /api/users?email=:data&username=:data
  - **GET:** /api/users/:users_id
  - **POST:** /api/users
  - **PUT:** /api/users/users_id
  - **DELETE:** /api/users/:users_id

## Clocks
  - **GET:** /api/clocks/:users_id
  - **POST:** /api/clocks/:users_id

## Workingtimes
  - **GET:** /api/workingtimes/:users_id?start=:data&end=:data
  - **GET:** /api/workingtimes/:users_id/:id
  - **POST:** /api/workingtimes/:users_id
  - **PUT:** /api/workingtimes/:id
  - **DELETE:** /api/workingtimes/:id
