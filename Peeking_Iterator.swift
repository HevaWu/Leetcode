/*
Given an Iterator class interface with methods: next() and hasNext(), design and implement a PeekingIterator that support the peek() operation -- it essentially peek() at the element that will be returned by the next call to next().

Example:

Assume that the iterator is initialized to the beginning of the list: [1,2,3].

Call next() gets you 1, the first element in the list.
Now you call peek() and it returns 2, the next element. Calling next() after that still return 2. 
You call next() the final time and it returns 3, the last element. 
Calling hasNext() after that should return false.
Follow up: How would you extend your design to be generic and work with all types, not just integer?

Hint 1:
Think of "looking ahead". You want to cache the next element.

Hint 2:
Is one variable sufficient? Why or why not?

Hint 3:
Test your design with call order of peek() before next() vs next() before peek().

Hint 4:
For a clean implementation, check out Google's guava library source code.
*/

/*
Solution 2:
optimize solution 1

only use 1 cache param

*/
// Swift IndexingIterator refernence:
// https://developer.apple.com/documentation/swift/indexingiterator

class PeekingIterator {
    var cache: Int?   
    var it: IndexingIterator<Array<Int>>
    
    init(_ arr: IndexingIterator<Array<Int>>) {
        it = arr
        cache = it.next()
    }
    
    func next() -> Int {
        defer {
            cache = it.next()
        }
        return cache!
    }
    
    func peek() -> Int {
        return cache!
    }
    
    func hasNext() -> Bool {
        return cache != nil
    }
}

/**
 * Your PeekingIterator object will be instantiated and called as such:
 * let obj = PeekingIterator(arr)
 * let ret_1: Int = obj.next()
 * let ret_2: Int = obj.peek()
 * let ret_3: Bool = obj.hasNext()
 */

/*
Solution 1:
use swift default IndexingIterator.next()

use hasCache and cache to hold if we've already called next()

Time Complexity: O(1)
Space Complexity: O(1)
*/
// Swift IndexingIterator refernence:
// https://developer.apple.com/documentation/swift/indexingiterator

class PeekingIterator {
    var hasCache = false
    var cache: Int?
    
    var it: IndexingIterator<Array<Int>>
    
    init(_ arr: IndexingIterator<Array<Int>>) {
        it = arr
        cache = 0
    }
    
    func next() -> Int {
        if hasCache {
            hasCache = false
            return cache ?? -1
        }
        
        return it.next() ?? -1
    }
    
    func peek() -> Int {
        if hasCache {
            return cache ?? -1
        }
        
        hasCache = true
        cache = it.next()
        return cache ?? -1
    }
    
    func hasNext() -> Bool {
        if hasCache {
            return cache != nil
        }
        
        hasCache = true
        cache = it.next()
        return cache != nil
    }
}

/**
 * Your PeekingIterator object will be instantiated and called as such:
 * let obj = PeekingIterator(arr)
 * let ret_1: Int = obj.next()
 * let ret_2: Int = obj.peek()
 * let ret_3: Bool = obj.hasNext()
 */
