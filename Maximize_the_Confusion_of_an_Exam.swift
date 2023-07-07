/*
A teacher is writing a test with n true/false questions, with 'T' denoting true and 'F' denoting false. He wants to confuse the students by maximizing the number of consecutive questions with the same answer (multiple trues or multiple falses in a row).

You are given a string answerKey, where answerKey[i] is the original answer to the ith question. In addition, you are given an integer k, the maximum number of times you may perform the following operation:

Change the answer key for any question to 'T' or 'F' (i.e., set answerKey[i] to 'T' or 'F').
Return the maximum number of consecutive 'T's or 'F's in the answer key after performing the operation at most k times.



Example 1:

Input: answerKey = "TTFF", k = 2
Output: 4
Explanation: We can replace both the 'F's with 'T's to make answerKey = "TTTT".
There are four consecutive 'T's.
Example 2:

Input: answerKey = "TFFT", k = 1
Output: 3
Explanation: We can replace the first 'T' with an 'F' to make answerKey = "FFFT".
Alternatively, we can replace the second 'T' with an 'F' to make answerKey = "TFFF".
In both cases, there are three consecutive 'F's.
Example 3:

Input: answerKey = "TTFTTFTT", k = 1
Output: 5
Explanation: We can replace the first 'F' to make answerKey = "TTTTTFTT"
Alternatively, we can replace the second 'F' to make answerKey = "TTFTTTTT".
In both cases, there are five consecutive 'T's.


Constraints:

n == answerKey.length
1 <= n <= 5 * 104
answerKey[i] is either 'T' or 'F'
1 <= k <= n
*/

/*
Solution 1:
Two pointer find the max consecutive char between i,j

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func maxConsecutiveAnswers(_ answerKey: String, _ k: Int) -> Int {
        var res = 0
        var answerKey = Array(answerKey)
        let n = answerKey.count

        var T = 0
        var F = 0
        var cur = 0
        var i = 0
        var j = 0
        while j < n {
            if answerKey[j] == "T" {
                T += 1
            } else {
                F += 1
            }

            while min(T, F) > k {
                if answerKey[i] == "T" {
                    T -= 1
                } else {
                    F -= 1
                }
                i += 1
            }
            res = max(res, (j-i+1))
            j += 1
        }

        return res
    }
}
