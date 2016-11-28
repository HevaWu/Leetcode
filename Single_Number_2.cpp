/*137. Single Number II  QuestionEditorial Solution  My Submissions
Total Accepted: 95305
Total Submissions: 243765
Difficulty: Medium
Given an array of integers, every element appears three times except for one. Find that single one.

Note:
Your algorithm should have a linear runtime complexity. Could you implement it without using extra memory?

Subscribe to see which companies asked this question*/



/*Since each of the 32 bits follow the same rules, we just need to consider 1 bit. We know a number appears 3 times at most, so we need 2 bits to store that. Now we have 4 state, 00, 01, 10 and 11, but we only need 3 of them.

In this solution, 00, 01 and 10 are chosen. Let 'ones' represents the first bit, 'twos' represents the second bit. Then we need to set rules for 'ones' and 'twos' so that they act as we hopes. The complete loop is 00->10->01->00(0->1->2->3/0).

For 'ones', we can get 'ones = ones ^ A[i]; if (twos == 1) then ones = 0', that can be tansformed to 'ones = (ones ^ A[i]) & ~twos'.

Similarly, for 'twos', we can get 'twos = twos ^ A[i]; if (ones* == 1) then twos = 0' and 'twos = (twos ^ A[i]) & ~ones'. Notice that 'ones*' is the value of 'ones' after calculation, that is why twos is
calculated later.*/

/*Here is another example. If a number appears 5 times at most, we can write a program using the same method. Now we need 3 bits and the loop is 000->100->010->110->001. The code looks like this:

int singleNumber(int A[], int n) {
	int na = 0, nb = 0, nc = 0;
	for(int i = 0; i < n; i++){
		nb = nb ^ (A[i] & na);
		na = (na ^ A[i]) & ~nc;
		nc = nc ^ (A[i] & ~na & ~nb);
	}
	return na & ~nb & ~nc;
}
Or even like this:

int singleNumber(int A[], int n) {
	int twos = 0xffffffff, threes = 0xffffffff, ones = 0;
	for(int i = 0; i < n; i++){
		threes = threes ^ (A[i] & twos);
		twos = (twos ^ A[i]) & ~ones;
		ones = ones ^ (A[i] & ~twos & ~threes);
	}
	return ones;
}*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    int singleNumber(vector<int>& nums) {
        int ones = 0, twos = 0;
        for(int i = 0; i < nums.size(); ++i){
            ones = (ones ^ nums[i]) & ~twos;
            twos = (twos ^ nums[i]) & ~ones;
        }
        
        return ones;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int singleNumber(int[] nums) {
        int ones = 0, twos = 0;
        for(int i = 0; i < nums.length; ++i){
            ones = (ones ^ nums[i]) & ~twos;
            twos = (twos ^ nums[i]) & ~ones;
        }
        
        return ones;
    }
}

