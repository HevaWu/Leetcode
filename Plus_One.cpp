/*66. Plus One  QuestionEditorial Solution  My Submissions
Total Accepted: 125667
Total Submissions: 350729
Difficulty: Easy
Given a non-negative number represented as an array of digits, plus one to the number.

The digits are stored such that the most significant digit is at the head of the list.

Hide Company Tags Google
Hide Tags Array Math
Hide Similar Problems (M) Multiply Strings (E) Add Binary (M) Plus One Linked List
*/



/*start from the end of vector, if it is 9, change it to 0, 
if it is less than 9, plus one , and return the vector
if run to the end of 0, change vector[0] = 1, push [0] at the end of vector*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    vector<int> plusOne(vector<int>& digits) {
        int size = digits.size();
        for(int i = size-1; i >= 0; --i){
            if(digits[i] < 9){
                digits[i]++;
                return digits;
            }
            digits[i] = 0;
        }
        
        digits[0] = 1;
        digits.push_back(0);
        return digits;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int[] plusOne(int[] digits) {
        int size = digits.length;
        //remember from size-1 to 0,
        for(int i = size-1; i >= 0; --i){
            if(digits[i] < 9){
                digits[i]++;
                return digits;
            }
            digits[i] = 0;
        }
        int[] ret = new int[size+1];
        ret[0] = 1;
        return ret;
    }
}
