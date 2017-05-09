# README

## Guidelines

- Don't Repeat Yourself
  - Every piece of knowledge must have a single, unambiguous, authoritative representation within a system
- Convention over configuration
- Style
- Property based tests

### 

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

### Run & Test

```shell
bin/rails server
# browse http://localhost:3000/
```

### Development

```shell
# new controller
bin/rails generate controller Welcome index


# new resources
# update config/routes.rb with `resources` DSL
bin/rails routes
# generate related controller
bin/rails generate controller Articles

# new model
bin/rails generate model Article title:string text:text
```

### Environment (ARCH Linux)

```shell
pac ruby sqlite3 nodejs
ruby -v
sqlite3 --version
gem install rails
rails --version

# rails new rails-quest
```
