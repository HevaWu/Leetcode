// Design and implement a data structure for Least Recently Used (LRU) cache. It should support the following operations: get and put.

// get(key) - Get the value (will always be positive) of the key if the key exists in the cache, otherwise return -1.
// put(key, value) - Set or insert the value if the key is not already present. When the cache reached its capacity, it should invalidate the least recently used item before inserting a new item.

// The cache is initialized with a positive capacity.

// Follow up:
// Could you do both operations in O(1) time complexity?

// Example:

// LRUCache cache = new LRUCache( 2 /* capacity */ );

// cache.put(1, 1);
// cache.put(2, 2);
// cache.get(1);       // returns 1
// cache.put(3, 3);    // evicts key 2
// cache.get(2);       // returns -1 (not found)
// cache.put(4, 4);    // evicts key 1
// cache.get(1);       // returns -1 (not found)
// cache.get(3);       // returns 3
// cache.get(4);       // returns 4

// Solution 1: hashmap & double linked list
// The problem can be solved with a hashmap that keeps track of the keys and its values in the double linked list. That results in \mathcal{O}(1)O(1) time for put and get operations and allows to remove the first added node in \mathcal{O}(1)O(1) time as well.
// One advantage of double linked list is that the node can remove itself without other reference. In addition, it takes constant time to add and remove nodes from the head or tail.
// One particularity about the double linked list implemented here is that there are pseudo head and pseudo tail to mark the boundary, so that we don't need to check the null node during the update.
// 
// Time complexity : \mathcal{O}(1)O(1) both for put and get.
// Space complexity : \mathcal{O}(capacity)O(capacity) since the space is used only for a hashmap and double linked list with at most capacity + 1 elements.

class LRUCache {
    var head = DLNode(key: -1, value: -1)
    var trail = DLNode(key: -1, value: -1)
    var map = [Int: DLNode]()
    
    var capacity: Int

    init(_ capacity: Int) {
        self.capacity = capacity
        
        head.next = trail
        trail.pre = head
    }
    
    func get(_ key: Int) -> Int {
        if let node = map[key] {
            moveToHead(node)
            return node.value
        } else {
            return -1
        }
    }
    
    func put(_ key: Int, _ value: Int) {
        if let node = map[key] {
            // exist node, update order
            node.value = value
            moveToHead(node)
        } else {
            // new node
            let node = DLNode(key: key, value: value)
            addNode(node)
            map[key] = node
            
            if map.keys.count > capacity {
                // out of capacity
                let node = popTrail()
                map[node.key] = nil
            }
        }
    }
    
    // DL list node part
    
    func addNode(_ node: DLNode) {
        // always add node right after head
        node.next = head.next
        head.next!.pre = node
        
        head.next = node
        node.pre = head
    }
    
    func removeNode(_ node: DLNode) {
        let pre = node.pre!
        let next = node.next!
        
        pre.next = next
        next.pre = pre
    }
    
    func moveToHead(_ node: DLNode) {
        removeNode(node)
        addNode(node)
    }
    
    // pop least visited node
    func popTrail() -> DLNode {
        let node = trail.pre!
        removeNode(node)
        return node
    }
}

/**
 * Your LRUCache object will be instantiated and called as such:
 * let obj = LRUCache(capacity)
 * let ret_1: Int = obj.get(key)
 * obj.put(key, value)
 */

class DLNode {
    var key: Int = -1
    var value: Int = -1
    
    init(key: Int, value: Int) {
        self.key = key
        self.value = value
    }
    
    var pre: DLNode?
    var next: DLNode?
}
