def range(start_num,end_num)
    return [] if end_num <= start_num
    return [start_num] if end_num-1 == start_num
    range(start_num, end_num-1).concat([end_num-1])
end

def exp(base,power)
    return 1 if power == 0
    return base if power == 1
    half = exp(base, power/2)
    if power.even?
        half * half
    else
        base * half * half 
    end
end

class Array
    def deep_dup
        return self if self.none?{ |el| el.is_a?(Array)}
        self.map { |el| el.deep_dup }
    end

    def bsearch(target)
        return nil if !self.include?(target)

        mid = self.length/2
        left = self[0...mid]
        right = self[mid..-1]
        
        if self[mid] == target
            mid
        elsif target < self[mid]
            left.bsearch(target)
        else
            mid + right.bsearch(target) 
        end
    end

    def merge_sort
        return self if self.length <= 1
        mid = self.length/2
        pivot = self[mid]
        left = []
        right = []
        self.each_with_index do |el,i|
            if i != mid
                if el < pivot
                    left << el
                else
                    right << el
                end
            end
        end
        left.merge_sort + [pivot] + right.merge_sort
    end

    def subsets
        return [self] if self.empty?

        new_subs = self[0...-1].subsets.map { |sub| sub << self.last }
        self[0...-1].subsets.concat( new_subs )
    end

    def permutations
        return [self] if self.length <=1
        final_perm = []
        self.each_with_index do |el, i|
            arr = self.deep_dup
            (arr[0...i] + arr[i+1..-1]).permutations.each do |perm|
                perm.unshift(el)
                final_perm << perm
            end
        end
        final_perm
    end
end

if $PROGRAM_NAME==__FILE__
    p range(1,1) #=>[]
    p range(5,-1) #=>[]
    p range(1,5) #=>[1,2,3,4]
    p exp(2,4) #=>16
    p exp(1,0) #=>1
    p exp(-7,0) #=>1
    words = [["nuts", "bolts", "washers"],["capacitors", "resistors", "inductors"]]
    p words.deep_dup
    nums_1 = [1,2,3]
    p nums_1.bsearch(1) #=> 0
    nums_2 = [2,3,4,5]
    p nums_2.bsearch(3) #=> 1
    nums_3 = [2,4,6,8,10]
    p nums_3.bsearch(6) #=> 2
    nums_4 = [1,3,4,5,9]
    p nums_4.bsearch(5) #=> 3
    nums_5 = [1,2,3,4,5,6]
    p nums_5.bsearch(6) #=> 5
    p nums_5.bsearch(0) #=> nil
    nums_6 = [1,2,3,4,5,6]
    p nums_6.bsearch(7) #=> nil
    unsorted_nums_1 = [3,5,4,9,1]
    p unsorted_nums_1.merge_sort #=> [1,3,4,5,9]
    unsorted_nums_2 = [4,2,6,3,5,1]
    p unsorted_nums_2.merge_sort #=> [1,2,3,4,5,6]
    set_1 = []
    p set_1.subsets #=> [[]]
    set_2 = [1]
    p set_2.subsets #=> [[],[1]]
    set_3 = [1,2]
    p set_3.subsets #=> [[],[1],[2],[1,2]]
    set_4 = [1,2,3]
    p set_4.subsets #=> [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3]]
    arr_1 = []
    p arr_1.permutation.to_a
    p arr_1.permutations
    puts "----------------------------------------------------"
    arr_2 = [1]
    p arr_2.permutation.to_a
    p arr_2.permutations
    puts "----------------------------------------------------"
    arr_3 = [1,2]
    p arr_3.permutation.to_a
    p arr_3.permutations
    puts "----------------------------------------------------"
    arr_4 = [1,2,3]
    p arr_4.permutation.to_a
    p arr_4.permutations
    puts "----------------------------------------------------"
    arr_5 = [1,2,3,4]
    p arr_5.permutation.to_a
    p arr_5.permutations
end