# draughty

## Requirements
* Ruby 2.0
* Rails 4
* Postgres

## DB Setup
In order to prep the database for the draft you must first migrate the database: This will likely require you to create the postgres user and grant proper permissions for DB creation and other write operations

```
bundle exec rake db:migrate

bundle exec rake db:migrate RAILS_ENV=test
```

## Data Import
Data files are located in the import directory of the project. The following commands may be issued to import data:

```
bundle exec rake import:all
bundle exec rake import:teams
bundle exec rake import:players
bundle exec rake import:picks

To Reset:
bundle exec rake import:reset
```

## Simulate Draft
Autodraft will allow the user to automate the draft process. The system will choose a random time between 1 and 30 seconds before making the next draft pick. To run the auto draft feature, use the following command:

```
bundle exec rake draft:simulate
```

## Testing
```
bundle exec rspec
```

## TODOs
* Implement flash messages
* Cucumber Tests
* Jasmine Tests
