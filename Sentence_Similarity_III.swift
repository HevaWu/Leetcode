/*
A sentence is a list of words that are separated by a single space with no leading or trailing spaces. For example, "Hello World", "HELLO", "hello world hello world" are all sentences. Words consist of only uppercase and lowercase English letters.

Two sentences sentence1 and sentence2 are similar if it is possible to insert an arbitrary sentence (possibly empty) inside one of these sentences such that the two sentences become equal. For example, sentence1 = "Hello my name is Jane" and sentence2 = "Hello Jane" can be made equal by inserting "my name is" between "Hello" and "Jane" in sentence2.

Given two sentences sentence1 and sentence2, return true if sentence1 and sentence2 are similar. Otherwise, return false.



Example 1:

Input: sentence1 = "My name is Haley", sentence2 = "My Haley"
Output: true
Explanation: sentence2 can be turned to sentence1 by inserting "name is" between "My" and "Haley".
Example 2:

Input: sentence1 = "of", sentence2 = "A lot of words"
Output: false
Explanation: No single sentence can be inserted inside one of the sentences to make it equal to the other.
Example 3:

Input: sentence1 = "Eating right now", sentence2 = "Eating"
Output: true
Explanation: sentence2 can be turned to sentence1 by inserting "right now" at the end of the sentence.
Example 4:

Input: sentence1 = "Luky", sentence2 = "Lucccky"
Output: false


Constraints:

1 <= sentence1.length, sentence2.length <= 100
sentence1 and sentence2 consist of lowercase and uppercase English letters and spaces.
The words in sentence1 and sentence2 are separated by a single space.

*/

/*
Solution 1:

keep n1 < n2
check diff

Time Complexity: O(n2)
Space Complexity: O(n2)
*/
class Solution {
    func areSentencesSimilar(_ sentence1: String, _ sentence2: String) -> Bool {
        var s1 = sentence1.split(separator: " ")
        var s2 = sentence2.split(separator: " ")

        var n1 = s1.count
        var n2 = s2.count

        if n1 == n2 { return sentence1 == sentence2 }

        // always keep n1 < n2
        if n1 > n2 {
            let temp = n1
            n1 = n2
            n2 = temp

            let stemp = s1
            s1 = s2
            s2 = stemp
        }

        var i1 = 0
        var i2 = 0
        var diff = -1
        while i1 < n1, i2 < n2 {
            if s1[i1] == s2[i2] {
                i1 += 1
                i2 += 1
            } else {
                if diff == -1 || diff == i2-1 {
                    diff = i2
                } else {
                    return false
                }

                i2 += 1
            }
        }

        if diff == -1 || (i1 == n1 && i2 == n2) {
            return true
        }

        return false
    }
}