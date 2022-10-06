/*
Design a time-based key-value data structure that can store multiple values for the same key at different time stamps and retrieve the key's value at a certain timestamp.

Implement the TimeMap class:

TimeMap() Initializes the object of the data structure.
void set(String key, String value, int timestamp) Stores the key key with the value value at the given time timestamp.
String get(String key, int timestamp) Returns a value such that set was called previously, with timestamp_prev <= timestamp. If there are multiple such values, it returns the value associated with the largest timestamp_prev. If there are no values, it returns "".


Example 1:

Input
["TimeMap", "set", "get", "get", "set", "get", "get"]
[[], ["foo", "bar", 1], ["foo", 1], ["foo", 3], ["foo", "bar2", 4], ["foo", 4], ["foo", 5]]
Output
[null, null, "bar", "bar", null, "bar2", "bar2"]

Explanation
TimeMap timeMap = new TimeMap();
timeMap.set("foo", "bar", 1);  // store the key "foo" and value "bar" along with timestamp = 1.
timeMap.get("foo", 1);         // return "bar"
timeMap.get("foo", 3);         // return "bar", since there is no value corresponding to foo at timestamp 3 and timestamp 2, then the only value is at timestamp 1 is "bar".
timeMap.set("foo", "bar2", 4); // store the key "foo" and value "bar2" along with timestamp = 4.
timeMap.get("foo", 4);         // return "bar2"
timeMap.get("foo", 5);         // return "bar2"


Constraints:

1 <= key.length, value.length <= 100
key and value consist of lowercase English letters and digits.
1 <= timestamp <= 107
All the timestamps timestamp of set are strictly increasing.
At most 2 * 105 calls will be made to set and get.
*/

/*
Solution 1:

- prevKey: use to record each key's timestamp list
- map: record (key+timestamp)'s value

Time Complexity:
- set: O(1)
- get: O(log(d))
  - d is maximum timestamp length for each key
*/
class TimeMap {
    Map<String, String> map;
    Map<String, List<Integer>> prevKeys;

    public TimeMap() {
        map = new HashMap<>();
        prevKeys = new HashMap<>();
    }

    public void set(String key, String value, int timestamp) {
        map.put(getKey(key, timestamp), value);
        List<Integer> prevList = prevKeys.getOrDefault(key, new ArrayList<>());
        prevList.add(timestamp);
        prevKeys.put(key, prevList);
    }

    public String get(String key, int timestamp) {
        if (map.containsKey(getKey(key, timestamp))) {
            return map.getOrDefault(getKey(key, timestamp), "");
        }
        return checkPrevKeys(key, timestamp);
    }

    public String checkPrevKeys(String key, int timestamp) {
        if (!prevKeys.containsKey(key)) {
            return "";
        }
        List<Integer> prevList = prevKeys.getOrDefault(key, new ArrayList<>());
        int len = prevList.size();
        if (prevList.get(0).intValue() > timestamp) {
            return "";
        }
        int l = 0;
        int r = len - 1;
        while (l < r) {
            int mid = l + (r - l) / 2;
            if (prevList.get(mid).intValue() < timestamp) {
                l = mid + 1;
            } else {
                r = mid;
            }
        }
        int largest = prevList.get(l).intValue() < timestamp ? l : l - 1;
        return map.getOrDefault(getKey(key, prevList.get(largest).intValue()), "");
    }

    public String getKey(String key, int timestamp) {
        return key + timestamp;
    }
}

/**
 * Your TimeMap object will be instantiated and called as such:
 * TimeMap obj = new TimeMap();
 * obj.set(key,value,timestamp);
 * String param_2 = obj.get(key,timestamp);
 */
