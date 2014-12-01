---
tags: ruby, sinatra, firebase, kids
languages: ruby
level: 3
---

## Firebase Tutorial

Follow along with these step by step instructions to set up a Firebase database for your app

**Step 1:** Add the 'firebase' gem to your Gemfile and then run `bundle install` from your terminal.

**Step 2:** Create a firebase.rb file in your models directory and add this sweet code that Joe Cutler wrote:

```ruby
class FlatironBase
  attr_accessor :base_uri, :data, :table

  def initialize(base_uri) 
    @firebase = Firebase::Client.new(base_uri)
    @table = @firebase.get("").body.keys[0] #defaults to first table in database
    puts "Database accessed. Defaulted to first table. (#{@table})"
  end

  def swap_table(table_name) #swaps between tables in the database
    @table = table_name
    puts "Active table is now #{@table}"
  end

  def add_table(table_name, hash = {"place" => "holder"}) # Creates a table and autoswaps to that table. Firebase doesn't allow for an empty object, so a placeholder hash is needed.
    if @firebase.get("").body.keys.include?(table_name)
      puts "This table already exists. Swapping tables..."
      swap_table(table_name)
    else
      new_table = @firebase.push(table_name, hash)
      swap_table(table_name)
      if new_table.success?
        puts "Table creation success."
      else
        puts "Something went wrong."
        false
      end
    end
  end

  def add(table, hash) #adds an entry to the database
    @firebase.push(table, hash)
  end

  def get_data #returns an array of all items in the table, defaults to current table in use
    @data = @firebase.get(@table).body
    @data.to_a
  end

  def print_data #does what it says on the tin
    puts @data.to_s
  end

  def search_by_attribute(attribute, search_value)
    @data = @firebase.get(@table).body
    id = 0
    @data.each do |key, value|
      if value[attribute] == search_value
        id = key
      end
    end
    path = "#{@table}/#{id}"
    @firebase.get(path).body
  end

  def remove_by_id(id) #removes an entry in the database by the id
    path = "#{@table}/#{id}"
    @firebase.delete(path)
    puts "Removed '#{path}'"
  end

  def remove_table(table_name = @table) #drop a table, defaults to current table
    @firebase.delete(table_name)
    puts "Table deleted."
  end
end
```

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



