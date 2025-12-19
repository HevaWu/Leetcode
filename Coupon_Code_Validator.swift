/*
You are given three arrays of length n that describe the properties of n coupons: code, businessLine, and isActive. The ith coupon has:

code[i]: a string representing the coupon identifier.
businessLine[i]: a string denoting the business category of the coupon.
isActive[i]: a boolean indicating whether the coupon is currently active.
A coupon is considered valid if all of the following conditions hold:

code[i] is non-empty and consists only of alphanumeric characters (a-z, A-Z, 0-9) and underscores (_).
businessLine[i] is one of the following four categories: "electronics", "grocery", "pharmacy", "restaurant".
isActive[i] is true.
Return an array of the codes of all valid coupons, sorted first by their businessLine in the order: "electronics", "grocery", "pharmacy", "restaurant", and then by code in lexicographical (ascending) order within each category.



Example 1:

Input: code = ["SAVE20","","PHARMA5","SAVE@20"], businessLine = ["restaurant","grocery","pharmacy","restaurant"], isActive = [true,true,true,true]

Output: ["PHARMA5","SAVE20"]

Explanation:

First coupon is valid.
Second coupon has empty code (invalid).
Third coupon is valid.
Fourth coupon has special character @ (invalid).
Example 2:

Input: code = ["GROCERY15","ELECTRONICS_50","DISCOUNT10"], businessLine = ["grocery","electronics","invalid"], isActive = [false,true,true]

Output: ["ELECTRONICS_50"]

Explanation:

First coupon is inactive (invalid).
Second coupon is valid.
Third coupon has invalid business line (invalid).


Constraints:

n == code.length == businessLine.length == isActive.length
1 <= n <= 100
0 <= code[i].length, businessLine[i].length <= 100
code[i] and businessLine[i] consist of printable ASCII characters.
isActive[i] is either true or false.
*/

/*
Solution 1:
Create a coupon class help building the algorithm

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Coupon {
    var code: String
    var business: String
    var isActive: Bool
    let validBusiness: [String : Int] = [
        "electronics": 1,
        "grocery": 2,
        "pharmacy": 3,
        "restaurant": 4
    ]

    // Pre-calculate the valid character set once when the class is initialized or accessed the first time
    static let validCharacterSet: Set<String> = {
        let lowerCaseCharArr: [String] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
        let upperCaseCharArr = lowerCaseCharArr.map { $0.uppercased() }
        let numArr: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "_"]
        return Set(lowerCaseCharArr + upperCaseCharArr + numArr)
    }()

    init(_ code: String, _ business: String, _ isActive: Bool) {
        self.code = code
        self.business = business
        self.isActive = isActive
    }

    func isValidCode() -> Bool {
        guard self.code.count > 0 else { return false}
        // Use the static, pre-calculated set for efficiency and correct syntax
        for c in self.code {
            if !Coupon.validCharacterSet.contains(String(c)) {
                return false
            }
        }
        return true
    }

    func isValidBusiness() -> Bool {
        return businessOrder() > 0
    }

    func isValid() -> Bool {
        return isValidCode() && isValidBusiness() && self.isActive
    }

    func businessOrder() -> Int {
        return validBusiness[self.business, default: 0]
    }
}

class Solution {
    func validateCoupons(_ code: [String], _ businessLine: [String], _ isActive: [Bool]) -> [String] {
        let n = code.count
        var coupons = [Coupon]()

        guard n == businessLine.count && n == isActive.count else {
            // Added basic validation that input arrays have the same count
            return []
        }

        for i in 0..<n {
            let coupon = Coupon(code[i], businessLine[i], isActive[i])
            if coupon.isValid() {
                coupons.append(coupon)
            }
        }

        coupons = coupons.sorted(by: { cou1, cou2 -> Bool in
            let order1 = cou1.businessOrder()
            let order2 = cou2.businessOrder()

            if order1 == order2 {
                // Sort codes in ascending order if business orders are the same
                return cou1.code < cou2.code
            } else {
                // Sort by business order in ascending order
                return order1 < order2
            }
        })

        // Return the codes as required by the function signature
        return coupons.map { $0.code }
    }
}
