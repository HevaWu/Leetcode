/*
155. Min Stack Add to List
Description  Submission  Solutions
Total Accepted: 115084
Total Submissions: 426862
Difficulty: Easy
Contributors: Admin
Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.

push(x) -- Push element x onto stack.
pop() -- Removes the element on top of the stack.
top() -- Get the top element.
getMin() -- Retrieve the minimum element in the stack.
Example:
MinStack minStack = new MinStack();
minStack.push(-2);
minStack.push(0);
minStack.push(-3);
minStack.getMin();   --> Returns -3.
minStack.pop();
minStack.top();      --> Returns 0.
minStack.getMin();   --> Returns -2.
Hide Company Tags Google Uber Zenefits Amazon Snapchat Bloomberg
Hide Tags Stack Design
Hide Similar Problems (H) Sliding Window Maximum
*/



/////////////////////////////////////////////////////////////////////////////////////
//C++
class MinStack {
    private:
    stack<int> s1;
    stack<int> s2;
public:
    void push(int x) {
        s1.push(x);
        if(s2.empty() || x<=getMin()) s2.push(x);
    }

    void pop() {
        if(s1.top() == getMin()) s2.pop();
        s1.pop();
    }

    int top() {
        return s1.top();
    }

    int getMin() {
        return s2.top();
    }
};



/*use stack structure
store the gap between the min value and the current value
it is possible the gap is between INT_MIN INT_MAX
push(x) --- store the gap, if this value is less than min, update minvalue
pop() --- mystack.pop(), and check if this element is < 0, if it is, it is the current minvalue, increase the minvalue
top() --- mystack.peek() and check if this element is < 0, it it is return the minvalue, if not, return curvalue + minvalue
getMin() --- just return minvalue



//Follow up
if find the max Stack
max Element
push() --- S.push(maxValue-x), if(x>maxValue) maxValue = x
pop() --- if current pop value < 0, current is the max element, update maxValue = maxValue+val
top() --- if current top value < 0, return max, else return max-val
getMax() --- return maxValue
*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class MinStack {
    private Stack<Long> myStack; //Long, not long, long type pay attention
    long minValue;  //store long type for the minValue to avoid integer out of limit

    /** initialize your data structure here. */
    public MinStack() {
        myStack = new Stack<>();
    }

    public void push(int x) {
        if(myStack.isEmpty()){
            myStack.push(0L); // 0L means the number zero of type long
            minValue = x;
        } else {
            myStack.push(x-minValue); //could be negative if minvalue need to change
            if(x<minValue){
                minValue = x;
            }
        }
    }

    public void pop() {
        if(myStack.isEmpty()){
            return;
        }
        long popValue = myStack.pop(); // pop() remove the top element and return that object
        if(popValue<0){
            minValue = minValue-popValue; //if negative, increase the minvalue
        }
    }

    public int top() {
        long topValue = myStack.peek(); //peek() see the top element without remove
        if(topValue > 0){
            return (int)(topValue + minValue);
        } else {
            return (int)(minValue);
        }
    }

    public int getMin() {
        return (int)minValue;
    }
}

/**
 * Your MinStack object will be instantiated and called as such:
 * MinStack obj = new MinStack();
 * obj.push(x);
 * obj.pop();
 * int param_3 = obj.top();
 * int param_4 = obj.getMin();
 */
