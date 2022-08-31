# Rails simple question app

## Api only


```
  Ruby 3.0.+
  Rails 7
```

#### Clone the repo into your local machine

* Install Gems

```
  $ bundle install
```

* Migrate the database

```
  $ rake db:migrate
```

* Seed the database

```
  $ rake db:seed
```

* Run the server

```
  rails s
```

* Open a new terminal tab and test the apis

## APIS
```
|         API               |   METHOD  |     DESCRIPTION
============================|===========|==================
|      /register            | POST      | create new account   
|      /login               | POST      | get authorization token
|      /users               | DELETE    | delete account

|      /questions               | GET       | get all questions
|      /questions               | POST      | create new question
|      /questions/:id           | PATCH/PUT | update question body
|      /questions/:id           | DELETE    | delete question

| /questions/:question_id/answers  | GET       | get all answers of the question
| /questions/:question_id/answers  | POST      | submit answer for question
|      /answers/:id        | PATCH/PUT | update answer
|      /answers/:id        | DELETE    | delete answer
-------------------------------------------------------------------------
```

### APis and Params
```
|         API               |          PARAMS
============================|=============================
|      /register            | user: { email, password, password_confirmation }  
|      /login               | user: { email, password }
|      /users               | confirmation_password

|      /questions               | question: { title, body }, title is optional
|      /questions/:id           | question: { body }

| /questions/:question_id/answers  | commment: { body }
