# draughty

## Requirements
* Ruby 2.0
* Rails 4
* Sqlite

## DB Setup
In order to prep the database for the draft you must first migrate the database:

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

This command is destructive and will empty all records from the DB tables
```

## Simulate Draft
Autodraft will allow the user to automate the draft process. The system will choose a random time between 1 and 30 seconds before making the next draft pick. To run the auto draft feature, use the following command:

```
bundle exec rake draft:simulate
```

While running this task, as a user you will be able to monitor realtime picks and updates

## Testing
```
bundle exec rspec
```

## TODOs
* Cucumber Tests
* Jasmine Tests
