/*246. Strobogrammatic Number  QuestionEditorial Solution  My Submissions
Total Accepted: 15519 Total Submissions: 40913 Difficulty: Easy
A strobogrammatic number is a number that looks the same when rotated 180 degrees (looked at upside down).

Write a function to determine if a number is strobogrammatic. The number is represented as a string.

For example, the numbers "69", "88", and "818" are all strobogrammatic.

Hide Company Tags Google
Hide Tags Hash Table Math
Hide Similar Problems (M) Strobogrammatic Number II (H) Strobogrammatic Number III
*/



/*
0 --- 0
1 --- 1
6 --- 9
8 --- 8
9 --- 6
only these situations, use a hashmap to store them
i start from 0, j start from size-1
check if the number is in these situations 
		or in the situations but not equal to each other
		if not return false
else return true*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    bool isStrobogrammatic(string num) {
        unordered_map<char, char> mymap{
            {'0','0'},{'1','1'},{'6','9'},{'8','8'},{'9','6'}};
        for(int i = 0, j = num.size()-1; i <= j; ++i, --j){
            if(mymap.find(num[i])==mymap.end()
                || mymap[num[i]] != num[j]){
                    return false;
                }
        }
        return true;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public boolean isStrobogrammatic(String num) {
        for(int i = 0, j = num.length()-1; i <= j; ++i,--j){
            if(! "00 11 88 696".contains(num.charAt(i)+""+num.charAt(j))){
                return false;
            }
        }
        return true;
    }
}
