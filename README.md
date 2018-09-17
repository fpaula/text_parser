# TextParser

Using method parse in the String object you can parse any text.

![Text Parser Build status](https://secure.travis-ci.org/fpaula/text_parser.png)

## Installation


Add this line to your application's Gemfile:

    gem 'text_parser'

And then run:

    `bundle install`

Or install it yourself as:

    `gem install text_parser`

## Usage
```ruby
    "Simple, simple test".parse
    # => [{:word => "simple", :hits => 2}, {:word => "test", :hits => 1}]
```
```ruby
    my_text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque pretium consectetur."
    my_text.parse(:dictionary => ["dolor", "consectetur"])
    # => [{:word => "consectetur", :hits => 2}, {:word => "dolor", :hits => 1}]
```
```ruby
    my_text.parse(:dictionary => ["dolor", "consectetur"], :order => :word, :order_direction => :desc)
    # => [{:word => "dolor", :hits => 1}, {:word => "consectetur", :hits => 2}]
```
```ruby
    "Lorem ipsum dolor sit amet".parse(:negative_dictionary => ["ipsum", "dolor", "sit"])
    # => [{:word => "loren", :hits => 1}, {:word => "amet", :hits => 1}]
```
```ruby
    "My test!".parse(:minimum_length => 3)
    # => [{:word => "test", :hits => 1}]
```

### Arguments (hash)
| Key                             | Type   | Default value |
| ------------------------------- | ------ | ------------- |
| :dictionary                     | Array  | nil           |
| :order (:word, :hits)           | Symbol | :word         |
| :order_direction (:asc, :desc)  | Symbol | :asc          |
| :negative_dictionary            | Array  | nil           |
| :minimum_length                 | int    | nil           |


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Run the tests
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
