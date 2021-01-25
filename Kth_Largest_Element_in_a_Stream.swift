/*
Design a class to find the kth largest element in a stream. Note that it is the kth largest element in the sorted order, not the kth distinct element.

Implement KthLargest class:

KthLargest(int k, int[] nums) Initializes the object with the integer k and the stream of integers nums.
int add(int val) Returns the element representing the kth largest element in the stream.
 

Example 1:

Input
["KthLargest", "add", "add", "add", "add", "add"]
[[3, [4, 5, 8, 2]], [3], [5], [10], [9], [4]]
Output
[null, 4, 5, 5, 8, 8]

Explanation
KthLargest kthLargest = new KthLargest(3, [4, 5, 8, 2]);
kthLargest.add(3);   // return 4
kthLargest.add(5);   // return 5
kthLargest.add(10);  // return 5
kthLargest.add(9);   // return 8
kthLargest.add(4);   // return 8
 

Constraints:

1 <= k <= 104
0 <= nums.length <= 104
-104 <= nums[i] <= 104
-104 <= val <= 104
At most 104 calls will be made to add.
It is guaranteed that there will be at least k elements in the array when you search for the kth element.
*/

/*
Solution 1:
BST search k-th largest element in stream

build BST, and store count of current node
- count: it self count + leftChild count + rightChild Count

- add: search and insert node, and update related count
- findK: search and compare nodeCount, leftCount, rightCount
  - if nodeCount-leftCount >= k, rightCount < k => return node
  - if rightCount >= k => return _findKLargest(node.right, k)
  - else => eturn _findKLargest(node.left, k-(nodeCount-leftCount))                

Time Complexity: 
 - add O(logn)
 - findK: O(logn)
Space Complexity: O(n)
*/
class KthLargest {
    let bst: BST = BST()
    let k: Int
    
    init(_ k: Int, _ nums: [Int]) {
        self.k = k
        for n in nums {
            bst.insert(n)
        }
    }
    
    func add(_ val: Int) -> Int {
        bst.insert(val)
        return bst.findKLargest(k) ?? -1
    }
}

class TreeNode {
    var val: Int
    
    // sub nodes count
    var count: Int = 1
    
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: Int) {
        self.val = val
    }
}

class BST {
    var root: TreeNode?
    
    func insert(_ num: Int) {
        root = _insert(root, num)
        // print(num, root?.count)
    }
    
    func _insert(_ node: TreeNode?, _ num: Int) -> TreeNode? {
        guard let node = node else { return TreeNode(num) }
        if node.val < num {
            node.right = _insert(node.right, num)
        } else if node.val > num {
            node.left = _insert(node.left, num)
        }
        node.count += 1
        return node
    }
    
    func findKLargest(_ k: Int) -> Int? {
        return _findKLargest(root, k)?.val
    }
    
    func _findKLargest(_ node: TreeNode?, _ k: Int) -> TreeNode? {
        guard let node = node else { return nil }

        let nodeCount = node.count
        let rightCount = node.right?.count ?? 0
        let leftCount = node.left?.count ?? 0
        
        if nodeCount-leftCount >= k, rightCount < k {
            return node
        }
        
        if rightCount >= k {
            return _findKLargest(node.right, k)
        } else {
            return _findKLargest(node.left, k-(nodeCount-leftCount))                
        }
    }
}

/**
 * Your KthLargest object will be instantiated and called as such:
 * let obj = KthLargest(k, nums)
 * let ret_1: Int = obj.add(val)
 */






/*
Solution 3:
inspire by Solution 2's heap implementation
optimize solution 1

let BST only at most keep k elements
each time of add, 
- if added num larger than heap's smallest one, remove minValue, insert num
*/
class KthLargest {
    let bst: BST = BST()
    let k: Int
    
    init(_ k: Int, _ nums: [Int]) {
        self.k = k
        for n in nums {
            add(n)
        }
    }
    
    func add(_ val: Int) -> Int {
        let minNode = bst.findMin()
                
        if bst.count < k {
            bst.insert(val)
        } else if (minNode?.val ?? 0) < val {
            bst.delete(minNode!.val)
            bst.insert(val)
        }
        return bst.findMin()?.val ?? -1
    }
}

class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: Int) {
        self.val = val
    }
}

class BST {
    var root: TreeNode?
    var count: Int = 0
    
    func insert(_ num: Int) {
        root = _insert(root, num)
        count += 1
    }
    
    func _insert(_ node: TreeNode?, _ num: Int) -> TreeNode? {
        guard let node = node else { return TreeNode(num) }
        if node.val < num {
            node.right = _insert(node.right, num)
        } else if node.val >= num {
            node.left = _insert(node.left, num)
        }
        return node
    }
    
    func findMin() -> TreeNode? {
        guard let node = root else { return nil }
        return _findMin(node)
    }
    
    func _findMin(_ node: TreeNode) -> TreeNode {
        var node = node
        while node.left != nil {
            node = node.left!
        }
        return node
    }
    
    func delete(_ key: Int) {
        root = _deleteNode(root, key)
        count -= 1
    }
    
    func _deleteNode(_ node: TreeNode?, _ key: Int) -> TreeNode? {
        guard let node = node else { return nil }
        if node.val < key {
            node.right = _deleteNode(node.right, key)
        } else if node.val > key {
            node.left = _deleteNode(node.left, key)
        } else {
            if node.left == nil, node.right == nil { return nil }
            if node.left == nil { return node.right }
            if node.right == nil { return node.left }
            
            let minNode = _findMin(node.right!)
            node.val = minNode.val
            node.right = _deleteNode(node.right, minNode.val)
        }
        return node
    }
}

/**
 * Your KthLargest object will be instantiated and called as such:
 * let obj = KthLargest(k, nums)
 * let ret_1: Int = obj.add(val)
 */



/*
Solution 2:
heap
*/
 class KthLargest {

    var heap: Heap<Int>
    var k = 0
    init(_ k: Int, _ nums: [Int]) {
        self.k = k
        self.heap = Heap<Int>(sort: <)
        
        for num in nums {
            add(num)
        }
    }
    
    func add(_ val: Int) -> Int {
        if heap.count < k {
            heap.insert(val)
        }
        else if heap.peek()! < val {
            heap.remove()
            heap.insert(val)
        }
        
        return heap.peek()!
    }
}

/**
 * Your KthLargest object will be instantiated and called as such:
 * let obj = KthLargest(k, nums)
 * let ret_1: Int = obj.add(val)
 */


//
//  Heap.swift
//  Written for the Swift Algorithm Club by Kevin Randrup and Matthijs Hollemans
//

public struct Heap<T> {
  
  /** The array that stores the heap's nodes. */
  var nodes = [T]()
  
  /**
   * Determines how to compare two nodes in the heap.
   * Use '>' for a max-heap or '<' for a min-heap,
   * or provide a comparing method if the heap is made
   * of custom elements, for example tuples.
   */
  private var orderCriteria: (T, T) -> Bool
  
  /**
   * Creates an empty heap.
   * The sort function determines whether this is a min-heap or max-heap.
   * For comparable data types, > makes a max-heap, < makes a min-heap.
   */
  public init(sort: @escaping (T, T) -> Bool) {
    self.orderCriteria = sort
  }
  
  /**
   * Creates a heap from an array. The order of the array does not matter;
   * the elements are inserted into the heap in the order determined by the
   * sort function. For comparable data types, '>' makes a max-heap,
   * '<' makes a min-heap.
   */
  public init(array: [T], sort: @escaping (T, T) -> Bool) {
    self.orderCriteria = sort
    configureHeap(from: array)
  }
  
  /**
   * Configures the max-heap or min-heap from an array, in a bottom-up manner.
   * Performance: This runs pretty much in O(n).
   */
  private mutating func configureHeap(from array: [T]) {
    nodes = array
    for i in stride(from: (nodes.count/2-1), through: 0, by: -1) {
      shiftDown(i)
    }
  }
  
  public var isEmpty: Bool {
    return nodes.isEmpty
  }
  
  public var count: Int {
    return nodes.count
  }
  
  /**
   * Returns the index of the parent of the element at index i.
   * The element at index 0 is the root of the tree and has no parent.
   */
  @inline(__always) internal func parentIndex(ofIndex i: Int) -> Int {
    return (i - 1) / 2
  }
  
  /**
   * Returns the index of the left child of the element at index i.
   * Note that this index can be greater than the heap size, in which case
   * there is no left child.
   */
  @inline(__always) internal func leftChildIndex(ofIndex i: Int) -> Int {
    return 2*i + 1
  }
  
  /**
   * Returns the index of the right child of the element at index i.
   * Note that this index can be greater than the heap size, in which case
   * there is no right child.
   */
  @inline(__always) internal func rightChildIndex(ofIndex i: Int) -> Int {
    return 2*i + 2
  }
  
  /**
   * Returns the maximum value in the heap (for a max-heap) or the minimum
   * value (for a min-heap).
   */
  public func peek() -> T? {
    return nodes.first
  }
  
  /**
   * Adds a new value to the heap. This reorders the heap so that the max-heap
   * or min-heap property still holds. Performance: O(log n).
   */
  public mutating func insert(_ value: T) {
    nodes.append(value)
    shiftUp(nodes.count - 1)
  }
  
  /**
   * Adds a sequence of values to the heap. This reorders the heap so that
   * the max-heap or min-heap property still holds. Performance: O(log n).
   */
  public mutating func insert<S: Sequence>(_ sequence: S) where S.Iterator.Element == T {
    for value in sequence {
      insert(value)
    }
  }
  
  /**
   * Allows you to change an element. This reorders the heap so that
   * the max-heap or min-heap property still holds.
   */
  public mutating func replace(index i: Int, value: T) {
    guard i < nodes.count else { return }
    
    remove(at: i)
    insert(value)
  }
  
  /**
   * Removes the root node from the heap. For a max-heap, this is the maximum
   * value; for a min-heap it is the minimum value. Performance: O(log n).
   */
  @discardableResult public mutating func remove() -> T? {
    guard !nodes.isEmpty else { return nil }
    
    if nodes.count == 1 {
      return nodes.removeLast()
    } else {
      // Use the last node to replace the first one, then fix the heap by
      // shifting this new first node into its proper position.
      let value = nodes[0]
      nodes[0] = nodes.removeLast()
      shiftDown(0)
      return value
    }
  }
  
  /**
   * Removes an arbitrary node from the heap. Performance: O(log n).
   * Note that you need to know the node's index.
   */
  @discardableResult public mutating func remove(at index: Int) -> T? {
    guard index < nodes.count else { return nil }
    
    let size = nodes.count - 1
    if index != size {
      nodes.swapAt(index, size)
      shiftDown(from: index, until: size)
      shiftUp(index)
    }
    return nodes.removeLast()
  }
  
  /**
   * Takes a child node and looks at its parents; if a parent is not larger
   * (max-heap) or not smaller (min-heap) than the child, we exchange them.
   */
  internal mutating func shiftUp(_ index: Int) {
    var childIndex = index
    let child = nodes[childIndex]
    var parentIndex = self.parentIndex(ofIndex: childIndex)
    
    while childIndex > 0 && orderCriteria(child, nodes[parentIndex]) {
      nodes[childIndex] = nodes[parentIndex]
      childIndex = parentIndex
      parentIndex = self.parentIndex(ofIndex: childIndex)
    }
    
    nodes[childIndex] = child
  }
  
  /**
   * Looks at a parent node and makes sure it is still larger (max-heap) or
   * smaller (min-heap) than its childeren.
   */
  internal mutating func shiftDown(from index: Int, until endIndex: Int) {
    let leftChildIndex = self.leftChildIndex(ofIndex: index)
    let rightChildIndex = leftChildIndex + 1
    
    // Figure out which comes first if we order them by the sort function:
    // the parent, the left child, or the right child. If the parent comes
    // first, we're done. If not, that element is out-of-place and we make
    // it "float down" the tree until the heap property is restored.
    var first = index
    if leftChildIndex < endIndex && orderCriteria(nodes[leftChildIndex], nodes[first]) {
      first = leftChildIndex
    }
    if rightChildIndex < endIndex && orderCriteria(nodes[rightChildIndex], nodes[first]) {
      first = rightChildIndex
    }
    if first == index { return }
    
    nodes.swapAt(index, first)
    shiftDown(from: first, until: endIndex)
  }
  
  internal mutating func shiftDown(_ index: Int) {
    shiftDown(from: index, until: nodes.count)
  }
  
}

// MARK: - Searching

extension Heap where T: Equatable {
  
  /** Get the index of a node in the heap. Performance: O(n). */
  public func index(of node: T) -> Int? {
    return nodes.firstIndex(where: { $0 == node })
  }
  
  /** Removes the first occurrence of a node from the heap. Performance: O(n). */
  @discardableResult public mutating func remove(node: T) -> T? {
    if let index = index(of: node) {
      return remove(at: index)
    }
    return nil
  }
  
}