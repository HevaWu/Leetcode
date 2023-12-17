/*
Design a food rating system that can do the following:

Modify the rating of a food item listed in the system.
Return the highest-rated food item for a type of cuisine in the system.
Implement the FoodRatings class:

FoodRatings(String[] foods, String[] cuisines, int[] ratings) Initializes the system. The food items are described by foods, cuisines and ratings, all of which have a length of n.
foods[i] is the name of the ith food,
cuisines[i] is the type of cuisine of the ith food, and
ratings[i] is the initial rating of the ith food.
void changeRating(String food, int newRating) Changes the rating of the food item with the name food.
String highestRated(String cuisine) Returns the name of the food item that has the highest rating for the given type of cuisine. If there is a tie, return the item with the lexicographically smaller name.
Note that a string x is lexicographically smaller than string y if x comes before y in dictionary order, that is, either x is a prefix of y, or if i is the first position such that x[i] != y[i], then x[i] comes before y[i] in alphabetic order.



Example 1:

Input
["FoodRatings", "highestRated", "highestRated", "changeRating", "highestRated", "changeRating", "highestRated"]
[[["kimchi", "miso", "sushi", "moussaka", "ramen", "bulgogi"], ["korean", "japanese", "japanese", "greek", "japanese", "korean"], [9, 12, 8, 15, 14, 7]], ["korean"], ["japanese"], ["sushi", 16], ["japanese"], ["ramen", 16], ["japanese"]]
Output
[null, "kimchi", "ramen", null, "sushi", null, "ramen"]

Explanation
FoodRatings foodRatings = new FoodRatings(["kimchi", "miso", "sushi", "moussaka", "ramen", "bulgogi"], ["korean", "japanese", "japanese", "greek", "japanese", "korean"], [9, 12, 8, 15, 14, 7]);
foodRatings.highestRated("korean"); // return "kimchi"
                                    // "kimchi" is the highest rated korean food with a rating of 9.
foodRatings.highestRated("japanese"); // return "ramen"
                                      // "ramen" is the highest rated japanese food with a rating of 14.
foodRatings.changeRating("sushi", 16); // "sushi" now has a rating of 16.
foodRatings.highestRated("japanese"); // return "sushi"
                                      // "sushi" is the highest rated japanese food with a rating of 16.
foodRatings.changeRating("ramen", 16); // "ramen" now has a rating of 16.
foodRatings.highestRated("japanese"); // return "ramen"
                                      // Both "sushi" and "ramen" have a rating of 16.
                                      // However, "ramen" is lexicographically smaller than "sushi".


Constraints:

1 <= n <= 2 * 104
n == foods.length == cuisines.length == ratings.length
1 <= foods[i].length, cuisines[i].length <= 10
foods[i], cuisines[i] consist of lowercase English letters.
1 <= ratings[i] <= 108
All the strings in foods are distinct.
food will be the name of a food item in the system across all calls to changeRating.
cuisine will be a type of cuisine of at least one food item in the system across all calls to highestRated.
At most 2 * 104 calls in total will be made to changeRating and highestRated.
*/

/*
Solution 1:
build index map for foods and cuisines
for cuisinesToIndex map, always keep the list sorted with the high rating order

Time Complexity:
- init: O(n + nlogn)
- changeRating: O(logn)
- highestRated: O(1)
Space Complexity: O(n)
*/
class FoodRatings {
    var foodToIndex = [String: Int]()
    var cursinesToIndex = [String: [Int]]()
    var foods = [String]()
    var cuisines = [String]()
    var ratings = [Int]()

    init(_ foods: [String], _ cuisines: [String], _ ratings: [Int]) {
        let n = foods.count
        self.foods = foods
        self.cuisines = cuisines
        self.ratings = ratings
        for i in 0..<n {
            foodToIndex[foods[i]] = i
            cursinesToIndex[cuisines[i], default: [Int]()].append(i)
        }

        // sort cursinesToIndex values to always put high rate first
        for c in cursinesToIndex.keys {
            guard let list = cursinesToIndex[c] else { continue }
            cursinesToIndex[c] = list.sorted(by: { index1, index2 -> Bool in
                return ratings[index1] == ratings[index2]
                ? foods[index1] < foods[index2]
                : ratings[index1] > ratings[index2]
            })
        }
    }

    func changeRating(_ food: String, _ newRating: Int) {
        guard let index = foodToIndex[food] else { return }
        let oldRating = ratings[index]
        ratings[index] = newRating

        let cursine = cuisines[index]
        guard var list = cursinesToIndex[cursine] else { return }
        removeEleFromList(&list, index, oldRating)
        addEleToList(&list, index, newRating)
        cursinesToIndex[cursine] = list
    }

    // remove index from list
    // use oldRating to help find the position in list
    func removeEleFromList(_ list: inout [Int], _ index: Int, _ oldRating: Int) {
        var l = 0
        var r = list.count-1
        if list[l] == index {
            list.remove(at: l)
            return
        }
        if list[r] == index {
            list.remove(at: r)
            return
        }
        while l < r {
            let mid = l + (r-l)/2
            if list[mid] == index {
                list.remove(at: mid)
                return
            }
            if (ratings[list[mid]] > oldRating)
            || ((ratings[list[mid]] == oldRating)
              && (foods[list[mid]] < foods[index])) {
                l = mid + 1
            } else {
                r = mid
            }
        }
    }

    func addEleToList(_ list: inout [Int], _ index: Int, _ newRating: Int) {
        if list.isEmpty {
            list.append(index)
            return
        }
        var l = 0
        var r = list.count-1
        while l < r {
            let mid = l + (r-l)/2
            if (ratings[list[mid]] > newRating)
            || ((ratings[list[mid]] == newRating)
              && (foods[list[mid]] < foods[index])) {
                l = mid + 1
            } else {
                r = mid
            }
        }
        let i = ((ratings[list[l]] > newRating)
            || ((ratings[list[l]] == newRating)
              && (foods[list[l]] < foods[index]))) ? l+1 : l
        list.insert(index, at: i)
    }

    func highestRated(_ cuisine: String) -> String {
        guard let list = cursinesToIndex[cuisine] else { return "" }
        return foods[list[0]]
    }
}

/**
 * Your FoodRatings object will be instantiated and called as such:
 * let obj = FoodRatings(foods, cuisines, ratings)
 * obj.changeRating(food, newRating)
 * let ret_2: String = obj.highestRated(cuisine)
 */
