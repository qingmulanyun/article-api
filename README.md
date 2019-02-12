# Article API

## App Information

- Language: Ruby 2.4.3
- Web: Rails 5.2.0
- DB: postgres
- Test: Rspec

## System Setup Information

1. Install ruby/rails/postgres, start postgres
2. Install dependencies ``bundle install``
3. Setup database ``rake db:setup``
4. Run unit tests ``rspec``
5. Start server ``rails s``
6. Go to the host with url ``http://localhost:3000/v1/articles/1``

## Description

Basically it's building a Restful API server based on Ruby on Rails. It only has one resource ``articles`` with 3 operations:

1. Get with id
2. Post wit required params
3. Get index list with 2 params.

- Structure 

    It's a typical MVC  architectural pattern project. So the most import things would be `controllers` `models` `serializers` folders.
    All these 3 folders live under ``app`` folder
    
    `controllers` holds all the controllers of business logic.
    
    `models` holds all the data models.
    
    `serializers` here is standing for the `V(view)` because this is an API server. We only render data into JSON format.
    
    All the config stuff live under `config` folder. `db` holds all the db migration files, seed file and schema.
    
    `spec` is the unit tests folder.
    
- Dependencies

    All the dependencies are displayed in `Gemfile`.
    
    1. use postgres as the Database
    2. active_model_serializers is for the model serializers to render JSON response
    3. rack-cors to enable CORS
    
    etc. 
    
- Points

    1. Followed by the requirements from the doc, using the postgres default id type (int sequence). But I would prefer to use uuid as id. More secure and avoid collisions. Easy to enable it in the existing app with following steps:
    
           class EnableUuidExtension < ActiveRecord::Migration
             def change
               enable_extension 'uuid-ossp'
             end
           end
           
            create_table :articles, id: :uuid  do |t|
               t.string :title
               ...
               t.timestamps
            end
     
    2. Add version to the API. In this way, we can make api updates without breaking old clients. So the API endpoints have been changed to
          
          GET  http://localhost:3000/v1/articles/{id}
          
          GET  http://localhost:3000/v1/tags/{tag_name}/{date}
          
          POST http://localhost:3000/v1/articles
    
    3. Made customized `Exceptions` module with customized Error code and Error message. Rescue and handle all the API Error in the base controller.
    
    4. Extract article creation logic to a service class. Create a new folder named `services`, try to extract most logic code to service classes and make them reusable. For example, if we have more following steps need to be done when creating a new article record, just add code to this service class instead of modifying the controller which should be focus on business logic.
     
    5. TDD. Followed TDD. Implement routes firstly, then implement all the unit test with Rspec and implement the contorller details at last.
    
    6. Add index to tag and date to improve the final endpoint performance. 
    
    7. Add a few parameters validation and error handling.
    
- Things to improve if given more time

    1. Add user model and authentication/authorization. (with JWT and Policy strategy)
    
    2. Add more validations(model level and parameters level)
    
    3. Add Docker configure to enable Docker.