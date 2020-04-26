# README

This is the first part of the Facebookish clone app.

This is just the API, to try the whole application you must also clone the react application [React Application (client)](https://github.com/GuillaumeOcculy/react-blog).

## Informations
There is no security/performance because I'm too lazy to do it for a draft project.


## Instructions

1. Install [Docker](https://www.docker.com/)
2. Open your terminal and clone this repo
3. `docker-compose run web bash` then `rake db:create db:migrate db:seed` and quit bash (`Ctrl + C`)
4. `docker-compose up`
5. Open a new tab
6. Go to the [react repo](https://github.com/GuillaumeOcculy/react-blog)

## Users
The `login` of the first user is "guillaume"
All the users have the `password` "password"

### Stack
- Rails 6
- Ruby 2.7
- Postgresql
- Elastisearch
- FastJsonAPI
- Shrine
