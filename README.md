# README

##Users Table
|model  |column  |data_type |
|:------|:------ |:------   |
|user   |name    |string    |
|       |email   |string    |
|       |password|string    |
|       |image   |text      |

##Tasks Table
|model  |column  |data_type |
|:------|:------ |:------   |
|task   |title   |string    |
|       |content |string    |
|       |date    |string    |
|       |time    |string    |

##Labels Table
|model  |column   |data_type |
|:------|:------  |:------   |
|label  |pripority|string    |
|       |status   |string    |
|       |web_app  |string    |
|       |design   |string    |
|       |pos      |string    |

##Deployment to Heroku
1. Create Heroku app
'heroku create'

1. Add the buildpack
'heroku buildpacks:set heroku/ruby'
'heroku buildpacks:add --index 1' heroku/nodejs

1. Precompile
'rails assets:precompile RAILS_ENV=production

1. Commit to github
'git add -A
'git commit -m "message"

1. Push master branch to Heroku
'git push heroku master

1. Run database migration
'heroku run rails db:migrate

** Note: If error occurs while precompiling, delete gem uglifier.**

##Version
- ruby '2.6.5'
- rails '~> 5.2.3'
- gem '3.0.3'
- heroku/7.51.0 darwin-64 node-v12.21.0
