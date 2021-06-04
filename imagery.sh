rvm use 2.4.0
rvm gemset use default
rails new imagery-api --api -d postgresql
rails g model Tag name:string
rails g model Image name:string width:integer height:integer url:string tags:reference

