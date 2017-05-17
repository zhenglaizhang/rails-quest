# Agile Web Development with Rails

### TODOs

- code analysis
- formatting tool
- fix tests

## Guidelines

- Don't Repeat Yourself
  - Every piece of knowledge must have a single, unambiguous, authoritative representation within a system
- Convention over configuration
- Consistent code style
- Code Analysis tools applied
- Property based tests
- Cache high-traffic area

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
bin/rails seed
bin/rails test
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
# run migration
bin/rails db:migrate
bin/rails db:migrate RAILS_ENV=production

# new scaffold
bin/rails generate scaffold Product title:string description:text image_url:string price:decimal


# enable development mode cache
bin/rails dev:cache
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


## Study Plan

- [ ] ruby culture
- [ ] pure ruby
- [ ] ruby tooling (`irb`, `ruby`)
- [ ] functional ruby
- [ ] functional ruby

## How to learn Ruby

- `irb`

### Doc

```shell
export RI="--format ansi --width 70"
ri GC
ri GC::eanble
ri assoc
```

### Rake

> https://martinfowler.com/articles/rake.html

```shell
cd scripts
rake delete_backups
rake -T
```
