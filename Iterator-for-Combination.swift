// Design an Iterator class, which has:

// A constructor that takes a string characters of sorted distinct lowercase English letters and a number combinationLength as arguments.
// A function next() that returns the next combination of length combinationLength in lexicographical order.
// A function hasNext() that returns True if and only if there exists a next combination.
 

// Example:

// CombinationIterator iterator = new CombinationIterator("abc", 2); // creates the iterator.

// iterator.next(); // returns "ab"
// iterator.hasNext(); // returns true
// iterator.next(); // returns "ac"
// iterator.hasNext(); // returns true
// iterator.next(); // returns "bc"
// iterator.hasNext(); // returns false
 

// Constraints:

// 1 <= combinationLength <= characters.length <= 15
// There will be at most 10^4 function calls per test.
// It's guaranteed that all calls of the function next are valid.


// Solution 1: 
// pust string into [Character], then use int array iterating method to search it
// use cur, start, end to help memo iterator position
// Time complexity:
// - init: O(n) n is character.count
// - next: O(size) size is combinationLength
// - hasNext: O(1)
class CombinationIterator {
    var charList: [Character]
    let n: Int
    let size: Int
    
    // memo iterator start, end, cur
    
    var start: [Int]
    // cur iterator index of charList, cur.count == size
    var cur: [Int]
    var end: [Int]

    init(_ characters: String, _ combinationLength: Int) {
        charList = characters.map { $0 }
        size = combinationLength
        start = Array(repeating: -1, count: size)
        cur = start
        
        n = charList.count
        end = Array(n-size..<n)
    }
    
    func next() -> String {
        let _next: String
        
        if cur == start {
            cur = Array(0..<size)
        } else {
            setNextIntArr()
        }
        _next = String(cur.map { charList[$0] })
        
        return _next
    }
    
    func setNextIntArr() {
        var index = size - 1
        while index >= 0 {
            if cur[index] != n-(size-index) {
                cur[index] = cur[index] + 1
                if index == size-1 {
                    return
                } else {
                    cur.replaceSubrange(index+1..<size, with: cur[index]+1..<cur[index]+(size-index))
                    return
                }
            }
            
            index -= 1
        }
    }
    
    func hasNext() -> Bool {
        return cur != end
    }
}

/**
 * Your CombinationIterator object will be instantiated and called as such:
 * let obj = CombinationIterator(characters, combinationLength)
 * let ret_1: String = obj.next()
 * let ret_2: Bool = obj.hasNext()
 */

/* Solution 2: 
 cache all possible result, then return next one by one
*/
lass CombinationIterator {

    var items:[String] = []
    var curr = 0
    
    init(_ characters: String, _ combinationLength: Int) {
        var arr = Array(characters)
        helper(arr, combinationLength, 0, "")
    }
    
    func helper(_ characters:[Character],_ k:Int,_ index:Int,_ current:String){
        if current.count == k{
            items.append(current)
            return
        }
        for i in index..<characters.count{
            if current.count < k {
                helper(characters, k, i+1, current+String(characters[i]))
            }
        }
    }
    
    func next() -> String {
        curr += 1
        return items[curr-1]
    }
    
    func hasNext() -> Bool {
        return curr < items.count
    }
}

/**
 * Your CombinationIterator object will be instantiated and called as such:
 * let obj = CombinationIterator(characters, combinationLength)
 * let ret_1: String = obj.next()
 * let ret_2: Bool = obj.hasNext()
 */
