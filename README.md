# README

### Requirements ###

Create a web API that clients can use to query images by one or more tags.

### Expected Input ###

- Max number of images in the results.
- Image keywords to match image tags (as comma-separated-values, i.e. “blue, flowers, desert”)

### Expected Output ###

- Total number of results
- Image URL
- Image Width
- Image Height

The output should be in JSON format.

### Initial Steps taken to start the project ###

```shell
rvm use 2.4.0
rvm gemset use default
rails new imagery-api --api -d postgresql
cd imagery-api
git init
git add --all
git commit -m "Initial Commit"
git remote add origin git@github.com:ealvaro/imagery-api.git
rails g scaffold Tag name:string
vim db/seeds
bundle exec rake db:create db:migrate db:seed
rails g scaffold Image name:string width:integer height:integer url:string
rails db:migrate db:seed
rails g migration CreateJoinTableImageTag image tag

```

### Heroku related steps ###

```shell
wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh
heroku run -a imagery-api -- rake db:migrate db:seed
```

### Some Sample Calls to the API ###

```shell
curl -i -X GET http://localhost:3000/tags -H "Content-Type: application/json" -H "Accept: application/json"
curl -i -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d '{"name":"pool"}' http://localhost:3000/tags
curl -i -X GET http://localhost:3000/images -H "Content-Type: application/json" -H "Accept: application/json"
curl -i -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d '{"image":{"name":"Pic999","width":100,"height":100,"url":"https://unsplash.com/photos/3Vr4qQvQn34","tags":[{"name":"fruit"},{"name":"beach"}]}}' http://localhost:3000/images
curl -i -X POST -H "Content-Type: application/json" -H "Accept: application/json" -d '{"image":{"name":"Pic999","width":100,"height":100,"url":"https://unsplash.com/photos/4_RwGQCveHQ","tags":[{"name":"woman"},{"name":"beach"}]}}' http://localhost:3000/images
```
