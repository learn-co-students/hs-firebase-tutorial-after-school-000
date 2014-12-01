---
tags: ruby, sinatra, firebase, kids
languages: ruby
level: 3
---

## Firebase Tutorial

Follow along with these step by step instructions to set up a Firebase database for your app

**Step 1:** Add the 'firebase' gem to your Gemfile and then run `bundle install` from your terminal.

**Step 2:** Create a firebase.rb file in your models directory and add this sweet code that Joe Cutler wrote: [Flatiron-Firebase-Simplified](https://gist.github.com/vanessadean/b6d8bb272063697a44e6)

**Step 3:** Connect your new `firebase.rb` file to `application_controller.rb` with `require_relative`. 

**Step 4:** Add this code to the top of your application controller) right below `class MyApp < Sinatra::Base`:

```ruby
DATABASE = FlatironBase.new("link to your database")
DATABASE.add_table("table name")
```

**Step 5:** Sign up for a free hacker account from Firebase here: https://www.firebase.com/signup/

**Step 6:** Create a new app in your Firebase account. After you hit the "Create New App" button you should see your new database called something funny like `amber-fire-4558.firebaseIO.com`. Click on the link to see your database. 
 
**Step 5:** Copy the URL in your browser's navigation bar. Your app will be communicating with your Firebase database with this link.

+ If this page looks scary to you DON'T WORRY! As you add data to the database you'll be able to see a graphical representation of it here. We'll be interacting with the database mostly through our app though. 

**Step 6:** Paste the URL from Step 5 above into the code we added to the top of your application controller. Like this:

```ruby
DATABASE = FlatironBase.new("https://your-database-4558.firebaseio.com/")
```

**Step 7:** Change the string "table name" in the `add_table` method to the name of whatever table you want to add. I'm going to create a "users" table. Like this:

```ruby
DATABASE.add_table("users")
```



