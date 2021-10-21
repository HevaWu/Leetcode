/*380. Insert Delete GetRandom O(1)  QuestionEditorial Solution  My Submissions
Total Accepted: 4173
Total Submissions: 11983
Difficulty: Hard
Design a data structure that supports all following operations in average O(1) time.

insert(val): Inserts an item val to the set if not already present.
remove(val): Removes an item val from the set if present.
getRandom: Returns a random element from current set of elements. Each element must have the same probability of being returned.
Example:

// Init an empty set.
RandomizedSet randomSet = new RandomizedSet();

// Inserts 1 to the set. Returns true as 1 was inserted successfully.
randomSet.insert(1);

// Returns false as 2 does not exist in the set.
randomSet.remove(2);

// Inserts 2 to the set, returns true. Set now contains [1,2].
randomSet.insert(2);

// getRandom should return either 1 or 2 randomly.
randomSet.getRandom();

// Removes 1 from the set, returns true. Set now contains [2].
randomSet.remove(1);

// 2 was already in the set, so return false.
randomSet.insert(2);

// Since 1 is the only number in the set, getRandom always return 1.
randomSet.getRandom();
Hide Company Tags Google Uber Twitter Amazon Yelp Pocket Gems
Hide Tags Array Hash Table Design
Hide Similar Problems (H) Insert Delete GetRandom O(1) - Duplicates allowed
*/




/*
use HashMap<Integer,Integer> mymap, key is cur val, value is when it insert, which is ele.size(), for convenient to check if the key is exist in map
ArrayList<Integer> ele store the current key we already inserted
insert(val) --- mymap.containsKey(val), if it is, return false, else insert it
remove(val) --- first check if this val exist, if it isnot exist, return false
    then, remove if from mymap and ele list
    before remove it ,
        to ele list, switch cur val to the end of ele list
        to mymap, also switch the its value with the end value
getRandom --- use java.util.Random to random get the random ele in ele list
    ele.get(rand.nextInt(ele.size()))*/
class RandomizedSet {
    List<Integer> arr;
    HashMap<Integer, Integer> mymap;
    java.util.Random rand = new java.util.Random();

    public RandomizedSet() {
        arr = new ArrayList<>();
        mymap = new HashMap<>();
    }

    public boolean insert(int val) {
        if (mymap.containsKey(val)) {
            return false;
        } else {
            mymap.put(val, arr.size());
            arr.add(val);
            return true;
        }
    }

    public boolean remove(int val) {
        if (!mymap.containsKey(val)) {
            return false;
        } else {
            int index = mymap.get(val);
            if (index < arr.size()-1) {
                int lastElement = arr.get(arr.size() - 1);
                arr.set(index, lastElement);
                mymap.put(lastElement, index);
            }
            arr.remove(arr.size()-1);
            mymap.remove(val);
            return true;
        }
    }

    public int getRandom() {
        return arr.get(rand.nextInt(arr.size()));
    }
}

/**
 * Your RandomizedSet object will be instantiated and called as such:
 * RandomizedSet obj = new RandomizedSet();
 * boolean param_1 = obj.insert(val);
 * boolean param_2 = obj.remove(val);
 * int param_3 = obj.getRandom();
 */
