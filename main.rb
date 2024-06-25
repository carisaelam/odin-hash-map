require_relative 'linked_list'

class HashMap
  def initialize
    @size = 16
    @buckets = Array.new(@size) { [] }
    @count = 0
    @load_factor = 0.8
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def grow_buckets(old_buckets)
    new_size = @size * 2
    new_buckets = Array.new(new_size) { [] }

    old_buckets.each do |bucket|
      bucket.each do |key, value|
        index = hash(key) % new_size
        new_buckets[index] << [key, value]
      end
    end

    @bucket = new_buckets
    @size = new_size
  end

  def set(key, value)
    if length > @size * @load_factor
      puts 'too big...need to expand'
      grow_buckets(@buckets)
    else
      index = hash(key) % @size
      if !@buckets[index].empty?
        @buckets[index] = LinkedList.new.prepend(key, value).value
      else
        @buckets[index].push(key, value)
      end
    end
  end

  def get(key)
    @buckets.each do |bucket|
      return bucket[1] if bucket[0] == key
    end
    nil
  end

  def has?(key)
    does_it = false
    @buckets.each do |bucket|
      if bucket.include?(key)
        does_it = true
        return does_it
      end
    end
    does_it
  end

  def remove(key)
    if !has?(key)
      nil
    else

      @buckets.filter { |bucket| bucket[0] != (key) }
    end
  end

  def length
    length = 0
    @buckets.each do |bucket|
      next if bucket.empty?

      length += 1
    end
    length
  end

  def clear
    @buckets.map do |bucket|
      bucket.clear
    end
    @buckets
  end

  def keys
    keys_array = []
    @buckets.each do |bucket|
      next if bucket.empty?

      keys_array << bucket[0]
    end
    keys_array
  end

  def values
    values_array = []
    @buckets.each do |bucket|
      next if bucket.empty?

      values_array << bucket[1]
    end
    values_array
  end

  def entries
    entries_array = []
    @buckets.each do |bucket|
      next if bucket.empty?

      entries_array << [bucket[0], bucket[1]]
    end
    entries_array
  end
end

# raise an error if we try to access out of bound index
# raise IndexError if index.negative? || index >= @buckets.length

example = HashMap.new
pp example.set('key1', 'value1')
pp example.set('key2', 'value2')
pp example.set('key2', 'valueXX')
pp example.set('key3', 'value3')
pp example.set('key4', 'value4')
pp example.set('key5', 'value5')
pp example.set('key6', 'value6')
pp example.set('key7', 'value7')
pp example.set('key8', 'value8')
pp example.set('key9', 'value9')
pp example.set('key10', 'value10')
pp example.set('key11', 'value11')
pp example.set('key12', 'value12')
pp example.set('key13', 'value13')
pp example.set('key14', 'value14')
# pp example.set('key15', 'value15')
# pp example.set('key16', 'value16')
# p LinkedList.new
