/*
Design a HashSet without using any built-in hash table libraries.

Implement MyHashSet class:

void add(key) Inserts the value key into the HashSet.
bool contains(key) Returns whether the value key exists in the HashSet or not.
void remove(key) Removes the value key in the HashSet. If key does not exist in the HashSet, do nothing.
 

Example 1:

Input
["MyHashSet", "add", "add", "contains", "contains", "add", "contains", "remove", "contains"]
[[], [1], [2], [1], [3], [2], [2], [2], [2]]
Output
[null, null, null, true, false, null, true, null, false]

Explanation
MyHashSet myHashSet = new MyHashSet();
myHashSet.add(1);      // set = [1]
myHashSet.add(2);      // set = [1, 2]
myHashSet.contains(1); // return True
myHashSet.contains(3); // return False, (not found)
myHashSet.add(2);      // set = [1, 2]
myHashSet.contains(2); // return True
myHashSet.remove(2);   // set = [1]
myHashSet.contains(2); // return False, (already removed)
 

Constraints:

0 <= key <= 106
At most 104 calls will be made to add, remove, and contains.
 

Follow up: Could you solve the problem without using the built-in HashSet library?
*/

/*
Solution 1:
store element in an arr
binary search element

Time Complexity: O(logn)
Space Complexity: O(n) where n is all distinct element count
*/
class MyHashSet {
    var arr: [Int]

    /** Initialize your data structure here. */
    init() {
       arr = [Int]() 
    }
    
    func add(_ key: Int) {
        guard let index = search(key) else { 
            arr.append(key)
            return 
        }
        
        if arr[index] == key {
            return 
        } else if arr[index] < key {
            arr.insert(key, at: index+1)
        } else {
            arr.insert(key, at: index)
        }
    }
    
    func remove(_ key: Int) {
        guard let index = search(key) else { return }
        if arr[index] == key {
            arr.remove(at: index)
        }
    }
    
    /** Returns true if this set contains the specified element */
    func contains(_ key: Int) -> Bool {
        guard let index = search(key) else { return false }
        return arr[index] == key
    }
    
    func search(_ key: Int) -> Int? {
        if arr.isEmpty { 
            return nil
        }
        
        var left = 0
        var right = arr.count-1
        while left < right {
            let mid = left + (right-left)/2
            if arr[mid] < key {
                left = mid+1
            } else {
                right = mid
            }
        }
        
        return left
    }
}

/**
 * Your MyHashSet object will be instantiated and called as such:
 * let obj = MyHashSet()
 * obj.add(key)
 * obj.remove(key)
 * let ret_3: Bool = obj.contains(key)
 */

