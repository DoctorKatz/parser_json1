class Node
  attr_accessor :value, :next_node

  def initialize(value, next_node)
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  def initialize(value)
    @head = Node.new(value, nil)
  end

  def addition(value)
    current_node = @head
    while current_node.next_node != nil
      current_node = current_node.next_node
    end
    current_node.next_node = Node.new(value, nil)
  end

  def find(value)
    current_node = @head
    puts current_node.value
    return false if !current_node.next_node
    return current_node if current_node.value == value
    while (current_node = current_node.next_node)
      return current_node if current_node.value == value
    end
  end

=begin
  def find?(value)

  end
=end

  def length
    current_node = @head
    count = 0
    while (current_node = current_node.next_node)
      count += 1
    end
    return (count + 1)
  end

  def print_list
    current_node = @head
    puts current_node.value
    while (current_node = current_node.next_node)
      puts current_node.value
    end
  end
end

class Tree
  attr_accessor :left
  attr_accessor :right
  attr_accessor :data

  def initialize(str = nil)
    @left = nil
    @right = nil
    @data = str
  end

  def insert(str, type)
    list = []
    if @data == nil && type == "EmisID"
      @data = str
    elsif @left == nil && type == "ImpotInfo"
      @left = Tree.new
    elsif @right == nil
      @right = Tree.new
    else
      list << @left
      list << right
      loop do
        node = list.shift
        if node.left == nil
          node.insert(str)
          break
        else
          list << node.left
        end
        if node.right == nil
          node.insert(str)
          break
        else
          list << node.right
        end
      end
    end
  end

  def traverse
    list = []
    yield @data
    list << @left if left != nil
    list << @right if right != nil
    loop do
      break if list.empty?
      node = list.shift
      yield node.data
      list << node.left if node.left != nil
      list << node.right if node.right != nil
    end
  end
end