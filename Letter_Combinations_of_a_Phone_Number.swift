/*
Given a string containing digits from 2-9 inclusive, return all possible letter combinations that the number could represent.

A mapping of digit to letters (just like on the telephone buttons) is given below. Note that 1 does not map to any letters.



Example:

Input: "23"
Output: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
Note:

Although the above answer is in lexicographical order, your answer could be in any order you want.
*/

/*
Solution 1: recursively add digit
//
Time complexity : \mathcal{O}(3^N \times 4^M)where N is the number of digits in the input that maps to 3 letters (e.g. 2, 3, 4, 5, 6, 8) and M is the number of digits in the input that maps to 4 letters (e.g. 7, 9), and N+M is the total number digits in the input.
Space complexity : \mathcal{O}(3^N \times 4^M)since one has to keep 3^N \times 4^Msolutions.
*/
class Solution3 {
    func letterCombinations(_ digits: String) -> [String] {
        guard !digits.isEmpty else { return [String]() }
        var digits = Array(digits)

        var comb = [String]()
        for digit in digits {
            var list = [String]()
            switch digit {
            case "2":
                list = ["a", "b", "c"]
            case "3":
                list = ["d", "e", "f"]
            case "4":
                list = ["g", "h", "i"]
            case "5":
                list = ["j", "k", "l"]
            case "6":
                list = ["m", "n", "o"]
            case "7":
                list = ["p", "q", "r", "s"]
            case "8":
                list = ["t", "u", "v"]
            case "9":
                list = ["w", "x", "y", "z"]
            default :
                continue
            }
            append(list, in: &comb)
        }
        return comb
    }

    func append(_ list: [String], in comb: inout [String]) {
        guard !comb.isEmpty else {
            comb = list
            return
        }

        var temp = comb
        comb = [String]()
        for c in list {
            for str in temp {
                comb.append(str + c)
            }
        }
    }
}



class Solution2 {
    var map: [Character: String] = [
        "2": "abc",
        "3": "def",
        "4": "ghi",
        "5": "jkl",
        "6": "mno",
        "7": "pqrs",
        "8": "tuv",
        "9": "wxyz"
    ]
    var comb = [String]()

    func letterCombinations(_ digits: String) -> [String] {
        guard !digits.isEmpty else { return [String]() }
        var digits = Array(digits)
        backtrack("", digits)
        return comb
    }

    private func backtrack(_ temp: String, _ digits: [Character]) {
        guard digits.count > 0 else {
            comb.append(temp)
            return
        }

        if let list = map[digits[0]] {
            for c in list {
                backtrack(temp+String(c), Array(digits[1...]))
            }
        }
    }
}

/*
optimize
*/
class Solution1 {
    var map: [Character: String] = [
        "2": "abc",
        "3": "def",
        "4": "ghi",
        "5": "jkl",
        "6": "mno",
        "7": "pqrs",
        "8": "tuv",
        "9": "wxyz"
    ]
    var comb = [String]()

    func letterCombinations(_ digits: String) -> [String] {
        guard !digits.isEmpty else { return [String]() }
        var digits = Array(digits)
        backtrack("", digits)
        return comb
    }

    private func backtrack(_ temp: String, _ digits: [Character]) {
        if digits.count == 0 {
            comb.append(temp)
            return
        }

        for c in map[digits[0]]! {
            backtrack(temp+String(c), Array(digits[1...]))
        }
    }
}

/*
Solution 4:
keep code cleaner

Time Complexity: O(3^n)
Space Complexity: O(n)
*/
class Solution4 {
    func letterCombinations(_ digits: String) -> [String] {
        if digits.isEmpty { return [] }

        let map: [Character: [Character]] = [
            "2": ["a", "b", "c"],
            "3": ["d", "e", "f"],
            "4": ["g", "h", "i"],
            "5": ["j", "k", "l"],
            "6": ["m", "n", "o"],
            "7": ["p", "q", "r", "s"],
            "8": ["t", "u", "v"],
            "9": ["w", "x", "y", "z"]
        ]

        let n = digits.count
        var digits = Array(digits)
        var res = [String]()
        var cur = String()
        backTrack(digits, 0, n, map, &cur, &res)
        return res
    }

    func backTrack(_ digits: [Character], _ index: Int, _ n: Int,
                   _ map: [Character: [Character]],
                   _ cur: inout String, _ res: inout [String]) {
        if index == n {
            res.append(cur)
            return
        }

        guard let list = map[digits[index]] else { return }
        for c in list {
            cur.append(c)
            backTrack(digits, index+1, n, map, &cur, &res)
            cur.removeLast()
        }
    }
}