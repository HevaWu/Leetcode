// Write an iterator that iterates through a run-length encoded sequence.

// The iterator is initialized by RLEIterator(int[] A), where A is a run-length encoding of some sequence.  More specifically, for all even i, A[i] tells us the number of times that the non-negative integer value A[i+1] is repeated in the sequence.

// The iterator supports one function: next(int n), which exhausts the next n elements (n >= 1) and returns the last element exhausted in this way.  If there is no element left to exhaust, next returns -1 instead.

// For example, we start with A = [3,8,0,9,2,5], which is a run-length encoding of the sequence [8,8,8,5,5].  This is because the sequence can be read as "three eights, zero nines, two fives".

 

// Example 1:

// Input: ["RLEIterator","next","next","next","next"], [[[3,8,0,9,2,5]],[2],[1],[1],[2]]
// Output: [null,8,8,5,-1]
// Explanation: 
// RLEIterator is initialized with RLEIterator([3,8,0,9,2,5]).
// This maps to the sequence [8,8,8,5,5].
// RLEIterator.next is then called 4 times:

// .next(2) exhausts 2 terms of the sequence, returning 8.  The remaining sequence is now [8, 5, 5].

// .next(1) exhausts 1 term of the sequence, returning 8.  The remaining sequence is now [5, 5].

// .next(1) exhausts 1 term of the sequence, returning 5.  The remaining sequence is now [5].

// .next(2) exhausts 2 terms, returning -1.  This is because the first term exhausted was 5,
// but the second term did not exist.  Since the last term exhausted does not exist, we return -1.

// Note:

// 0 <= A.length <= 1000
// A.length is an even integer.
// 0 <= A[i] <= 10^9
// There are at most 1000 calls to RLEIterator.next(int n) per test case.
// Each call to RLEIterator.next(int n) will have 1 <= n <= 10^9.

// Solution 1: force
// use array to save A
// 
// Time complexity: O(A.count)
// Space complexity: O(10^9^2)
class RLEIterator {
    var arr = [Int]()
    
    init(_ A: [Int]) {
        var i = 0
        while i < A.count-1 {
            arr.append(contentsOf: Array(repeating: A[i+1], count: A[i]))
            i += 2
        }    
    }
    
    func next(_ n: Int) -> Int {
        guard n <= arr.count else { 
            // reset arr if iterator to the end
            arr = [Int]()
            return -1 
        }
        var value = arr[n-1]
        arr = Array(arr[n...])
        return value
    }
}

/**
 * Your RLEIterator object will be instantiated and called as such:
 * let obj = RLEIterator(A)
 * let ret_1: Int = obj.next(n)
 */

//  Solution 2: index & quantity
// We can store an index i and quantity q which represents that q elements of A[i] (repeated A[i+1] times) are exhausted.
// For example, if we have A = [1,2,3,4] (mapping to the sequence [2,4,4,4]) then i = 0, q = 0 represents that nothing is exhausted; i = 0, q = 1 represents that [2] is exhausted, i = 2, q = 1 will represent that we have currently exhausted [2, 4], and so on.
// 
// Algorithm
// Say we want to exhaust n more elements. There are currently D = A[i] - q elements left to exhaust (of value A[i+1]).
// If n > D, then we should exhaust all of them and continue: n -= D; i += 2; q = 0.
// Otherwise, we should exhaust some of them and return the current element's value: q += D; return A[i+1].
// 
// Time complexity:
// - init: O(1)
// - next: O(N+Q)
// Time Complexity: O(N + Q)O(N+Q), where NN is the length of A, and QQ is the number of calls to RLEIterator.next.
// Space Complexity: O(N)O(N).
class RLEIterator {
    var A = [Int]()
    var index = 0
    var quantity = 0
    
    init(_ A: [Int]) {
        self.A = A    
    }
    
    func next(_ n: Int) -> Int {
        var n = n
        while index < A.count {
            if quantity + n > A[index] {
                n -= (A[index] - quantity)
                quantity = 0
                index += 2
            } else {
                quantity += n
                return A[index + 1]
            }
        }
        return -1
    }
}

/**
 * Your RLEIterator object will be instantiated and called as such:
 * let obj = RLEIterator(A)
 * let ret_1: Int = obj.next(n)
 */