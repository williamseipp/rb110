# introduction

    make a repo

# collection basics

    * understand how to reference individual elements of a collection
    * #slice(x,y) y is the string LENGTH, not the ending index!
    * to iterate through a hash, you need to iterate through an array
        of its keys
    * #fetch is used because a return value of nil is ambiguous: was
        the index out of bounds or is the element nil? This applies to
        both Arrays and Hashes
    * be aware of the conversion methods between different collections

# looping

    you should be proficient enough to loop through a collection using just
    #loop

# pedac

    see pedac.md
# practice looping

    [Loops 1](https://launchschool.com/exercise_sets/2ce91ec4)
    [Loops 2](https://launchschool.com/exercise_sets/7d22644c)

# selection and transformation

    * understand if method mutates original collection or returns new one
    * be aware of using parameters, and pay attention to what is returned

# each, map, select

    * each returns the original collection
    * select returns a new collection
    * map returns a new collection

    * select: return value of block determines inclusion in new collection
    * map: return value of block IS the new element of new collection
    
# more methods

    * any?
    * all?
    * each_with_index
    * each_with_object
    * first
    * include?
    * key?
    * value?

# summary

    * understand the difference between #each, #select, #map
    * understand how these interact with the block's return value
    * understand what each method returns
    * incorporate PEDAC into your problem-solving process
# lesson 1 quiz missed questions

    7.
    8.
    9.
    12.
    13.
    19.
    20.


# lesson 2 quiz missed questions

```ruby
arr = ['340', '15', '1', '3400']
arr.sort # => ['1', '15', '340', '3400']
```

    1. I said that the output was the result of calling #to_i on each String in
       the collection. This is false; even though the Strings appear to be
       sorted according to their numeric value, they are in fact sorted
       according to the ASCII values of each character. 


```ruby
fulfilled_orders = customer_orders.map do |customer|
  {
    customer_id: customer[:customer_id],
    customer_name: customer[:customer_name]
  }
end

customer_orders.each_with_index do |data, index|
  order_value = data[:orders].reduce(0) do |total, order|
    total + order[:order_value] if order[:order_fulfilled]
  end

  fulfilled_orders[index][:order_value] = order_value
end
```

    10. I thought the bug was line 89: 
    `fulfilled_orders[index][:order_value] = order_value` 
    because I thought that fulfilled_orders was a hash.

    What it actually was:
    `total + order[:order_value] if order[:order_fulfilled]`
    If the value is false, then order_value would be `nil`. If the value was
    then `true` after this, an exception would be raised. 

