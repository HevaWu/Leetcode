// Design a data structure that supports all following operations in average O(1) time.

// insert(val): Inserts an item val to the set if not already present.
// remove(val): Removes an item val from the set if present.
// getRandom: Returns a random element from current set of elements. Each element must have the same probability of being returned.
// Example:

// // Init an empty set.
// RandomizedSet randomSet = new RandomizedSet();

// // Inserts 1 to the set. Returns true as 1 was inserted successfully.
// randomSet.insert(1);

// // Returns false as 2 does not exist in the set.
// randomSet.remove(2);

// // Inserts 2 to the set, returns true. Set now contains [1,2].
// randomSet.insert(2);

// // getRandom should return either 1 or 2 randomly.
// randomSet.getRandom();

// // Removes 1 from the set, returns true. Set now contains [2].
// randomSet.remove(1);

// // 2 was already in the set, so return false.
// randomSet.insert(2);

// // Since 2 is the only number in the set, getRandom always return 2.
// randomSet.getRandom();

// Solution 1: default set
// 
// Time complexity: O(1) for each operation
// Space complexity: O(n) where n is size of the input
class RandomizedSet {
    var set = Set<Int>()

    /** Initialize your data structure here. */
    init() {
        
    }
    
    /** Inserts a value to the set. Returns true if the set did not already contain the specified element. */
    func insert(_ val: Int) -> Bool {
        if set.contains(val) {
            return false
        } else {
            set.insert(val)
            return true
        }
    }
    
    /** Removes a value from the set. Returns true if the set contained the specified element. */
    func remove(_ val: Int) -> Bool {
        if set.contains(val) {
            set.remove(val)
            return true
        } else {
            return false
        }
    }
    
    /** Get a random element from the set. */
    func getRandom() -> Int {
        return set.randomElement()!
    }
}

/**
 * Your RandomizedSet object will be instantiated and called as such:
 * let obj = RandomizedSet()
 * let ret_1: Bool = obj.insert(val)
 * let ret_2: Bool = obj.remove(val)
 * let ret_3: Int = obj.getRandom()
 */

// Solution 2: hashmap & arr 
// 
// Insert
// Add value -> its index into dictionary, average \mathcal{O}(1)O(1) time.
// Append value to array list, average \mathcal{O}(1)O(1) time as well.
// 
// Delete
// Retrieve an index of element to delete from the hashmap.
// Move the last element to the place of the element to delete, \mathcal{O}(1)O(1) time.
// Pop the last element out, \mathcal{O}(1)O(1) time.
// 
// GetRandom
// GetRandom could be implemented in \mathcal{O}(1)O(1) time with the help of standard random.choice in Python and Random object in Java.
// 
// Time complexity. GetRandom is always \mathcal{O}(1)O(1). Insert and Delete both have \mathcal{O}(1)O(1) average time complexity, and \mathcal{O}(N)O(N) in the worst-case scenario when the operation exceeds the capacity of currently allocated array/hashmap and invokes space reallocation.
// Space complexity: \mathcal{O}(N)O(N), to store N elements.
class RandomizedSet {
    var arr = [Int]()
    var map = [Int: Int]()

    /** Initialize your data structure here. */
    init() {
        
    }
    
    /** Inserts a value to the set. Returns true if the set did not already contain the specified element. */
    func insert(_ val: Int) -> Bool {
        guard map[val] == nil else { return false }
        arr.append(val)
        map[val] = arr.count - 1
        return true
    }
    
    /** Removes a value from the set. Returns true if the set contained the specified element. */
    func remove(_ val: Int) -> Bool {
        guard let index = map[val], let last = arr.last else { return false }
        arr[index] = last
        arr.removeLast()
        map[last] = index
        map[val] = nil
        return true
    }
    
    /** Get a random element from the set. */
    func getRandom() -> Int {
        return arr.randomElement() ?? 0
    }
}

/**
 * Your RandomizedSet object will be instantiated and called as such:
 * let obj = RandomizedSet()
 * let ret_1: Bool = obj.insert(val)
 * let ret_2: Bool = obj.remove(val)
 * let ret_3: Int = obj.getRandom()
 */
