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

**Step 4:** Add this code to the top of your application controller, right below `class MyApp < Sinatra::Base`:

```ruby
DATABASE = FlatironBase.new("link to your database")
DATABASE.add_table("table name","placeholder hash")
```

**Step 5:** Sign up for a free hacker account from Firebase here: https://www.firebase.com/signup/

**Step 6:** Create a new app in your Firebase account dashboard. After you hit the "Create New App" button you should see your new database called something funny like `amber-fire-4558.firebaseIO.com`. Click on the link to see your database. 
 
**Step 5:** Copy the URL in your browser's navigation bar. Your app will be communicating with your Firebase database via this link.

+ If this page looks scary to you DON'T WORRY! As you add data to the database you'll be able to see a graphical representation of it here. We'll be interacting with the database mostly through our app though. 

**Step 6:** Paste the URL from Step 5 into the code we added at the top of the application controller (replacing "link to your database"). Like this:

```ruby
DATABASE = FlatironBase.new("https://your-database-4558.firebaseio.com/")
```

**Step 7:** Change the string "table name" in the `add_table` method to the name of whatever table you want to add. I'm going to create a "users" table. Like this:

```ruby
DATABASE.add_table("users", {"name" => "Bob", "email" => "bob@bob.com", "password" => "passwordforbob"})
```

When this app runs for the first time it will create a "users" table with a row for "Bob". **Note: Creating a placeholder hash with the actual attributes that you want to save (for example: name, email, password) will make your life MUCH easier.**

+ The rest of these steps will need to be highly customized by you, based on the needs of your app. We'll be walking through how to add users to a database as an example. There is an example app in the `demo` folder of this repo. __These instructions assume that you already have a form properly set up in your application.__

**Step 8: Adding Data to You Database**

In our `demo` app you'll see a standard sign up form in `index.erb`. It is set up to send data to a `post '/signup'` route. Within that route we're calling this method to add data from our form to the database:

```ruby
DATABASE.add("users", {"name" => params[:name], "email" => params[:email], "password" => params[:password]})
```
You'll notice that this looks very similar to the code we used to set up our "users" table - this is intentional. Firebase always requires two pieces of information - the table name and a hash of the information that you want to save to the database. This hash is setting the fields name, email and password to the values that were input in the form (via the params hash).

Test this out in your own app. If it works properly you should begin to see the data in your Firebase dashboard.

**Step 9: Accessing the Data**

We've created a `get_data` method for you that will return an array of all the entries in the database when you call it like this:

```ruby
DATABASE.get_data
```
We've also created a `search_by_attribute` method that can be used to search for specific entries in your database. 

Note: This is a very basic search method. If you are looking for someone named Bob and there are multiple Bobs in your database it will just return the last one it finds. If you want to find a specific entry you'll need to base your search on information that is unique to each entry. There are almost no restrictions on what kind of information can be added to a Firebase database, so it will be up to you to police any data added to the system. Take a look at the `post '/signup'` method in the demo for an example of how you can prevent duplicate entries.


