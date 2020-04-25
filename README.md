# README

This is the first part of the Facebookish clone app.

This is just the API, to try the whole application you must also clone the react application [React Application (client)](https://github.com/GuillaumeOcculy/react-blog).

## Informations
There is no security/performance because I'm too lazy to do it for a draft project.


## Instructions

1. Clone this repo
2. Install [Docker](https://www.docker.com/)
3. `docker-compose run web bash` then `rake db:migrate db:seed` and quit bash
4. `docker-compose up`
5. Go to the [react repo](https://github.com/GuillaumeOcculy/react-blog)

### Stack
- Rails 6
- Ruby 2.7
- Postgresql
- Elastisearch
- FastJsonAPI
- Shrine
