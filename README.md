## Commit APIs:
There are two APIs, One for the show code differences for any given commit from any given open source github repository and another one to get a commit details.

## Dependencies

Ruby Version: 3.0.4

Rails Version: 6.0.6.1

## Setup Instructions

Clone this Repository

Run - bundle install

To run Application: rails s

## API Details
1. Commit details API

GET - http://localhost:3000/repositories/{owner}/{repository}/commits/{commit_id}

example

http://localhost:3000/repositories/golemfactory/clay/commits/a1bf367b3af680b1182cc52bb77ba095764a11f9


2. Show code differences for any given commit API

GET - http://localhost:3000/repositories/{owner}/{repository}/commits/{commit_id}/diff

example

http://localhost:3000/repositories/golemfactory/clay/commits/a1bf367b3af680b1182cc52bb77ba095764a11f9/diff
