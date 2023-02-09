/*
You are given an array of strings ideas that represents a list of names to be used in the process of naming a company. The process of naming a company is as follows:

Choose 2 distinct names from ideas, call them ideaA and ideaB.
Swap the first letters of ideaA and ideaB with each other.
If both of the new names are not found in the original ideas, then the name ideaA ideaB (the concatenation of ideaA and ideaB, separated by a space) is a valid company name.
Otherwise, it is not a valid name.
Return the number of distinct valid names for the company.



Example 1:

Input: ideas = ["coffee","donuts","time","toffee"]
Output: 6
Explanation: The following selections are valid:
- ("coffee", "donuts"): The company name created is "doffee conuts".
- ("donuts", "coffee"): The company name created is "conuts doffee".
- ("donuts", "time"): The company name created is "tonuts dime".
- ("donuts", "toffee"): The company name created is "tonuts doffee".
- ("time", "donuts"): The company name created is "dime tonuts".
- ("toffee", "donuts"): The company name created is "doffee tonuts".
Therefore, there are a total of 6 distinct company names.

The following are some examples of invalid selections:
- ("coffee", "time"): The name "toffee" formed after swapping already exists in the original array.
- ("time", "toffee"): Both names are still the same after swapping and exist in the original array.
- ("coffee", "toffee"): Both names formed after swapping already exist in the original array.
Example 2:

Input: ideas = ["lack","back"]
Output: 0
Explanation: There are no valid selections. Therefore, 0 is returned.


Constraints:

2 <= ideas.length <= 5 * 104
1 <= ideas[i].length <= 10
ideas[i] consists of lowercase English letters.
All the strings in ideas are unique.
*/

/*
Solution 1:
build initial set array,
initial[i] is Set of pending string of current initial character

calculate distinct by check if two initials have mutual pending string or not
Not calculate mutual pending string into distinct names

Time Complexity: O(26 * 26 * n)
Space Complexity: O(26 * n)
*/
class Solution {
    func distinctNames(_ ideas: [String]) -> Int {
        let asciia = Character("a").asciiValue!
        var initial = Array(repeating: Set<String>(), count: 26)
        for idea in ideas {
            let index = Int(idea.first!.asciiValue! - asciia)
            initial[index].insert(String(idea[(idea.index(idea.startIndex, offsetBy: 1))...]))
        }

        var distinct = 0
        for i in 0..<25 {
            for j in (i+1)..<26 {
                var mutual = 0
                for str in initial[i] {
                    if initial[j].contains(str) {
                        mutual += 1
                    }
                }
                distinct += 2 * (initial[i].count-mutual) * (initial[j].count-mutual)
            }
        }
        return distinct
    }
}
