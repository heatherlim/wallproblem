class Wall

  def initialize
    @length_of_row = 48
    @number_of_row = 10
    @large_brick = 4.5
    @small_brick = 3
  end

  def combo_constructor
    brick_number_combo = []
    combo_array = []
    # The number of 4.5 bricks has to be an even number
    [2,4,6,8,10].each do |even|
      brick_number_combo << number_of_each_type_of_brick(even)
      # Removes empty arrays from the array of arrays
      brick_number_combo.reject!(&:empty?)
    end
      # Now we will find the number of combinations from each array
      # brickNumber is an array: [# of large bricks, # of small bricks]
      brick_number_combo.each do |brickNumber|
        combo_array << permutation(brickNumber)
      end
      # It returns plus one because my method did not take into account a combination that did NOT include large bricks
    return combo_array.inject(:+) + 1
  end

  def number_of_each_type_of_brick(x)
    # brick_sum would be an array
    # example: [# of large bricks, # of small bricks]
    brick_sum = []
    total_smallbrick_length = @length_of_row - @large_brick*x
      if total_smallbrick_length%3 == 0 # If we can divide it evenly... it is a possible combination
        brick_sum << x
        brick_sum << total_smallbrick_length/@small_brick
      end
    return brick_sum
  end

  def permutation(array)
    # A formula for finding permutations with REPEATED elements:
    # (total # of elements)!/(total # of one element TYPE)!(total # of other element TYPE)!
    # Different from just permutations... A 4.5 block is the same as every other 4.5 block so order of blocks of the same length does not matter
    # Only the order of different blocks matters
    total_elements = array.inject(:+)
    total_large_bricks = array[0]
    total_small_bricks = array[1]

    total_elements_factorial = factorial(total_elements)
    total_large_bricks_factorial = factorial(total_large_bricks)
    total_small_bricks_factorial = factorial(total_small_bricks)

    total_elements_factorial/(total_large_bricks_factorial*total_small_bricks_factorial)
  end

  def combination_total
    first_row = combo_constructor
    # It subtracts one for the next row because it assumes it cannot use the previously used row combination
    # If the first row was made of all small bricks, the second row cannot be all small bricks but the third row can be
    alternate_row = combo_constructor - 1
    array = []
    counter = 0
    final_count = first_row*alternate_row
      while counter < @number_of_row/2
        array << first_row
        array << alternate_row
        counter += 1
      end
      return array.inject(:*)
  end

  def factorial(n)
    (1..n).inject {|product, n| product * n }
  end

end

x = Wall.new
puts x.combination_total