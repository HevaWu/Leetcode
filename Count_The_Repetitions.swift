/*
We define str = [s, n] as the string str which consists of the string s concatenated n times.

For example, str == ["abc", 3] =="abcabcabc".
We define that string s1 can be obtained from string s2 if we can remove some characters from s2 such that it becomes s1.

For example, s1 = "abc" can be obtained from s2 = "abdbec" based on our definition by removing the bolded underlined characters.
You are given two strings s1 and s2 and two integers n1 and n2. You have the two strings str1 = [s1, n1] and str2 = [s2, n2].

Return the maximum integer m such that str = [str2, m] can be obtained from str1.



Example 1:

Input: s1 = "acb", n1 = 4, s2 = "ab", n2 = 2
Output: 2
Example 2:

Input: s1 = "acb", n1 = 1, s2 = "acb", n2 = 1
Output: 1


Constraints:

1 <= s1.length, s2.length <= 100
s1 and s2 consist of lowercase English letters.
1 <= n1, n2 <= 106
*/

/*
Solution 1:
find repetition pattern
calculate the sum of repeating pattern, part before repitition and part left after repitition as the result in O(1)

By Pigeonhole principle, which states that if nn items are put into mm containers, with n > mn>m, then at least one container must contain more than one item. So, according to this, we are sure to find 2 same index after scanning at max size(s2) blocks of s1.

- Intialize count=0 and index=0.
- Initialize 2 arrays, say indexr and countr of size (size(s2)+1), initialized with 0. The size (size(s2)+1) is based on the Pigeonhole principle as discussed above. The 2 arrays specifies the index and count at the start of each s1s1 block.
- Iterate over i from 0 to n1−1:
    - Iterate over j from 0 to size(s1)−1:
        - If s1[j]==s2[index], increment index.
        - If index is equal to size(s2), set index=0 and increment count.
    - Set countr[i]=count and indexr[i]=index
    - Iterate over k from 0 to i−1:
        - If we find the repitition, i.e. current index=indexr[k], we calculate the count for block before the repitition starts, the repeating block and the block left after repitition pattern, which can be calculated as:
        - prev_count=countr[k]
        - pattern_count=(countr[i]−countr[k])∗ (n1−1−k / i-k)
        - remain_count=countr[k+(n1−1−k)%(i−k)]−countr[k]​
        - Sum the 3 counts and return the sum divided by n2, since S2 = [s2,n2]
- If no repetition is found, return countr[n1-1]/n2.

Time Complexity: O(size1 * size2)
Space Complexity: O(size2)
*/
class Solution {
    func getMaxRepetitions(_ s1: String, _ n1: Int, _ s2: String, _ n2: Int) -> Int {
        var s1 = Array(s1)
        var s2 = Array(s2)
        let size1 = s1.count
        let size2 = s2.count

        // s2 index at start of each s1 block
        var indexArr = Array(repeating: 0, count: size2+1)
        var countArr = Array(repeating: 0, count: size2+1)

        // count of repititions of s2 in s1 till now
        var count = 0

        // index to search for in s2
        var index = 0

        for i in 0..<n1 {
            for j in 0..<size1 {
                if s1[j] == s2[index] {
                    index += 1
                }
                if index == size2 {
                    index = 0
                    count += 1
                }
            }

            countArr[i] = count
            indexArr[i] = index

            // print(countArr, indexArr, count, index)
            for k in 0..<i {
                if indexArr[k] == index {
                    // find repetition
                    let pre_count = countArr[k]
                    let pattern_count = (countArr[i] - countArr[k]) * ((n1 - 1 - k) / (i-k))
                    let remain_count = countArr[k + (n1-1-k) % (i-k)] - countArr[k]
                    return (pre_count + pattern_count + remain_count) / n2
                }
            }
        }

        return countArr[n1-1]/n2
    }
}
