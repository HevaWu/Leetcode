// Every email consists of a local name and a domain name, separated by the @ sign.

// For example, in alice@leetcode.com, alice is the local name, and leetcode.com is the domain name.

// Besides lowercase letters, these emails may contain '.'s or '+'s.

// If you add periods ('.') between some characters in the local name part of an email address, mail sent there will be forwarded to the same address without dots in the local name.  For example, "alice.z@leetcode.com" and "alicez@leetcode.com" forward to the same email address.  (Note that this rule does not apply for domain names.)

// If you add a plus ('+') in the local name, everything after the first plus sign will be ignored. This allows certain emails to be filtered, for example m.y+name@email.com will be forwarded to my@email.com.  (Again, this rule does not apply for domain names.)

// It is possible to use both of these rules at the same time.

// Given a list of emails, we send one email to each address in the list.  How many different addresses actually receive mails? 

 

// Example 1:

// Input: ["test.email+alex@leetcode.com","test.e.mail+bob.cathy@leetcode.com","testemail+david@lee.tcode.com"]
// Output: 2
// Explanation: "testemail@leetcode.com" and "testemail@lee.tcode.com" actually receive mails
 

// Note:

// 1 <= emails[i].length <= 100
// 1 <= emails.length <= 100
// Each emails[i] contains exactly one '@' character.
// All local and domain names are non-empty.
// Local names do not start with a '+' character.

// Solution 1: String replace
// 
// Time complexity: O(mn), n is emails length, m is largest email address length
// Space complexity: O(n)
class Solution {
    func numUniqueEmails(_ emails: [String]) -> Int {
        var set = Set<String>()
        for email in emails {
            set.insert(getAddress(from: email))
        }
        return set.count
    }
    
    func getAddress(from email: String) -> String {
        guard let splitIndex = email.firstIndex(of: "@") else { return "" }
        var local = String(email[email.startIndex..<splitIndex])
        var domain = String(email[email.index(after: splitIndex)..<email.endIndex])
        
        // remove "." in local name
        local = local.replacingOccurrences(of: ".", with: "")
        
        // ignore character after +
        if let plusIndex = local.firstIndex(of: "+") {
            local = String(local[local.startIndex..<plusIndex])
        }
        
        return local+"2"+domain
    }
}

class Solution {
    func numUniqueEmails(_ emails: [String]) -> Int {
        var set = Set<String>()
        for email in emails {
            set.insert(getAddress(email))
        }
        return set.count
    }
    
    func getAddress(_ email: String) -> String {
        var address = String()
        var index = email.startIndex
        while index < email.endIndex {
            if email[index] == "@" {
                address.append(String(email[index..<email.endIndex]))
                break
            } else if email[index] == "+" {
                while email[index] != "@" {
                    index = email.index(after: index)
                }
            } else if email[index] == "." {
                index = email.index(after: index)
            } else {
                address.append(email[index])
                index = email.index(after: index)
            }
        }
        return address
    }
}