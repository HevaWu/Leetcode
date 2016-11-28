/*281. Zigzag Iterator  QuestionEditorial Solution  My Submissions
Total Accepted: 15095 Total Submissions: 32722 Difficulty: Medium
Given two 1d vectors, implement an iterator to return their elements alternately.

For example, given two 1d vectors:

v1 = [1, 2]
v2 = [3, 4, 5, 6]
By calling next repeatedly until hasNext returns false, the order of elements returned by next should be: [1, 3, 2, 4, 5, 6].

Follow up: What if you are given k 1d vectors? How well can your code be extended to such cases?

Clarification for the follow up question - Update (2015-09-18):
The "Zigzag" order is not clearly defined and is ambiguous for k > 2 cases. If "Zigzag" does not look right to you, replace "Zigzag" with "Cyclic". For example, given the following input:

[1,2,3]
[4,5,6,7]
[8,9]
It should return [1,4,8,2,5,9,3,6,7].
Hide Company Tags Google
Hide Tags Design
Hide Similar Problems (M) Binary Search Tree Iterator (M) Flatten 2D Vector (M) Peeking Iterator (M) Flatten Nested List Iterator
*/



/*c++ --- use queue to store the iterator of v1 and v2 or k vector's iterator
java --- use linkedlist to store the iterator of v1 and v2 or k vector's iterator
next() --- remove the first iterator, after poll it, if ther is element in it, add it into the back of list
hasNext() --- check if the list of iterator is empty
*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class ZigzagIterator {
    private:
    queue<pair<vector<int>::iterator, vector<int>::iterator>> mylist;

public:
    ZigzagIterator(vector<int>& v1, vector<int>& v2) {
        if(v1.size()!=0){
            mylist.push(make_pair(v1.begin(), v1.end()));//make pair
        }
        if(v2.size()!=0){
            mylist.push(make_pair(v2.begin(), v2.end()));
        }
    }

    int next() {
        vector<int>::iterator it = mylist.front().first;
        vector<int>::iterator itend = mylist.front().second;
        mylist.pop();
        if(it+1!=itend){
            mylist.push(make_pair(it+1,itend));
        }
        return *it;
    }

    bool hasNext() {
        return !mylist.empty();
    }
};

/**
 * Your ZigzagIterator object will be instantiated and called as such:
 * ZigzagIterator i(v1, v2);
 * while (i.hasNext()) cout << i.next();
 */




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class ZigzagIterator {
    private LinkedList<Iterator> mylist = new LinkedList<>(); //initialize LinkedList, otherwise cannot use poll() function

    public ZigzagIterator(List<Integer> v1, List<Integer> v2) {
        if(!v1.isEmpty()){
            mylist.add(v1.iterator());
        }
        if(!v2.isEmpty()){
            mylist.add(v2.iterator());
        }
    }

    public int next() {
        Iterator it = mylist.poll();
        int ret = (Integer)it.next(); //first transfer it into int
        if(it.hasNext()){
            mylist.add(it);
        }
        return ret;
    }

    public boolean hasNext() {
        return !mylist.isEmpty();
    }
}

/**
 * Your ZigzagIterator object will be instantiated and called as such:
 * ZigzagIterator i = new ZigzagIterator(v1, v2);
 * while (i.hasNext()) v[f()] = i.next();
 */
