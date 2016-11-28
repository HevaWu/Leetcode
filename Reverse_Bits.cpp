/*190. Reverse Bits  QuestionEditorial Solution  My Submissions
Total Accepted: 75625
Total Submissions: 255991
Difficulty: Easy
Reverse bits of a given 32 bits unsigned integer.

For example, given input 43261596 (represented in binary as 00000010100101000001111010011100), return 964176192 (represented in binary as 00111001011110000010100101000000).

Follow up:
If this function is called many times, how would you optimize it?

Related problem: Reverse Integer

Credits:
Special thanks to @ts for adding this problem and creating all test cases.

Subscribe to see which companies asked this question*/




/*each time add one bit, if the original bit is 0, then OR | operation should be 0
if the original bit is 1, then add 1
start from the end of the bit */

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    uint32_t reverseBits(uint32_t n) {
        // uint32_t r;
        // r = 0;
        // for(int i = 0; i < 32; i++)
        // {
        //     r <<= 1;
        //     r += n & 1;
        //     n >>= 1;
        // }
        // return r;

        uint32_t ret = 0;
        for(int i = 0; i <32; ++i, n >>= 1){
            ret <<= 1;
            ret |= n & 1;
        }
        
        return ret;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//C++
public class Solution {
    // you need treat n as an unsigned value
    public int reverseBits(int n) {
        int ret = 0;
        for(int i = 0; i < 32; ++i, n >>= 1){
            ret <<= 1;
            ret |= n & 1;
        }
        
        return ret;
    }
}