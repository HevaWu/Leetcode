/*
Design an Iterator class, which has:

A constructor that takes a string characters of sorted distinct lowercase English letters and a number combinationLength as arguments.
A function next() that returns the next combination of length combinationLength in lexicographical order.
A function hasNext() that returns True if and only if there exists a next combination.


Example:

CombinationIterator iterator = new CombinationIterator("abc", 2); creates the iterator.

iterator.next(); returns "ab"
iterator.hasNext(); returns true
iterator.next(); returns "ac"
iterator.hasNext(); returns true
iterator.next(); returns "bc"
iterator.hasNext(); returns false


Constraints:

1 <= combinationLength <= characters.length <= 15
There will be at most 10^4 function calls per test.
It's guaranteed that all calls of the function next are valid.
*/

/*
Solution 3:
bitmask  + backtracking

bitmask to cache all finded combinations
then iterate them

Time Complexity: O(2^n)
Space Complexity: O(A(n, size))
*/
class CombinationIterator {
    String characters;
    int size;

    List<Integer> cache = new ArrayList<>();
    int cur = 0;

    public CombinationIterator(String characters, int combinationLength) {
        this.characters = characters;
        this.size = combinationLength;

        helper(0, this.size, 0, characters.length());
    }

    public void helper(int index, int remain, int mask, int n) {
        if (remain == 0) {
            cache.add(mask);
            return;
        }

        if (n-index < remain) {
            return;
        }

        // pick index one
        helper(index+1, remain-1, mask | (1 << index), n);

        // not pick index one
        helper(index+1, remain, mask, n);
    }

    public String next() {
        int mask = cache.get(cur);
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i <= 15; i++) {
            if ((mask & (1 << i)) != 0) {
                builder.append(characters.charAt(i));
            }
        }

        cur += 1;
        return builder.toString();
    }

    public boolean hasNext() {
        return cur < cache.size() ;
    }
}

/**
 * Your CombinationIterator object will be instantiated and called as such:
 * CombinationIterator obj = new CombinationIterator(characters, combinationLength);
 * String param_1 = obj.next();
 * boolean param_2 = obj.hasNext();
 */