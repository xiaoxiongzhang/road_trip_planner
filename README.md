# Road Trip Planner

## description
- see: https://chilun.feishu.cn/docx/doxcnAlDNl6OBZOE0TJDtrhhVtf

## environment
- ruby (>3.0.4)
- rails (~7.0.3.1)
- mysql (>5.7)

## setup instruction
- local develop setup instruction
  ~~~ 
  rails db:create
  rails db:migrate
  rails db:seed
  rails server -b 0.0.0.0
  
## functions instruction
- Models definition
  - file path: {root_path}/db/migrate/*
  - models
    - users
    - trips
    - destinations
    - destinations_trips
- Data scrapper
  - code path: {root_path}/db/seeds.rb
  - instruction:
    ~~~
    Get museums and parse HTML from https://chilun.feishu.cn/docx/doxcnAlDNl6OBZOE0TJDtrhhVtf
    use gem 'mechanize'
    
- Controllers&Views instruction
  - create trip
    - C: trip#create
    - V: app/views/trip/new.html.erb
  - shows art museum list
    - C: destination#index
    - V: app/views/destination/index.html.erb
  - search filter museums
    - C: destination#search
    - V: app/views/destination/index.html.erb
  - .etc


