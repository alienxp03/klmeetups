#Malaysia Events

I thought it would be a good idea if I can discover events from Facebook groups, or Meetup. I got the idea from <a href="https://github.com/webuildsg/webuild" target="_blank">webuildsg</a>.


##API endpoints

- <a href="https://malaysia.herokuapp.com/api/events" target="_blank">/api/events</a>

##Contributions
I need help, of course. Currently it will only find events based on groups, which are defined in <a href="https://github.com/alienxp03/malaysiameetups/blob/master/app/controllers/api/facebook_groups.rb" target="_blank">FacebookGroups</a>. You can either create a new pull request, or submit an issue.


## Quick start

1. Clone this project and bundle install:

  ```sh
git clone git@github.com:alienxp03/malaysiameetups.git && cd malaysia
bundle install
  ```

2. Setup environment variables. Check file `.env.example`.

3. Setup database. Check file `.database.yml.example`.

4. Run `rake db:create && rake:db:migrate`

5. Run `rails server`

## TODO
- Write tests
- Add more Facebook groups
- Add Meetup API
- Add events manually

##License
MIT (obviously)
