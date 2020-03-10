// Given a chemical formula (given as a string), return the count of each atom.

// An atomic element always starts with an uppercase character, then zero or more lowercase letters, representing the name.

// 1 or more digits representing the count of that element may follow if the count is greater than 1. If the count is 1, no digits will follow. For example, H2O and H2O2 are possible, but H1O2 is impossible.

// Two formulas concatenated together produce another formula. For example, H2O2He3Mg4 is also a formula.

// A formula placed in parentheses, and a count (optionally added) is also a formula. For example, (H2O2) and (H2O2)3 are formulas.

// Given a formula, output the count of all elements as a string in the following form: the first name (in sorted order), followed by its count (if that count is more than 1), followed by the second name (in sorted order), followed by its count (if that count is more than 1), and so on.

// Example 1:
// Input: 
// formula = "H2O"
// Output: "H2O"
// Explanation: 
// The count of elements are {'H': 2, 'O': 1}.
// Example 2:
// Input: 
// formula = "Mg(OH)2"
// Output: "H2MgO2"
// Explanation: 
// The count of elements are {'H': 2, 'Mg': 1, 'O': 2}.
// Example 3:
// Input: 
// formula = "K4(ON(SO3)2)2"
// Output: "K4N2O14S4"
// Explanation: 
// The count of elements are {'K': 4, 'N': 2, 'O': 14, 'S': 4}.
// Note:

// All atom names consist of lowercase letters, except for the first character which is uppercase.
// The length of formula will be in the range [1, 1000].
// formula will only consist of letters, digits, and round parentheses, and is a valid formula as defined in the problem.

// hint
// To parse formula[i:], when we see a `'('`, we will parse recursively whatever is inside the brackets (up to the correct closing ending bracket) and add it to our count, multiplying by the following multiplicity if there is one. Otherwise, we should see an uppercase character: we will parse the rest of the letters to get the name, and add that (plus the multiplicity if there is one.)

// Solution 1: stack
// stack to save each step map
// then check the (, ), and normal case one by one
// 
// Time Complexity: O(N^2) where NN is the length of the formula. It is O(N)O(N) to parse through the formula, but each of O(N)O(N) multiplicities after a bracket may increment the count of each name in the formula (inside those brackets), leading to an O(N^2) complexity.
// Space Complexity: O(N)O(N). We aren't recording more intermediate information than what is contained in the formula.
class Solution {
    func countOfAtoms(_ formula: String) -> String {
        guard !formula.isEmpty else { return String() }
        var stack = [[String: Int]]()
        var map = [String: Int]()
        
        var index = 0
        var formula = Array(formula)
        let n = formula.count
        while index < n {
            let char = formula[index]
            index += 1
            
            if char == "(" {
                stack.append(map)
                map = [String: Int]()
            } else if char == ")" {
                // get number
                var num = 0
                while index < n, formula[index].isNumber {
                    num = num*10 + formula[index].wholeNumberValue!
                    index += 1
                }
                
                // put into map, if no number append, this count should be 1
                if num == 0 { num = 1 }
                
                // combine map
                if !stack.isEmpty {
                    var temp = map
                    map = stack.removeLast()
                    for k in temp.keys {
                        map[k, default: 0] += temp[k]! * num
                    }
                }
            } else {
                var start = index - 1
                
                // find lowercase character
                while index < n, formula[index].isLowercase {
                    index += 1
                }
                var str = String(formula[start..<index])
                
                // find number
                var num = 0
                start = index
                while index < n, formula[index].isNumber {
                    num = num * 10 + formula[index].wholeNumberValue!
                    index += 1
                }
                if num == 0 { num = 1 }
                
                // combine map
                map[str, default: 0] += num
            }
        }
        
        // get final output
        var output = String()
        for k in map.keys.sorted() {
            output.append(k)
            if map[k]! > 1 { output.append(String(map[k]!)) }
        }
        return output
    }
}
