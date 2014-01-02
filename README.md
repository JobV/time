# JX-TIME

![codeship](https://www.codeship.io/projects/1fa65e50-1f27-0131-b372-7ed4fea82a1b/status)

project.hourly_rate is in cents
timer.total_time is in seconds

TODO
- add_index to everything to improve lookup
- set hourly rate in table view
- test views without being logged in - integration tests
- make rake task that calculates missing total_value
- calculate total_value in its own method
- !! cents to euros filter

# Setup

To run Time you need NPM and bower.
After installing those and running bundle install, run:
` rake bower:install`
