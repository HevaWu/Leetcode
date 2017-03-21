/*146. LRU Cache Add to List
Description  Submission  Solutions
Total Accepted: 113887
Total Submissions: 689747
Difficulty: Hard
Contributors: Admin
Design and implement a data structure for Least Recently Used (LRU) cache. It should support the following operations: get and put.

get(key) - Get the value (will always be positive) of the key if the key exists in the cache, otherwise return -1.
put(key, value) - Set or insert the value if the key is not already present. When the cache reached its capacity, it should invalidate the least recently used item before inserting a new item.

Follow up:
Could you do both operations in O(1) time complexity?

Example:

LRUCache cache = new LRUCache( 2 -- capacity  );

cache.put(1, 1);
cache.put(2, 2);
cache.get(1);       // returns 1
cache.put(3, 3);    // evicts key 2
cache.get(2);       // returns -1 (not found)
cache.put(4, 4);    // evicts key 1
cache.get(1);       // returns -1 (not found)
cache.get(3);       // returns 3
cache.get(4);       // returns 4
Hide Company Tags Google Uber Facebook Twitter Zenefits Amazon Microsoft Snapchat Yahoo Bloomberg Palantir
Hide Tags Design
Hide Similar Problems (H) LFU Cache

*/


/*
use unordered_map to store cache
store iterator to corresponding LRU queue in the values of the hash map
run in a constant time
*/
/////////////////////////////////////////////////////////////////////////////////////
//C++
class LRUCache {
private:
    typedef list<int> L;
    typedef pair<int, L::iterator> P;
    typedef unordered_map<int, P> cacheP;

    cacheP cache;
    L used;
    int Pcapacity;

    void touch(cacheP::iterator it) {
        int key = it->first;
        used.erase(it->second.second);
        //each time push it from the front,
        //let the back of used is the least recently used item
        used.push_front(key);
        it->second.second = used.begin();
    }

public:
    LRUCache(int capacity) {
        Pcapacity = capacity;
    }

    int get(int key) {
        auto it = cache.find(key);
        if (it == cache.end()) { //not exist
            return -1;
        }
        touch(it);
        return it->second.first;
    }

    void set(int key, int value) {
        auto it = cache.find(key);
        if (it != cache.end()) {
            touch(it);
        } else {
            if (cache.size() == Pcapacity) {
                //like insert we need to check if there enough space to insert this item
                cache.erase(used.back()); //invalidate the least recently used item
                used.pop_back();
            }
            used.push_front(key);
        }
        cache[key] = {value, used.begin()};
    }
};








/*
LinkedNode --- key, value, pre, post

cache  ---  HashMap<Integer, LinkedNode>
head --- LinkedNode, the head node of this linkedlist
tail --- linkedNode, the tail node of this linkedlist
count --- count the current of node in the linkedlist and cache, for prevent larger than capacity
capacity --- start from initialize the cache

LRUCache(capacity) --- initialize this cache
    count, capacity, head, tail
moveToHead --- move certain node to head,
    first remove it in the list,
    then add it
removeNode ---
addNode --- always add the new node after head,
popTail() --- pop the current tail node in the linkedlist
    removeNode(tail.pre)

get(key) --- cache.get(key), then move this node to the head, return node
put(key, value) --- cache.get(key),
    if the node is null,
        create a newNode for this key,
        and push it in cache,
        and add this newnode in linkedlist
        ++count, and check if count > capacity
            if it is, this.popTail() pop the tail node of this linkedList
                and cache.remove(tail.key)
                --count
    else update the node.value
        moveToHead(node) move this node to head
*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class LRUCache {
    public class LinkedNode{
        int key;
        int value;
        LinkedNode pre;
        LinkedNode post;
    }

    private int count;
    private int capacity;
    private Map<Integer, LinkedNode> cache = new HashMap<>();
    private LinkedNode head;
    private LinkedNode tail;

    public LRUCache(int capacity) {
        this.count = 0;
        this.capacity = capacity;

        head = new LinkedNode();
        head.pre = null;

        tail = new LinkedNode();
        tail.post = null;

        head.post = tail;
        tail.pre = head;
    }

    public int get(int key) {
        //get the value of current key
        LinkedNode node = this.cache.get(key);
        if(node==null) return -1;

        //remember move this node to the head, since it been visited
        this.moveToHead(node);
        return node.value;
    }

    public void moveToHead(LinkedNode node){
        //move one node to the head of the list
        this.removeNode(node);
        this.addNode(node);
    }

    public void removeNode(LinkedNode node){
        //remove one node in the list
        node.pre.post = node.post;
        node.post.pre = node.pre;
    }

    public void addNode(LinkedNode node){
        //add a node in the list
        node.post = head.post;
        node.pre = head;
        head.post.pre = node;
        head.post = node;
    }

    public void put(int key, int value) {
        //if this key in the map update it value
        //if not, create a new node for this key value
        LinkedNode node = this.cache.get(key);
        if(node==null){
            //this node is not the map and list
            //create a new node
            LinkedNode newNode = new LinkedNode();
            newNode.key = key;
            newNode.value = value;

            //insert newNode to current cache
            this.cache.put(key, newNode);
            this.addNode(newNode);

            //check current count
            ++count;
            if(count > capacity){
                //if out of the capacity
                //invalid the tail element in the list
                LinkedNode curtail = this.popTail();
                this.cache.remove(curtail.key);
                --count;
            }
        } else {
            node.value = value;
            this.moveToHead(node);
        }
    }

    public void popTail(){
        //pop current tail element in the list
        LinkedList curtail = tail.pre;
        this.removeNode(curtail);
        return curtail;
    }
}

/**
 * Your LRUCache object will be instantiated and called as such:
 * LRUCache obj = new LRUCache(capacity);
 * int param_1 = obj.get(key);
 * obj.put(key,value);
 */
