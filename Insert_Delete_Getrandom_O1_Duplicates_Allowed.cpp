/*381. Insert Delete GetRandom O(1) - Duplicates allowed  QuestionEditorial Solution  My Submissions
Total Accepted: 2013
Total Submissions: 6597
Difficulty: Hard
Design a data structure that supports all following operations in average O(1) time.

Note: Duplicate elements are allowed.
insert(val): Inserts an item val to the collection.
remove(val): Removes an item val from the collection if present.
getRandom: Returns a random element from current collection of elements. The probability of each element being returned is linearly related to the number of same value the collection contains.
Example:

// Init an empty collection.
RandomizedCollection collection = new RandomizedCollection();

// Inserts 1 to the collection. Returns true as the collection did not contain 1.
collection.insert(1);

// Inserts another 1 to the collection. Returns false as the collection contained 1. Collection now contains [1,1].
collection.insert(1);

// Inserts 2 to the collection, returns true. Collection now contains [1,1,2].
collection.insert(2);

// getRandom should return 1 with the probability 2/3, and returns 2 with the probability 1/3.
collection.getRandom();

// Removes 1 from the collection, returns true. Collection now contains [1,2].
collection.remove(1);

// getRandom should return 1 and 2 both equally likely.
collection.getRandom();*/





/////////////////////////////////////////////////////////////////////////////////////
//C++
class RandomizedCollection {

    
private:
    unordered_map<int, vector<int> > mymap;
    vector<int> ele;

public:
    /** Initialize your data structure here. */
    RandomizedCollection() {
        
    }
    
    /** Inserts a value to the collection. Returns true if the collection did not already contain the specified element. */
    bool insert(int val) {
        mymap[val].push_back(ele.size());
        ele.push_back(val);
        return mymap[val].size()==1;
    }
    
    /** Removes a value from the collection. Returns true if the collection contained the specified element. */
    bool remove(int val) {
        auto bucket = &mymap[val];
        bool ifexist = !bucket->empty();
        
        if(ifexist){
            int bback = bucket->back(); //do not forget "()"
            bucket->pop_back();
            int eback = ele.back();
            ele.pop_back();
            if(eback != val){
                mymap[eback].back() = bback;
                ele[bback] = eback;
            }
        }
        
        return ifexist;;
    }
    
    /** Get a random element from the collection. */
    int getRandom() {
        int pos = rand() % ele.size();
        return ele[pos];
    }
};

/**
 * Your RandomizedCollection object will be instantiated and called as such:
 * RandomizedCollection obj = new RandomizedCollection();
 * bool param_1 = obj.insert(val);
 * bool param_2 = obj.remove(val);
 * int param_3 = obj.getRandom();
 */







/////////////////////////////////////////////////////////////////////////////////////
//Java
public class RandomizedCollection {
    
    ArrayList<Integer> ele;
    HashMap<Integer, LinkedHashSet<Integer>> mymap;

    /** Initialize your data structure here. */
    public RandomizedCollection() {
        ele = new ArrayList<Integer>();
        mymap = new HashMap<Integer, LinkedHashSet<Integer> >(); 
    }
    
    /** Inserts a value to the collection. Returns true if the collection did not already contain the specified element. */
    public boolean insert(int val) {
        boolean ifexist = mymap.containsKey(val);
        if(!ifexist){
            mymap.put(val, new LinkedHashSet<Integer>());
        }
        mymap.get(val).add(ele.size());
        ele.add(val);
        return !ifexist;
    }
    
    /** Removes a value from the collection. Returns true if the collection contained the specified element. */
    public boolean remove(int val) {
        if(!mymap.containsKey(val)){
            return false;
        }
        
        //Get arbitary index of the ArrayList that contains val
        LinkedHashSet<Integer> valSet = mymap.get(val);
        int vback = valSet.iterator().next();
        
        //Get the set of the number in the last place of the ArrayList
        int eback = ele.get(ele.size() - 1);
        LinkedHashSet<Integer> replaceVal = mymap.get(eback);
        
        //replace val at arbitary index withvery last number
        ele.set(vback, eback);
        
        //Remove appropriate index
        valSet.remove(vback);
        
        //donot change set if we were replacing the removed item with the same number
        if(vback != ele.size() - 1){
            replaceVal.remove(ele.size() - 1);
            replaceVal.add(vback);
        }
        ele.remove(ele.size() - 1);
        
        //Remove mymap entry if set is now empty, then return
        if(valSet.isEmpty()){
            mymap.remove(val);
        }
        
        return true;
    }
    
    /** Get a random element from the collection. */
    public int getRandom() {
        return ele.get((int)(Math.random() * ele.size()));
    }
}

/**
 * Your RandomizedCollection object will be instantiated and called as such:
 * RandomizedCollection obj = new RandomizedCollection();
 * boolean param_1 = obj.insert(val);
 * boolean param_2 = obj.remove(val);
 * int param_3 = obj.getRandom();
 */