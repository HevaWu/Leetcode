/*341. Flatten Nested List Iterator  QuestionEditorial Solution  My Submissions
Total Accepted: 13050
Total Submissions: 38824
Difficulty: Medium
Given a nested list of integers, implement an iterator to flatten it.

Each element is either an integer, or a list -- whose elements may also be integers or other lists.

Example 1:
Given the list [[1,1],2,[1,1]],

By calling next repeatedly until hasNext returns false, the order of elements returned by next should be: [1,1,2,1,1].

Example 2:
Given the list [1,[4,[6]]],

By calling next repeatedly until hasNext returns false, the order of elements returned by next should be: [1,4,6].

Hide Company Tags Google Facebook Twitter
Hide Tags Stack Design
Hide Similar Problems (M) Flatten 2D Vector (M) Zigzag Iterator (M) Mini Parser
*/




/*
use a stack to store the listiterator<NestedInteger> 
for init,
init stack is new
and push a nestedList.listIterator into this stack
next() --- first do hasNext(), if it is, return stack.peek().next().getInteger()
hasNext() --- 
    if stack.peek().hasNext() is false, pop this element out
    else 
        check if stack.peek().next().isInteger(), 
            if it is, return stack.peek().previous==x  --- check if number is correct
            else stack.push(stack.peek().listIterator())  --- this is a list
    return false;
        */+

/////////////////////////////////////////////////////////////////////////////////////
//C++
/**
 * // This is the interface that allows for creating nested lists.
 * // You should not implement it, or speculate about its implementation
 * class NestedInteger {
 *   public:
 *     // Return true if this NestedInteger holds a single integer, rather than a nested list.
 *     bool isInteger() const;
 *
 *     // Return the single integer that this NestedInteger holds, if it holds a single integer
 *     // The result is undefined if this NestedInteger holds a nested list
 *     int getInteger() const;
 *
 *     // Return the nested list that this NestedInteger holds, if it holds a nested list
 *     // The result is undefined if this NestedInteger holds a single integer
 *     const vector<NestedInteger> &getList() const;
 * };
 */
class NestedIterator {
private:
    stack<vector<NestedInteger>::iterator> begins,ends;
    
public:
    NestedIterator(vector<NestedInteger> &nestedList) {
        begins.push(nestedList.begin());
        ends.push(nestedList.end());
    }

    int next() {
        hasNext();
        return (begins.top()++)->getInteger();
    }

    bool hasNext() {
        while(begins.size()){
            if(begins.top() == ends.top()){
                begins.pop();
                ends.pop();
            }else{
                auto x = begins.top();
                if(x->isInteger()){
                    return true;
                }
                begins.top()++;
                begins.push(x->getList().begin());
                ends.push(x->getList().end());
            }
        }
        return false;
    }
};

/**
 * Your NestedIterator object will be instantiated and called as such:
 * NestedIterator i(nestedList);
 * while (i.hasNext()) cout << i.next();
 */







/////////////////////////////////////////////////////////////////////////////////////
//Java
/**
 * // This is the interface that allows for creating nested lists.
 * // You should not implement it, or speculate about its implementation
 * public interface NestedInteger {
 *
 *     // @return true if this NestedInteger holds a single integer, rather than a nested list.
 *     public boolean isInteger();
 *
 *     // @return the single integer that this NestedInteger holds, if it holds a single integer
 *     // Return null if this NestedInteger holds a nested list
 *     public Integer getInteger();
 *
 *     // @return the nested list that this NestedInteger holds, if it holds a nested list
 *     // Return null if this NestedInteger holds a single integer
 *     public List<NestedInteger> getList();
 * }
 */
public class NestedIterator implements Iterator<Integer> {
    private Stack<ListIterator<NestedInteger>> lists;

    public NestedIterator(List<NestedInteger> nestedList) {
        lists = new Stack<>();
        lists.push(nestedList.listIterator());
    }

    @Override
    public Integer next() {
        hasNext();
        return lists.peek().next().getInteger();
    }

    @Override
    public boolean hasNext() {
        while(!lists.empty()){
            if(!lists.peek().hasNext()){
                lists.pop();
            } else {
                NestedInteger x = lists.peek().next();
                //listIterator.next() --- return the next element in the list and advances the cursor position
                if(x.isInteger()){//x is integer
                    return lists.peek().previous() == x;
                    //since before this step, x is get by next(), so cursor move back, use previous() to get the originally x element
                    //listIterator.previous() --- return the previous element in the list, and move the cursor position backwards
                }
                //x is a list,push the list iterator into stack
                lists.push(x.getList().listIterator());
            }
        }
        return false;
    }
}

/**
 * Your NestedIterator object will be instantiated and called as such:
 * NestedIterator i = new NestedIterator(nestedList);
 * while (i.hasNext()) v[f()] = i.next();
 */