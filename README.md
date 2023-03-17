# TopPop API

## Overview 

TopPop is a music video sorting game. To win this game, you have to accurately sort a number of *top pop*ular music videos in order of their popularity.

TopPop source code contains [the web application repo](https://github.com/PigeonBiz/TopPop-APP) and the web api repo (this repo). Built with Roda, PostgreSQL, Redis, AWS Simple Queue Service.

<!-- The web API application is live here: [https://toppop-api.herokuapp.com](https://toppop-api.herokuapp.com).

The web application is live here: [https://toppop.herokuapp.com](https://toppop.herokuapp.com). -->


## Instructions 

Instructions to run the TopPop api app on local environment

### 1. Install

Clone the repo:
```bash
git clone https://github.com/PigeonBiz/TopPop-API
cd TopPop-API
```
Install all gems in Gemfile:
```bash
bundle install
```

### 2. Input variables in `config/secrets.yml`

Clone `secrets_example.yml`, input all variables, rename `secrets.yml`.

Required variables:

 - ACCESS_TOKEN: Youtube API v3 access token
 - REDISCLOUD_URL: url assigned by Redis provider on Heroku
 - AWS_ACCESS_KEY_ID: aws credential
 - AWS_SECRET_ACCESS_KEY: aws credential
 - AWS_REGION: aws instance region
 - QUEUE: aws sqs queue name
 - QUEUE_URL: url assigned by aws

### 3. Launch the web api on local environment (in development mode)

Run:
```bash
RACK_ENV=development rake db:migrate
RACK_ENV=development rake run:dev
```

You should see the api app live on port 9009 `http://localhost:9009`.

You can call the API like below.



## Routes

### Root check

`GET /`

Status:

- 200: API server running

### Search 10 videos on Youtube

`GET /api/v1/search/{search_keyword}`

Status

- 200: video list returned
- 500: problems accessing Youtube API or creating video list

### Show all videos in database

`GET /api/v1/search`

Status

- 200: video list returned
- 500: internal error

### Add/ delete video

`GET /api/v1/add/{video_id}`

`GET /api/v1/delete/{video_id}`

Status

- 200: success
- 500: internal error



## Contributors

PigeonBiz Team:

- [朱凱翊](https://github.com/s28238385)
- [Tran Le Hai Anh](https://github.com/hannahguppy)
- [邱沛語](https://github.com/astridchiou)

Special thanks for our instructor [Soumya Ray](https://github.com/soumyaray) and the teaching assistants [林天佑](https://github.com/tienyulin) and [劉羽玄](https://github.com/emily1129).
