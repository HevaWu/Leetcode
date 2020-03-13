// Create a timebased key-value store class TimeMap, that supports two operations.

// 1. set(string key, string value, int timestamp)

// Stores the key and value, along with the given timestamp.
// 2. get(string key, int timestamp)

// Returns a value such that set(key, value, timestamp_prev) was called previously, with timestamp_prev <= timestamp.
// If there are multiple such values, it returns the one with the largest timestamp_prev.
// If there are no values, it returns the empty string ("").
 

// Example 1:

// Input: inputs = ["TimeMap","set","get","get","set","get","get"], inputs = [[],["foo","bar",1],["foo",1],["foo",3],["foo","bar2",4],["foo",4],["foo",5]]
// Output: [null,null,"bar","bar",null,"bar2","bar2"]
// Explanation:   
// TimeMap kv;   
// kv.set("foo", "bar", 1); // store the key "foo" and value "bar" along with timestamp = 1   
// kv.get("foo", 1);  // output "bar"   
// kv.get("foo", 3); // output "bar" since there is no value corresponding to foo at timestamp 3 and timestamp 2, then the only value is at timestamp 1 ie "bar"   
// kv.set("foo", "bar2", 4);   
// kv.get("foo", 4); // output "bar2"   
// kv.get("foo", 5); //output "bar2"   

// Example 2:

// Input: inputs = ["TimeMap","set","set","get","get","get","get","get"], inputs = [[],["love","high",10],["love","low",20],["love",5],["love",10],["love",15],["love",20],["love",25]]
// Output: [null,null,null,"","high","high","low","low"]
 

// Note:

// All key/value strings are lowercase.
// All key/value strings have length in the range [1, 100]
// The timestamps for all TimeMap.set operations are strictly increasing.
// 1 <= timestamp <= 10^7
// TimeMap.set and TimeMap.get functions will be called a total of 120000 times (combined) per test case.

// Solution 1: hashmap + binary search
// map to set the key, 
// use binary search to get the correct timestamp
// 
// Time complexity: 
// set: O(1)
// get: O(log n) , n is current map[key] list len
// 
// Space complexity: O(n) n is number entries
class TimeMap {
    // key is key
    // value is [timestamp, value]
    var map = [String: [(Int, String)]]()
    /** Initialize your data structure here. */
    init() {
        
    }
    
    func set(_ key: String, _ value: String, _ timestamp: Int) {
        map[key, default: [(Int, String)]()].append((timestamp, value))
    }
    
    func get(_ key: String, _ timestamp: Int) -> String {
        guard let list = map[key], timestamp >= list[0].0 else { return String() }
        var left = 0
        var right = list.count-1
        while left < right {
            var mid = (left+right)/2
            
            if list[mid].0 == timestamp {
                left = mid
                break
            }
            
            if list[mid].0 < timestamp {
                left = mid + 1
            } else {
                right = mid
            }
        }
        return list[left].0 <= timestamp ? list[left].1 : list[left-1].1
    }
}

/**
 * Your TimeMap object will be instantiated and called as such:
 * let obj = TimeMap()
 * obj.set(key, value, timestamp)
 * let ret_2: String = obj.get(key, timestamp)
 */
