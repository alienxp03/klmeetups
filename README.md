[ ![Codeship Status for alienxp03/malaysiameetups](https://codeship.com/projects/eebb8860-bbc4-0133-8370-72d8958adba6/status?branch=master)](https://codeship.com/projects/135999)

#Malaysia Events

I thought it would be a good idea if I can discover events from Facebook groups, or Meetup. I got the idea from <a href="https://github.com/webuildsg/webuild" target="_blank">webuildsg</a>.

##API endpoints

- <a href="https://malaysia.herokuapp.com/api/events" target="_blank">/api/events</a>

##Contributions
I need help, of course. Currently it will only find events based on groups, which are defined in <a href="https://github.com/alienxp03/malaysiameetups/blob/master/app/controllers/api/facebook_groups.rb" target="_blank">FacebookGroups</a>. You can either create a new pull request, or submit an issue.

You can find the group id using <a href="https://lookup-id.com/" target="_blank">lookup-id</a>


## Quick start

1. Clone this project and bundle install:

  ```sh
git clone git@github.com:alienxp03/malaysiameetups.git && cd malaysiameetups
bundle install
  ```

2. Setup environment variables. Check file `.env.example`.

3. Setup database. Check file `database.yml.example`.

4. Run `rake db:create && rake:db:migrate`

5. Run `rails server`

## TODO
- Write tests
- Add more Facebook groups
- Add events manually

##License
MIT (obviously)
