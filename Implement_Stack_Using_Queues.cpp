/*
Implement the following operations of a stack using queues.

push(x) -- Push element x onto stack.
pop() -- Removes the element on top of the stack.
top() -- Get the top element.
empty() -- Return whether the stack is empty.
Notes:
You must use only standard operations of a queue -- which means only push to back, peek/pop from front, size, and is empty operations are valid.
Depending on your language, queue may not be supported natively. You may simulate a queue by using a list or deque (double-ended queue), as long as you use only standard operations of a queue.
You may assume that all operations are valid (for example, no pop or top operations will be called on an empty stack).
Update (2015-06-11):
The class name of the Java function had been updated to MyStack instead of Stack.
*/






/////////////////////////////////////////////////////////////////////////////////////
//C++
class Stack {
    private:
    queue<int> q1;
public:
    // Push element x onto stack.
    void push(int x) {
        q1.push(x);
        for(int i = 1; i < q1.size(); ++i)  //i is start from 1
        {
            q1.push(q1.front());
            q1.pop();
        } 
    }

    // Removes the element on top of the stack.
    void pop() {
        q1.pop();
    }

    // Get the top element.
    int top() {
        return q1.front();
    }

    // Return whether the stack is empty.
    bool empty() {
        return q1.empty();
    }
};










/////////////////////////////////////////////////////////////////////////////////////
//Java
class MyStack {
    private Queue<Integer> q1 = new LinkedList<Integer>();
    
    // Push element x onto stack.
    public void push(int x) {
        q1.add(x);
        for(int i = 1; i < q1.size(); ++i){
            q1.add(q1.poll());
        }
    }

    // Removes the element on top of the stack.
    public void pop() {
        q1.poll();
    }

    // Get the top element.
    public int top() {
        return q1.peek();
    }

    // Return whether the stack is empty.
    public boolean empty() {
        return q1.isEmpty();
    }
}