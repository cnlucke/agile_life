arr = [2,6,0,4,7,3,9]
target = 10

## n * n Big O
def has_target_sum(arr,target)
  results = []

  arr.each do |a|
    arr.each do |b|
      if a + b == target
        results << [a,b]
      end
    end
  end
  results
end


#refactor still n*n

def has_target_sum2(arr, target)
  results = []
  nums_i_have_already_seen = []

  arr.each do |current_num|
    num_i_want = target - current_num

    if nums_i_have_already_seen.include?(num_i_want)
      results << [current_num, num_i_want]
    end

    nums_i_have_already_seen << current_num
end

#refactor using hashes: n Big O
def has_target_sum3(arr, target)
  results = []
  nums_i_have_already_seen = {}

  arr.each do |current_num|
    num_i_want = target - current_num

    if nums_i_have_already_seen[num_i_want]
      results << [current_num, num_i_want]
    end

    nums_i_have_already_seen[current_num] = true
end
