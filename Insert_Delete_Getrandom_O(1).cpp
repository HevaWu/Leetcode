/*380. Insert Delete GetRandom O(1)  QuestionEditorial Solution  My Submissions
Total Accepted: 4173
Total Submissions: 11983
Difficulty: Hard
Design a data structure that supports all following operations in average O(1) time.

insert(val): Inserts an item val to the set if not already present.
remove(val): Removes an item val from the set if present.
getRandom: Returns a random element from current set of elements. Each element must have the same probability of being returned.
Example:

Init an empty set.
RandomizedSet randomSet = new RandomizedSet();

Inserts 1 to the set. Returns true as 1 was inserted successfully.
randomSet.insert(1);

Returns false as 2 does not exist in the set.
randomSet.remove(2);

Inserts 2 to the set, returns true. Set now contains [1,2].
randomSet.insert(2);

getRandom should return either 1 or 2 randomly.
randomSet.getRandom();

Removes 1 from the set, returns true. Set now contains [2].
randomSet.remove(1);

2 was already in the set, so return false.
randomSet.insert(2);

Since 1 is the only number in the set, getRandom always return 1.
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
    private:
        vector<int> ele;
        unordered_map<int, int> mymap;
    public:
        /** Initialize your data structure here. */
        RandomizedSet() {

        }

        /** Inserts a value to the set. Returns true if the set did not already contain the specified element. */
        bool insert(int val) {
            if(mymap.find(val) != mymap.end()){
                return false;
            }
            ele.emplace_back(val);
            mymap[val] = ele.size() - 1;
            return true;
        }

        /** Removes a value from the set. Returns true if the set contained the specified element. */
        bool remove(int val) {
            if(mymap.find(val) == mymap.end()){
                return false;
            }
            int eback = ele.back();
            mymap[eback] = mymap[val];
            ele[mymap[val]] = eback;
            ele.pop_back();
            mymap.erase(val);
            return true;
        }

        /** Get a random element from the set. */
        int getRandom() {
            return ele[rand() % ele.size()];
        }
    };

    /**
     * Your RandomizedSet object will be instantiated and called as such:
     * RandomizedSet obj = new RandomizedSet();
     * bool param_1 = obj.insert(val);
     * bool param_2 = obj.remove(val);
     * int param_3 = obj.getRandom();
     */
