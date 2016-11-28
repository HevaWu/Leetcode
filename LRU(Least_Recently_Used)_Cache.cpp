/*146. LRU Cache  QuestionEditorial Solution  My Submissions
Total Accepted: 83156
Total Submissions: 524972
Difficulty: Hard
Design and implement a data structure for Least Recently Used (LRU) cache. It should support the following operations: get and set.

get(key) - Get the value (will always be positive) of the key if the key exists in the cache, otherwise return -1.
set(key, value) - Set or insert the value if the key is not already present. When the cache reached its capacity, it should invalidate the least recently used item before inserting a new item.

Subscribe to see which companies asked this question
Hide Company Tags Google Uber Facebook Twitter Zenefits Amazon Microsoft Snapchat Yahoo Bloomberg Palantir
Hide Tags Design
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
cache  ---  HashMap<Integer, LinkedNode>
head --- LinkedNode, the head node of this linkedlist
tail --- linkedNode, the tail node of this linkedlist
LinkedNode --- key, value, pre, post
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
set(key, value) --- cache.get(key),
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
    public class LinkedNode {
        int key;
        int value;
        LinkedNode pre;
        LinkedNode post;
    }

    private HashMap<Integer, LinkedNode> cache = new HashMap<Integer, LinkedNode>();
    private int count;
    private int capacity;
    private LinkedNode head, tail;

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

    private void moveToHead(LinkedNode node) { //move certain node in between to the head
        this.removeNode(node);
        this.addNode(node);
    }

    private void removeNode(LinkedNode node) { //remove an existing node from the linkedlist
        LinkedNode pre = node.pre;
        LinkedNode post = node. post;

        pre.post = post;
        post.pre = pre;
    }

    private void addNode(LinkedNode node) { //always add the new node right after head
        node.pre = head;
        node.post = head.post;

        head.post.pre = node;
        head.post = node;
    }




    private LinkedNode popTail() { //pop the current tail
        LinkedNode ret = tail.pre;
        this.removeNode(ret);
        return ret;
    }



    public int get(int key) {
        LinkedNode node = this.cache.get(key);
        if (node == null) {
            return -1; //should raise exception here
        }

        this.moveToHead(node); //,pve the accessed node to the head

        return node.value;
    }

    public void set(int key, int value) {
        LinkedNode node = this.cache.get(key);

        if (node == null) {
            LinkedNode newNode = new LinkedNode();
            newNode.key = key;
            newNode.value = value;

            this.cache.put(key, newNode);
            this.addNode(newNode);

            ++count;

            if (count > capacity) {
                LinkedNode curtail = this.popTail(); //pop the tail
                this.cache.remove(curtail.key); //remove curtail.key
                --count;
            }
        } else {
            node.value = value; //update the value
            this.moveToHead(node);
        }
    }
}