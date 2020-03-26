// An abbreviation of a word follows the form <first letter><number><last letter>. Below are some examples of word abbreviations:

// a) it                      --> it    (no abbreviation)

//      1
//      ↓
// b) d|o|g                   --> d1g

//               1    1  1
//      1---5----0----5--8
//      ↓   ↓    ↓    ↓  ↓    
// c) i|nternationalizatio|n  --> i18n

//               1
//      1---5----0
//      ↓   ↓    ↓
// d) l|ocalizatio|n          --> l10n
// Assume you have a dictionary and given a word, find whether its abbreviation is unique in the dictionary. A word's abbreviation is unique if no other word from the dictionary has the same abbreviation.

// Example:

// Given dictionary = [ "deer", "door", "cake", "card" ]

// isUnique("dear") -> false
// isUnique("cart") -> true
// isUnique("cane") -> false
// isUnique("make") -> true

// Solution 1: 
// map to store the abbreviation 
// 
// Time complexity: 
// init: O(dictionaray.len)
// isUnique: O(1)
// Space complexity: O(n)
class ValidWordAbbr {
    var map = [String: Set<String>]()

    init(_ dictionary: [String]) {
        for word in dictionary {
            let abbr = getAbbr(word)
            map[abbr, default: Set<String>()].insert(word)
        }
    }
    
    func getAbbr(_ word: String) -> String {
        guard word.count >= 3 else { return word }
        return String(word.first!) + String(word.count-2) + String(word.last!)
    }
    
    func isUnique(_ word: String) -> Bool {
        let abbr = getAbbr(word)
        if let list = map[abbr] {
            return list.contains(word) && list.count == 1
        } else {
            return true
        }
    }
}

/**
 * Your ValidWordAbbr object will be instantiated and called as such:
 * let obj = ValidWordAbbr(dictionary)
 * let ret_1: Bool = obj.isUnique(word)
 */