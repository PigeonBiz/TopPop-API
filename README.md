# TopPop API Client

## Overview

TopPop is a music video sorting game. To win this game, the players have to accurately sort a number of *top pop*ular music videos in order of their popularity.

This API client gets a specific *count number* of videos from Youtube API based on specific *search key word*. This action mocks TopPop's real call to Youtube server to query elements of the game.


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
Create `config/secrets.yml` file:
```bash
rake setup
```


### 2. Create an Access Token

Follow [this instruction](https://developers.google.com/youtube/v3/getting-started) to create a Youtube API access token.

Inside `config/secrets.yml`, insert your access token in this format:
```yml
---
  ACCESS_TOKEN: <YOUR_TOKEN_HERE>
```


### 3. Query Youtube video data

Run:
```bash
ruby lib/project_info.rb
```
You should see the result in `spec/fixtures/yt_results.yml`.


### 4. Static-analysis quality checks

Available commands:
```bash
rake quality:all # Run run all static-analysis quality checks
rake quality:rubocop # Run code style linter
rake quality:reek # Run code smell detector
rake quality:flog # Run complexiy analysis
```