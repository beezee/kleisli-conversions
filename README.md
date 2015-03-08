# Kleisli::Conversions

Adds conversion and lift methods for monads provided by the
[Kleisli](https://github.com/txus/kleisli) and
[Kleisli Validation](https://github.com/beezee/kleisli-validation) gems.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kleisli-conversions'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kleisli-conversions

## Usage

###Conversions

The following conversions are provided by requiring kleisli/conversions:

####Maybe#to_success(msg)

Converts Some(value) to Success(value), and None to Failure(msg)

####Either#to_validation

Converts Right(value) to Success(value), and Left(value) to Failure(value)

####Try#to_validation

Converts Try::Success(value) to Success(value),
and Try::Failure(value) to Failure(value)

####Validation#fail_hash(key)

Converts Failure(value) to Failure(key => value) and noop on Success.
Useful for accumulating failures with applicative syntax

####Validation#fail_array

Converts Failure(value) to Failure([value]) and noop on Success
Useful for accumulating failures with applicative syntax

###Lift methods

The following lift methods are added to any class by calling the following

```ruby
Kleisli::Conversions::Lift.enrich(MyClass)
# Kleisli::Conversions::Lift.enrich(Object) to add to everything
```

####\#maybe

Converts nil to None and non-nil value to Some(value)

####\#some

Converts any value to Some(value)

####\#none

Converts any value to None

####\#success

Converts any value to Success(value)

####\#failure

Converts any value to Failure(value)

####\#right

Converts any value to Right(value)

####\#left

Converts any value to Left(value)

## Contributing

1. Fork it ( https://github.com/[my-github-username]/kleisli-conversions/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
