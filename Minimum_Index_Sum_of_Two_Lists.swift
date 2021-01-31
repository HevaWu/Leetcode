/*
Suppose Andy and Doris want to choose a restaurant for dinner, and they both have a list of favorite restaurants represented by strings.

You need to help them find out their common interest with the least list index sum. If there is a choice tie between answers, output all of them with no order requirement. You could assume there always exists an answer.

 

Example 1:

Input: list1 = ["Shogun","Tapioca Express","Burger King","KFC"], list2 = ["Piatti","The Grill at Torrey Pines","Hungry Hunter Steakhouse","Shogun"]
Output: ["Shogun"]
Explanation: The only restaurant they both like is "Shogun".
Example 2:

Input: list1 = ["Shogun","Tapioca Express","Burger King","KFC"], list2 = ["KFC","Shogun","Burger King"]
Output: ["Shogun"]
Explanation: The restaurant they both like and have the least index sum is "Shogun" with index sum 1 (0+1).
Example 3:

Input: list1 = ["Shogun","Tapioca Express","Burger King","KFC"], list2 = ["KFC","Burger King","Tapioca Express","Shogun"]
Output: ["KFC","Burger King","Tapioca Express","Shogun"]
Example 4:

Input: list1 = ["Shogun","Tapioca Express","Burger King","KFC"], list2 = ["KNN","KFC","Burger King","Tapioca Express","Shogun"]
Output: ["KFC","Burger King","Tapioca Express","Shogun"]
Example 5:

Input: list1 = ["KFC"], list2 = ["KFC"]
Output: ["KFC"]
 

Constraints:

1 <= list1.length, list2.length <= 1000
1 <= list1[i].length, list2[i].length <= 30
list1[i] and list2[i] consist of spaces ' ' and English letters.
All the stings of list1 are unique.
All the stings of list2 are unique.
*/

/*
Solution 1:
hashMap

store element in map
- key is restaurant name
- val is index array, which contains where it appeared in each list

cur -> store current min sum index
have a storeInMap func
- for each (i,v) in list
  - if string v appears in other list before, val = map[v], 
    check if i+val[0] == cur, append v in res
	if i+val[0] < cur, reset res, and save cur = i+val[0]
  - if string v not appears before, save it to map, map[v] = [i]

Time Complexity: O(n+m), n is list1.count, m is list2.count
Space Complexity: O(t), t is common element in list1 and list2
*/
class Solution {
    func findRestaurant(_ list1: [String], _ list2: [String]) -> [String] {
        // key is restaurant name
        // value is index it appeared in list1 & list2
        var map = [String: [Int]]()
        
        var res = [String]()
        var cur = Int.max
        
        func storeInMap(_ list: [String]) {
            for (i, v) in list.enumerated() {
                if var val = map[v] {
                    // string v appears in other list before
                    let temp = val[0] + i
                    if temp == cur {
                        res.append(v)
                    } else if temp < cur {
                        // reset
                        res = [v]
                        cur = temp
                    }
                    
                    val.append(i)
                    map[v] = val
                } else {
                    // string not appear now
                    map[v] = [i]
                }
            }
        }
        
        storeInMap(list1)
        storeInMap(list2)
        
        return res
    }
}