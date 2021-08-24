/*
A complex number can be represented as a string on the form "real+imaginaryi" where:

real is the real part and is an integer in the range [-100, 100].
imaginary is the imaginary part and is an integer in the range [-100, 100].
i2 == -1.
Given two complex numbers num1 and num2 as strings, return a string of the complex number that represents their multiplications.



Example 1:

Input: num1 = "1+1i", num2 = "1+1i"
Output: "0+2i"
Explanation: (1 + i) * (1 + i) = 1 + i2 + 2 * i = 2i, and you need convert it to the form of 0+2i.
Example 2:

Input: num1 = "1+-1i", num2 = "1+-1i"
Output: "0+-2i"
Explanation: (1 - i) * (1 - i) = 1 + i2 - 2 * i = -2i, and you need convert it to the form of 0+-2i.


Constraints:

num1 and num2 are valid complex numbers.
*/

/*
Solution 1:
math

(r1 + i1 i) * (r2 + i2 i)
= r1 * r2 + (i1 * r2) i + (r1 * i2) i + (i1 * i2) i^2
= r1 * r2 + (i1 * r2) i + (r1 * i2) i - (i1 * i2)
= (r1 * r2 - i1 * i2) + (r1 * i2 + r2 * i1) i

Time Complexity: O(8)
Space Complexity: O(8)
*/
class Solution {
    func complexNumberMultiply(_ num1: String, _ num2: String) -> String {
        var arr_num1 = num1.split(separator: "+")
        var arr_num2 = num2.split(separator: "+")
        guard let r1 = Int(arr_num1[0]),
        let i1 = Int(arr_num1[1].dropLast()),
        let r2 = Int(arr_num2[0]),
        let i2 = Int(arr_num2[1].dropLast()) else {
            return String()
        }

        let r = r1 * r2 - i1 * i2
        let i = r2 * i1 + r1 * i2
        return "\(r)+\(i)i"
    }
}