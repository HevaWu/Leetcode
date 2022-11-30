'''
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
'''

'''
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
'''
class RandomizedSet:

    def __init__(self):
        self.mymap = {}
        self.arr = []

    def insert(self, val: int) -> bool:
        if val in self.mymap: return False
        self.arr.append(val)
        self.mymap[val] = len(self.arr)-1
        return True

    def remove(self, val: int) -> bool:
        if val not in self.mymap: return False
        # put last element into val element position
        lastEle = self.arr[-1]
        valIndex = self.mymap[val]
        self.mymap[lastEle] = valIndex
        self.arr[valIndex] = lastEle
        # remove last element
        self.arr.pop(-1)
        self.mymap.pop(val)
        return True

    def getRandom(self) -> int:
        return self.arr[randint(0, len(self.arr)-1)]


# Your RandomizedSet object will be instantiated and called as such:
# obj = RandomizedSet()
# param_1 = obj.insert(val)
# param_2 = obj.remove(val)
# param_3 = obj.getRandom()
