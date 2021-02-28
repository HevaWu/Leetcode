/*
Implement FreqStack, a class which simulates the operation of a stack-like data structure.

FreqStack has two functions:

push(int x), which pushes an integer x onto the stack.
pop(), which removes and returns the most frequent element in the stack.
If there is a tie for most frequent element, the element closest to the top of the stack is removed and returned.
 

Example 1:

Input: 
["FreqStack","push","push","push","push","push","push","pop","pop","pop","pop"],
[[],[5],[7],[5],[7],[4],[5],[],[],[],[]]
Output: [null,null,null,null,null,null,null,5,7,5,4]
Explanation:
After making six .push operations, the stack is [5,7,5,7,4,5] from bottom to top.  Then:

pop() -> returns 5, as 5 is the most frequent.
The stack becomes [5,7,5,7,4].

pop() -> returns 7, as 5 and 7 is the most frequent, but 7 is closest to the top.
The stack becomes [5,7,5,4].

pop() -> returns 5.
The stack becomes [5,7,4].

pop() -> returns 4.
The stack becomes [5,7].
 

Note:

Calls to FreqStack.push(int x) will be such that 0 <= x <= 10^9.
It is guaranteed that FreqStack.pop() won't be called if the stack has zero elements.
The total number of FreqStack.push calls will not exceed 10000 in a single test case.
The total number of FreqStack.pop calls will not exceed 10000 in a single test case.
The total number of FreqStack.push and FreqStack.pop calls will not exceed 150000 across all test cases.

*/

/*
Solution 2:
optimize solution 1 pop()
*/
class FreqStack {
    // key is ele, val is freq
    var map = [Int: Int]()
    
    // key is freq, val is same freq element list
    var freqMap = [Int: [Int]]()
    var maxFreq = 0

    init() {
        
    }
    
    func push(_ x: Int) {
        map[x, default: 0] += 1
        
        let freq = map[x]!
        freqMap[freq, default: [Int]()].append(x)
        maxFreq = max(maxFreq, freq)
    }
    
    func pop() -> Int {
        let top = freqMap[maxFreq]!.removeLast()
        map[top]! -= 1
        if freqMap[maxFreq]!.isEmpty {
            maxFreq -= 1
        }
        
        return top
    }
}

/**
 * Your FreqStack object will be instantiated and called as such:
 * let obj = FreqStack()
 * obj.push(x)
 * let ret_2: Int = obj.pop()
 */

/*
Solution 1: 
2 map and 1 maxFreq to record elements
- map: for checking element frequency
- freqMap: key is freq, val is element list of same frequency
- maxFreq: maximum key of freqMap

ex: 5,7,5,7,4,5
- push 5: map[5]=1, freq[1]=[5], maxFreq=1
- push 7: map[7]=1, freq[1]=[5,7], maxFreq=1
- push 5: map[5]=2, freq[2]=[5], maxFreq=2
- push 7: map[7]=2, freq[2]=[5,7], maxFreq=2
- push 4: map[4]=1, freq[1]=[5,7,4], maxFreq=2
- push 5: map[5]=3, freq[3]=[5], maxFreq=3
- pop: maxFreq=3 => find freq[3], top 5, freq[3] should be empty now => maxFreq=2
- pop: maxFreq=2 => find freq[2]=[5,7], top 7 => freq[2]=[5], maxFreq=2
- pop: maxFreq=2 => find freq[2]=[5], top 5, freq[2] should be empty now => maxFreq=1
- pop: maxFreq=1 => find freq[1]=[5,7,4], top 4 => freq[1]=[5,7], maxFre=1
...

Time Complexity: 
- pushed: O(1)
- pop: O(1)

Space Complexity: O(n)
*/
class FreqStack {
    // key is ele, val is freq
    var map = [Int: Int]()
    
    // key is freq, val is same freq element list
    var freqMap = [Int: [Int]]()
    var maxFreq = 0

    init() {
        
    }
    
    func push(_ x: Int) {
        map[x, default: 0] += 1
        
        let freq = map[x]!
        freqMap[freq, default: [Int]()].append(x)
        maxFreq = max(maxFreq, freq)
    }
    
    func pop() -> Int {
        if var list = freqMap[maxFreq] {
            let top = list.removeLast()
            
            if list.isEmpty {
                freqMap[maxFreq] = nil
                maxFreq -= 1
            } else {
                freqMap[maxFreq] = list
            }
            
            map[top]! -= 1
            return top
        }
        
        return -1
    }
}

/**
 * Your FreqStack object will be instantiated and called as such:
 * let obj = FreqStack()
 * obj.push(x)
 * let ret_2: Int = obj.pop()
 */