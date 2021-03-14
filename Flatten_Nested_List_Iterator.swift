/*
Given a nested list of integers, implement an iterator to flatten it.

Each element is either an integer, or a list -- whose elements may also be integers or other lists.

Example 1:

Input: [[1,1],2,[1,1]]
Output: [1,1,2,1,1]
Explanation: By calling next repeatedly until hasNext returns false, 
             the order of elements returned by next should be: [1,1,2,1,1].
Example 2:

Input: [1,[4,[6]]]
Output: [1,4,6]
Explanation: By calling next repeatedly until hasNext returns false, 
             the order of elements returned by next should be: [1,4,6].
*/

/*
Solution 1:

- stack: iterator stack
- nextEle: next element
- cacheNext: 
  - true if this nextEle is NOT been called by next(), 
  - false if this nextEle is not set yet OR has already popped in next() function

- next()
  - use hasNext() to find correct nextEle first, then return and set cacheNext = false
- hasNext()
  - check cacheNext, if cacheNext is false, checking stack
  - if stack.removeLast().next() has _next element
    - stack append latest iterator
	- if _next is integer, update nextEle and return true
	- if _next is list, stack.append(_next list iterator)
  - return false

Time Complexity:
- init(): O(1)
- next(): O(1)
- hasNext(): O(1)

Space Complexity: O(size of deepest nested NestedInteger list)
- [[[[1,2],3],4],5] -> O(4)
*/
/**
 * // This is the interface that allows for creating nested lists.
 * // You should not implement it, or speculate about its implementation
 * class NestedInteger {
 *     // Return true if this NestedInteger holds a single integer, rather than a nested list.
 *     public func isInteger() -> Bool
 *
 *     // Return the single integer that this NestedInteger holds, if it holds a single integer
 *     // The result is undefined if this NestedInteger holds a nested list
 *     public func getInteger() -> Int
 *
 *     // Set this NestedInteger to hold a single integer.
 *     public func setInteger(value: Int)
 *
 *     // Set this NestedInteger to hold a nested list and adds a nested integer to it.
 *     public func add(elem: NestedInteger)
 *
 *     // Return the nested list that this NestedInteger holds, if it holds a nested list
 *     // The result is undefined if this NestedInteger holds a single integer
 *     public func getList() -> [NestedInteger]
 * }
 */

class NestedIterator {
    var stack = [IndexingIterator<[NestedInteger]>]()
    var nextEle: Int? = nil
    
    // flag help checking if hasNext()'s nextEle has already been called in next()
    var cacheNext = false

    init(_ nestedList: [NestedInteger]) {
        stack.append(nestedList.makeIterator())
    }
    
    func next() -> Int {
        hasNext()
        cacheNext = false
        return nextEle ?? -1
    }
    
    func hasNext() -> Bool {
        if cacheNext {
            return nextEle == nil
        }
        
        cacheNext = true
        while !stack.isEmpty {
            var cur = stack.removeLast()
            if let _next = cur.next() {
                stack.append(cur)
                
                if _next.isInteger() {
                    nextEle = _next.getInteger()
                    return true
                }
                // _next is a list
                stack.append(_next.getList().makeIterator())
            }
        }
        return false
    }
}

/**
 * Your NestedIterator object will be instantiated and called as such:
 * let obj = NestedIterator(nestedList)
 * let ret_1: Int = obj.next()
 * let ret_2: Bool = obj.hasNext()
 */