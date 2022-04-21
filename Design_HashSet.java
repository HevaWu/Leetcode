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
    List<Integer> arr;

    public MyHashSet() {
        arr = new ArrayList<>();
    }

    public void add(int key) {
        int index = searchKey(key);
        if (index >= 0) {
            if (arr.get(index) == key) {
                return;
            } else {
                arr.add(arr.get(index) < key ? index+1 : index, key);
            }
        } else {
            arr.add(key);
        }
    }

    public void remove(int key) {
        int index = searchKey(key);
        if (index >= 0 && arr.get(index) == key) {
            arr.remove(index);
        }
    }

    public boolean contains(int key) {
        int index = searchKey(key);
        if (index >= 0) {
            return arr.get(index) == key;
        } else {
            return false;
        }
    }

    public int searchKey(int key) {
        if (arr.size() == 0) {
            return -1;
        }

        int low = 0;
        int high = arr.size()-1;

        while (low < high) {
            int mid = low + (high - low) / 2;
            if (arr.get(mid) == key) {
                return mid;
            } else if (arr.get(mid) < key) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }
}

/**
 * Your MyHashSet object will be instantiated and called as such:
 * MyHashSet obj = new MyHashSet();
 * obj.add(key);
 * obj.remove(key);
 * boolean param_3 = obj.contains(key);
 */