# TopPop API Client

## Overview

TopPop is a music video sorting game. To win this game, the players have to accurately sort a number of *top pop*ular music videos in order of their popularity.

This repo includes the TopPop API Client and a demo web application.

## Instructions

### 1. Install & setup

Clone the repo:
```bash
git clone https://github.com/PigeonBiz/TopPop_API
cd TopPop_API
```
Install all gems in Gemfile:
```bash
bundle install
```

### 2. Create an Access Token

Follow [this instruction](https://developers.google.com/youtube/v3/getting-started) to create a Youtube API access token.

Create `config/secrets.yml` file:
```bash
rake setup
```

Nano will open `config/secrets.yml` for edition. Insert your access token in this format:
```yml
---
  ACCESS_TOKEN: <YOUR_TOKEN_HERE>
```


### 3. Launch the web app

Run:
```bash
rake run
```
You should see the web app in port 9292 `http://localhost:9292/`.


## Branches

There are several branches with specific purposes on this repo:

- The `api_explore` branch serves the purpose of exploring Youtube API with a script called `project_info.rb`.

- The `api_library` branch has the `project_info.rb` made into a library.

- The `test_vcr` branch adds stubbing web calls (the vcr gem) and automated testing tools to the `api_library` branch.

- The `data-mapper` branch applies Enterprise Design Patterns.

- The `mvc` branch evolves with a web app following the Model-View-Controller (MVC) application architecture.

- The `database` branch evolves with database service.

## Database
1. ER Diagram
   ![alt text](TopPopERDiagram.PNG "ER Diagram")
2. Videos
  - Has following columns
    - id
    - video_id
      - uniqu
      - not null
    - title
    - publish_date
    - channel_title
    - view_count
      - not null
    - like_count
    - comment_count
    - created_time
    - updated_time
3. Players
  - Has following columns
    - id
    - name
      - uniqu
      - not null
    - score
      - not null
    - created_time
    - updated_time