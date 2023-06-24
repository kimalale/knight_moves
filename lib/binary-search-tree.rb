module Comparable;end


class Node
  attr_accessor :data, :left_node, :right_node

  def initialize(data = nil, left_node = nil, right_node = nil)
    @data = data
    @left_node = left_node
    @right_node = right_node
  end

  def value
    return @data
  end
end


class Tree
  attr_accessor :array, :root

  def initialize(array = [])
    @array = array.uniq.sort
    @root = self.build_tree(@array, 0, @array.length - 1)
  end

  # A function that constructs Balanced Binary Search Tree from a sorted array
  def build_tree(array, start, last)
    return if start > last

    mid = ((start + last) / 2).to_i

    root_node = Node.new(array[mid]) if array[mid].to_i != nil

    root_node.left_node = build_tree(array, start, mid - 1)
    root_node.right_node = build_tree(array, mid + 1, last)

    root_node
  end



  def insert(value, root_node = @root)
    # base case, when nil is encountered

    if root_node == nil
      return Node.new(value)
    else
        root_node.left_node = insert(value, root_node.left_node) if root_node.data > value
        root_node.right_node = insert(value, root_node.right_node) if root_node.data < value
    end
    @root = root_node
  end

  def inorder(root_node = @root)
    # base case, when nil is encountered
      # base case
    if root_node == nil
    inorder(root_node.left_node)
    puts "#{root_node.data}, "
    inorder(root_node.right_node)
    end
  end

  def succesory(root_node = @root)

    max_node = root_node

    until max_node.right_node == nil do
      max_node = max_node.right_node
    end
    max_node.data
  end

  def predecessory(root_node = @root)

    min_node = root_node

    until min_node.left_node == nil do
      min_node = min_node.left_node
    end
    min_node.data
  end


  def delete(value, root_node = @root)

    # no child nodes
    return nil if root_node.left_node.nil? && root_node.right_node.nil?

    #recurse into child nodes
    if root_node.data > value
      root_node.left_node = delete(value, root_node.left_node)
    elsif root_node.data < value
      root_node.right_node = delete(value, root_node.right_node)
    end

    # one child node case
    return root_node.right_node if root_node.left_node.nil? && root_node.right_node && root_node.data == value
    return root_node.left_node if root_node.right_node.nil? && root_node.left_node && root_node.data == value

  # 2 child nodes case
  # succesor or predecessor mechanisms

  # succesor .... use either successor or predecessor deletion nodes
    succesor_node = succesory(root_node.right_node) if root_node.right_node && root_node.left_node && root_node.data == value
    root_node.data = succesor_node if root_node.right_node && root_node.left_node && root_node.data == value
    root_node.right_node = delete(succesor_node, root_node.right_node) if root_node.right_node && root_node.left_node && root_node.data == succesor_node

  # predecessor .... use either successor or predecessor deletion nodes

    # predecessor_node = predecessory(root_node.left_node) if root_node.right_node && root_node.left_node && root_node.data == value
    # root_node.data = predecessor_node if root_node.right_node && root_node.left_node && root_node.data == value
    # root_node.left_node = delete(predecessor_node, root_node.left_node) if root_node.right_node && root_node.left_node && root_node.data == succepredecessor_nodesor_node
    root_node

  end

  #find node matching given predicate
  def  find(value)
    root_node = @root

    until root_node.data == value do
      root_node = root_node.right_node if root_node.data < value
      root_node = root_node.left_node if root_node.data > value
    end
    root_node
  end


  # Write a #level_order method which accepts a block. This method should traverse the tree
  # in breadth-first level order and yield each node to the provided block. This method can be
  # implemented using either iteration or recursion (try implementing both!). The method
  # should return an array of values if no block is given. Tip: You will want to use an array
  # acting as a queue to keep track of all the child nodes that you have yet to traverse
  # and to add new ones to the list (as you saw in the video).

  def level_order

    # Initialize empty array for the level_order values
    traversed_values = []

    # Intitiale queue to store traversed node's children
    queue = []
    queue << @root #FIOF - First one in, first one out

    # Traverse the tree, and gather the values until the queue is empty
    until queue.empty? do

      # Get the node data
      traversed_values << queue[0].data

      # enqueue child nodes
      queue << queue[0].left_node if !queue[0].left_node.nil?
      queue << queue[0].right_node if !queue[0].right_node.nil?

      # dequeue child node
      queue.shift
    end



    if !block_given? # Return the level_order arr values
      return traversed_values
    end

    filtered_level_order = [] # empty array block matched values

    # Get block matched values
    traversed_values.each do | value |
      filtered_level_order << value if yield value
    end

      filtered_level_order
  end

   #inorder, #preorder, and #postorder methods that accepts a block.

    #Traversing nodes in inorder order
  def inorder(root_node = @root, traversed_inorder = [])

    # return at end of child nodes
    return if root_node.nil?

    inorder(root_node.left_node, traversed_inorder)
    traversed_inorder << root_node.data
    inorder(root_node.right_node, traversed_inorder)

    # return default array if !block
    if !block_given?
      return traversed_inorder
    end

    selected_inorder = []
    traversed_inorder.each do | value |
       selected_inorder << value if yield value
    end

    selected_inorder
  end

   #Traversing nodes in preoder order
  def preorder(root_node = @root, traversed_preorder = [])

    # return at end of child nodes
    return if root_node.nil?

    traversed_preorder << root_node.data
    preorder(root_node.left_node, traversed_preorder)
    preorder(root_node.right_node, traversed_preorder)

    # return default array if !block
    if !block_given?
      return traversed_preorder
    end

    selected_preorder = []
    traversed_preorder.each do | value |
       selected_preorder << value if yield value
    end

    selected_preorder

  end

   #Traversing nodes in preoder order
  def postorder(root_node = @root, traversed_postorder = [])
    # return at end of child nodes
    return if root_node.nil?

    preorder(root_node.left_node, traversed_postorder)
    preorder(root_node.right_node, traversed_postorder)
    traversed_postorder << root_node.data

    # return default array if !block
    if !block_given?
      return traversed_postorder
    end

    selected_postorder = []
    traversed_postorder.each do | value |
       selected_postorder << value if yield value
    end

    selected_postorder

  end

  # height of edge nodes from given node
  def height(root_node = @root)

    return -1 if root_node.nil?

    left_node = height(root_node.left_node)
    right_node =height(root_node.right_node)

   [left_node, right_node].max + 1
  end

  # depth of egdes node from given node to root node
  def depth(search_node = @root_node, root_node = @root)

    root_node = height(root_node)
    searched_node = height(search_node)

    root_node - searched_node
  end

# Write a #balanced? method which checks if the tree is balanced.
# A balanced tree is one where the difference between heights of left
# subtree and right subtree of every node is not more than 1.
  def balanced

    left_subtree = height(@root.left_node)
    right_subtree = height(@root.right_node)

    return (left_subtree - right_subtree).abs <= 1
  end

# Write a #rebalance method which rebalances an unbalanced tree.
# Tip: You’ll want to use a traversal method to provide a new array to the
# #build_tree method.
  def rebalance

    return if self.balanced

    @root = build_tree(self.preorder, 0, self.preorder.length - 1)
    @root = build_tree(self.postorder, 0, self.postorder.length - 1) if !self.balanced
    @root = build_tree(self.inorder, 0, self.inorder.length - 1) if !self.balanced

  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
  end
end

