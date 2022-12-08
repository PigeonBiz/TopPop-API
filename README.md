# TopPop Web API

Web API for TopPop web app

## Routes

### Root check

`GET /`

Status:

- 200: API server running (happy)

### Search 10 videos

`GET /api/v1/search/{search_keyword}`

Status

- 200: video list returned (happy)
- 500: problems accessing Youtube API or creating video list (bad)

<!-- ### Store a project for appraisal

`POST /projects/{owner_name}/{project_name}`

Status

- 201: project stored (happy)
- 404: project or folder not found on Github (sad)
- 500: problems storing the project (bad) -->
