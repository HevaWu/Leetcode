// Given two non-negative integers num1 and num2 represented as strings, return the product of num1 and num2, also represented as a string.

// Example 1:

// Input: num1 = "2", num2 = "3"
// Output: "6"
// Example 2:

// Input: num1 = "123", num2 = "456"
// Output: "56088"
// Note:

// The length of both num1 and num2 is < 110.
// Both num1 and num2 contain only digits 0-9.
// Both num1 and num2 do not contain any leading zero, except the number 0 itself.
// You must not use any built-in BigInteger library or convert the inputs to integer directly.

// Solution 1: Force String Multiply
// num1[i]*num2[j] will be placed at indices[i+1, i+j+1]
// for example;
// index 1		1 2 3   index i
// index 0		  4 5   index j
// -------------------------------
// 				  1 5
// 				1 0
// 			  0 5
// -------------------------------
// 			    1 2
// 			  0 8		indices[1, 2] = index [i+j, i+j+1]
// 			0 4
// -------------------------------
// indices	0 1 2 3 4
// 
// Time Complexity: O(mn)
// Space Complexity: O(m+n)
class Solution {
    func multiply(_ num1: String, _ num2: String) -> String {
        guard !num1.isEmpty, !num2.isEmpty else { return String() }
        guard num1 != "0", num2 != "0" else { return "0" }
        
        // init product digit first
        let count = max(num1.count, num2.count) + min(num1.count, num2.count)
        var product: [Int] = Array(repeating: 0, count: count)
        
        for (i, ivalue) in num1.enumerated().reversed() {
            for (j, jvalue) in num2.enumerated().reversed() {
                let tempij = Int(String(ivalue))! * Int(String(jvalue))!
                let p1 = i + j
                let p2 = i + j + 1
                let sum = tempij + product[p2]
                
                product[p2] = sum % 10
                product[p1] += sum / 10
            }
        }
        
        // convert int to string
        var productStr = String()
        for i in product {
            if productStr.isEmpty, i == 0 { continue }
            productStr.append(String(i))
        }
        return productStr
    }
}