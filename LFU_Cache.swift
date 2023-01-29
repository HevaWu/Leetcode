/*
Design and implement a data structure for a Least Frequently Used (LFU) cache.

Implement the LFUCache class:

LFUCache(int capacity) Initializes the object with the capacity of the data structure.
int get(int key) Gets the value of the key if the key exists in the cache. Otherwise, returns -1.
void put(int key, int value) Update the value of the key if present, or inserts the key if not already present. When the cache reaches its capacity, it should invalidate and remove the least frequently used key before inserting a new item. For this problem, when there is a tie (i.e., two or more keys with the same frequency), the least recently used key would be invalidated.
To determine the least frequently used key, a use counter is maintained for each key in the cache. The key with the smallest use counter is the least frequently used key.

When a key is first inserted into the cache, its use counter is set to 1 (due to the put operation). The use counter for a key in the cache is incremented either a get or put operation is called on it.

The functions get and put must each run in O(1) average time complexity.



Example 1:

Input
["LFUCache", "put", "put", "get", "put", "get", "get", "put", "get", "get", "get"]
[[2], [1, 1], [2, 2], [1], [3, 3], [2], [3], [4, 4], [1], [3], [4]]
Output
[null, null, null, 1, null, -1, 3, null, -1, 3, 4]

Explanation
// cnt(x) = the use counter for key x
// cache=[] will show the last used order for tiebreakers (leftmost element is  most recent)
LFUCache lfu = new LFUCache(2);
lfu.put(1, 1);   // cache=[1,_], cnt(1)=1
lfu.put(2, 2);   // cache=[2,1], cnt(2)=1, cnt(1)=1
lfu.get(1);      // return 1
                 // cache=[1,2], cnt(2)=1, cnt(1)=2
lfu.put(3, 3);   // 2 is the LFU key because cnt(2)=1 is the smallest, invalidate 2.
                 // cache=[3,1], cnt(3)=1, cnt(1)=2
lfu.get(2);      // return -1 (not found)
lfu.get(3);      // return 3
                 // cache=[3,1], cnt(3)=2, cnt(1)=2
lfu.put(4, 4);   // Both 1 and 3 have the same cnt, but 1 is LRU, invalidate 1.
                 // cache=[4,3], cnt(4)=1, cnt(3)=2
lfu.get(1);      // return -1 (not found)
lfu.get(3);      // return 3
                 // cache=[3,4], cnt(4)=1, cnt(3)=3
lfu.get(4);      // return 4
                 // cache=[4,3], cnt(4)=2, cnt(3)=3


Constraints:

0 <= capacity <= 104
0 <= key <= 105
0 <= value <= 109
At most 2 * 105 calls will be made to get and put.

*/

/*
Solution 1:
2 map
- cache to store: [key, (frequency, value)]
- freqMap to store: [freq, [same frequency keys]]

For get():
- check if key exist before
  - exist before, return value, increase its frequency insert(key, freq+1, value)

For put():
- check if key exist before
  - exist before, update key value in cache
    - use get() to update frequency
  - not exist, check if current cache reaches capacity
    - reached
      - remove LFU or LRU (use freqMap[minFreq].removeFirst)
      - update related cache and freqMap
      - minFreq = 1 for new added
      - insert(key, 1, value)

private function
- insert(key, freq, value): insert it into cache and update freqMap
- insertKeyToFreqMap
  - remove key from it first, then append it to the freqMap array
- removeKeyFromFreqMap

Time Complexity:
- get: O(N * capacity)
  - N number of operations
- put: O(N * capacity)

*/
class LFUCache {
    var capacity: Int

    // value is the (frequency, value)
    var cache = [Int: (freq: Int, val: Int)]()

    // key is frequency
    // val is key has same frequency, keep elements ordered by recent usage
    var freqMap = [Int: [Int]]()

    // least frequency
    var minFreq = 0

    init(_ capacity: Int) {
        self.capacity = capacity
    }

    func insertKeyToFreqMap(_ freq: Int, _ key: Int) {
        removeKeyFromFreqMap(freq, key)
        freqMap[freq, default: [Int]()].append(key)
    }

    func removeKeyFromFreqMap(_ freq: Int, _ key: Int) {
        guard var list = freqMap[freq] else {
            return
        }

        for i in 0..<list.count {
            if list[i] == key {
                list.remove(at: i)
                freqMap[freq] = list.isEmpty ? nil : list
                return
            }
        }
    }

    func insert(_ key: Int, _ freq: Int, _ val: Int) {
        cache[key] = (freq, val)

        // insert key into freqMap
        // and keep it unique
        insertKeyToFreqMap(freq, key)
    }

    func get(_ key: Int) -> Int {
        if let (freq, val) = cache[key] {
            removeKeyFromFreqMap(freq, key)
            if minFreq == freq, freqMap[freq] == nil {
                minFreq += 1
            }
            insert(key, freq+1, val)
            return val
        } else {
            return -1
        }
    }

    func put(_ key: Int, _ value: Int) {
        if capacity == 0 { return }
        if let (freq, val) = cache[key] {
            // key exists before, update counter and map
            cache[key] = (freq, value)
            get(key)
        } else {
            // key not exist, check current capacity
            if cache.keys.count == capacity {
                // remove least frequently used / least recently used
                let keyToDelete = freqMap[minFreq]!.removeFirst()
                cache[keyToDelete] = nil
                removeKeyFromFreqMap(minFreq, keyToDelete)
            }
            minFreq = 1
            insert(key, 1, value)
        }
    }
}

/**
 * Your LFUCache object will be instantiated and called as such:
 * let obj = LFUCache(capacity)
 * let ret_1: Int = obj.get(key)
 * obj.put(key, value)
 */
