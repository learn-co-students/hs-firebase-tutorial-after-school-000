---
tags: ruby, sinatra, firebase, kids
languages: ruby
level: 3
---

## Firebase Tutorial

Fork and clone this tutorial then follow along with the step-by-step instructions to set up a Firebase database for your app. 

We've included a demo for you, but you should be adding the code below to your own app.

**Step 1:** Add the 'firebase' gem to your Gemfile and then run `bundle install` from your terminal.

**Step 2:** Create a firebase.rb file in your models directory and add this sweet code that Joe Cutler wrote: [Flatiron-Firebase-Simplified](https://gist.github.com/vanessadean/b6d8bb272063697a44e6)

**Step 3:** Connect your new `firebase.rb` file to `application_controller.rb` with `require_relative "./firebase.rb"`. 

**Step 4:** Add this code to the top of your application controller, right below `class MyApp < Sinatra::Base`:

```ruby
DATABASE = FlatironBase.new("link to your database")
DATABASE.add_table("table name","hash of data that will be saved to table")
```

**Step 5:** Sign up for a free hacker account from Firebase here: https://www.firebase.com/signup/ 

**Step 6:** After signing up you'll be redirected to your Firebase dashboard. At the bottom of the page you should see a box that says "My First App" with a database called something funny like `amber-fire-4558.firebaseIO.com`. Click on the link to see your database. 
 
**Step 5:** Copy the URL in your browser's navigation bar. Your app will be communicating with your Firebase database via this link.

+ If this page looks scary to you DON'T WORRY! We'll be interacting with the database mostly through our app and as you add data to the database you'll be able to see a graphical representation of it here.

**Step 6:** Go back to your application controller and find the `FlatironBase.new` method. Replace the string "link to your database" with the URL that you copied in Step 5. Like this:

```ruby
DATABASE = FlatironBase.new("https://your-database-4558.firebaseio.com/")
```

**Step 7:** Change the string "table name" in the `add_table` method to the name of whatever table you want to add. I'm going to create a "users" table. 

We are also going to replace the placeholder "hash of data that will be saved to table" with an actual hash. For instance, I want to save a name, email and password for each of my users. To save this information I need send Firebase a hash with keys that are labels for the data and values that are the actual data. The hash looks like this:

{"name" => "Placeholder Name", 
"email" => "placeholder@placeholder.com", 
"password" => "placeholderpassword"}

And our complete `add_table` method looks like this:

```ruby
DATABASE.add_table("users", {"name" => "Placeholder Name", "email" => "placeholder@placeholder.com", "password" => "placeholderpassword"})
```

When our app runs for the first time it will create a "users" table with a row for "Bob". **Note: Creating a placeholder hash with the actual attributes that you want to save (for example: name, email, password) will make your life MUCH easier.**

+ This rest of these steps will need to be highly customized by you, based on the needs of your app. 

+ We're going to stick with the example of users and next we'll walk through how to add data to a database. __These instructions assume that you already have a form properly set up in your application.__

**Step 8: Adding Data to You Database**

There is an example app in the `demo` folder of this repo and in that app you'll see a standard sign up form in `index.erb`. It is set up to send data to a `post '/signup'` route. Within that route we're calling this method to add data from our form to the database:

```ruby
DATABASE.add("users", {"name" => params[:name], "email" => params[:email], "password" => params[:password]})
```

You'll notice that this looks very similar to the code we used to set up our "users" table - this is intentional. Firebase always requires two pieces of information - the table name and a hash of the information that you want to save to the database. This hash is telling Firebase - please save these values from the form (params hash) labeled with these keys.

Test this out in your own app. If it works properly you should begin to see the data in your Firebase dashboard.

**Step 9: Accessing the Data**

We've also created a `get_data` method in firebase.rb that will return an array of all the entries in the database when you call it like this:

```ruby
DATABASE.get_data
```

+ This method returns a nested array with the unique id and hash of values for each entry that looks like this:

```ruby
[["-Jc6Q68JAsAR17Uqs6Gz", {"email"=>"bob@bob.com", "name"=>"Bob", "password"=>"passwordforbob"}], ["-Jc6Q9tTwpW8f4dVOot-", {"email"=>"joe@joe.com", "name"=>"Joe", "password"=>"password"}], ["-Jc6jZ6jB7GpcGD9WV5e", {"email"=>"bobert@bobert.com", "name"=>"Bob", "password"=>"password"}]]
```

Take a look at the `index.erb` template for an example of how to iterate through an array like this and pull out information for a user.

We've also created a `search_by_attribute` method that can be used to search for specific entries in your database. This is a very basic search method. If you are looking for someone named Bob and there are multiple Bobs in your database it will just return the last one it finds. You'll have better success if you base your search on information that is more likely to be unique to each entry - like an email address. 

**Step 10:** Try running your application and take a look at your Firebase dashboard to see a graphical representation of your data.

### Happy coding!



