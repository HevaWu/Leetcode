/*
Implement the RandomizedSet class:

RandomizedSet() Initializes the RandomizedSet object.
bool insert(int val) Inserts an item val into the set if not present. Returns true if the item was not present, false otherwise.
bool remove(int val) Removes an item val from the set if present. Returns true if the item was present, false otherwise.
int getRandom() Returns a random element from the current set of elements (it's guaranteed that at least one element exists when this method is called). Each element must have the same probability of being returned.
You must implement the functions of the class such that each function works in average O(1) time complexity.



Example 1:

Input
["RandomizedSet", "insert", "remove", "insert", "getRandom", "remove", "insert", "getRandom"]
[[], [1], [2], [2], [], [1], [2], []]
Output
[null, true, false, true, 2, true, false, 2]

Explanation
RandomizedSet randomizedSet = new RandomizedSet();
randomizedSet.insert(1); Inserts 1 to the set. Returns true as 1 was inserted successfully.
randomizedSet.remove(2); Returns false as 2 does not exist in the set.
randomizedSet.insert(2); Inserts 2 to the set, returns true. Set now contains [1,2].
randomizedSet.getRandom(); getRandom() should return either 1 or 2 randomly.
randomizedSet.remove(1); Removes 1 from the set, returns true. Set now contains [2].
randomizedSet.insert(2); 2 was already in the set, so return false.
randomizedSet.getRandom(); Since 2 is the only number in the set, getRandom() will always return 2.


Constraints:

-231 <= val <= 231 - 1
At most 2 * 105 calls will be made to insert, remove, and getRandom.
There will be at least one element in the data structure when getRandom is called.
*/

Solution 1: default set

Time complexity: O(1) for each operation
Space complexity: O(n) where n is size of the input
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

/*
Solution 2: hashmap & arr

Insert
Add value -> its index into dictionary, average O(1) time.
Append value to array list, average O(1) time as well.

Delete
Retrieve an index of element to delete from the hashmap.
Move the last element to the place of the element to delete, O(1) time.
Pop the last element out, O(1) time.

GetRandom
GetRandom could be implemented in O(1) time with the help of standard random.choice in Python and Random object in Java.

Time complexity. GetRandom is always O(1). Insert and Delete both have O(1) average time complexity, and \mathcal{O}(N)O(N) in the worst-case scenario when the operation exceeds the capacity of currently allocated array/hashmap and invokes space reallocation.
Space complexity: O(N), to store N elements.
*/
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
