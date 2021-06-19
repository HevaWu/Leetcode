/*
HTML entity parser is the parser that takes HTML code as input and replace all the entities of the special characters by the characters itself.

The special characters and their entities for HTML are:

Quotation Mark: the entity is &quot; and symbol character is ".
Single Quote Mark: the entity is &apos; and symbol character is '.
Ampersand: the entity is &amp; and symbol character is &.
Greater Than Sign: the entity is &gt; and symbol character is >.
Less Than Sign: the entity is &lt; and symbol character is <.
Slash: the entity is &frasl; and symbol character is /.
Given the input text string to the HTML parser, you have to implement the entity parser.

Return the text after replacing the entities by the special characters.



Example 1:

Input: text = "&amp; is an HTML entity but &ambassador; is not."
Output: "& is an HTML entity but &ambassador; is not."
Explanation: The parser will replace the &amp; entity by &
Example 2:

Input: text = "and I quote: &quot;...&quot;"
Output: "and I quote: \"...\""
Example 3:

Input: text = "Stay home! Practice on Leetcode :)"
Output: "Stay home! Practice on Leetcode :)"
Example 4:

Input: text = "x &gt; y &amp;&amp; x &lt; y is always false"
Output: "x > y && x < y is always false"
Example 5:

Input: text = "leetcode.com&frasl;problemset&frasl;all"
Output: "leetcode.com/problemset/all"


Constraints:

1 <= text.length <= 10^5
The string may contain any possible characters out of all the 256 ASCII characters.
*/

/*
Solution 1:
split + map

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func entityParser(_ text: String) -> String {
        var map = [String: String]()
        map["&quot"] = "\""
        map["&apos"] = "'"
        map["&amp"] = "&"
        map["&gt"] = ">"
        map["&lt"] = "<"
        map["&frasl"] = "/"

        var parsed = String()

        var substrings = text.split(separator: ";")
        let m = substrings.count
        // print(substrings)
        for i in 0..<m {
            let sub = substrings[i]
            if (i < m-1 || (i == m-1 && text.last == ";")),
            let last = sub.lastIndex(of: "&") {
                let key = String(sub[last...])
                if let val = map[key] {
                    parsed.append(contentsOf: sub[..<last])
                    parsed.append(val)
                    continue
                }
            }

            parsed.append(contentsOf: sub)
            if (i < m-1 || (i == m-1 && text.last == ";")) {
                // add separator
                parsed.append(";")
            }
        }

        return parsed
    }
}