/*190. Reverse Bits Add to List
Description  Submission  Solutions
Total Accepted: 94428
Total Submissions: 320606
Difficulty: Easy
Contributors: Admin
Reverse bits of a given 32 bits unsigned integer.

For example, given input 43261596 (represented in binary as 00000010100101000001111010011100), return 964176192 (represented in binary as 00111001011110000010100101000000).

Follow up:
If this function is called many times, how would you optimize it?

Related problem: Reverse Integer

Credits:
Special thanks to @ts for adding this problem and creating all test cases.

Hide Company Tags Apple Airbnb
Hide Tags Bit Manipulation
Hide Similar Problems (E) Number of 1 Bits
*/




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





/*
Solution 1 and Solution 2 take similar time

Bit manipulation

Solution 1:
each time
    num <<= 1;
    num = num | n&1;
    n >>= 1;

Solution 2:  2 ms / 600 test
use unsigned right shift
and signed left shift
2 digits as a group
    eg: take odd digits, right shift 1 digits
        take even digits, left shift 1 digits
4 digits as a group
8 digits as a group
16 digits as a group
32 digits as a group

Follow up:
if this function is called multiple times
divide an int into 4 bytes,
reverse each byte then combine into an int
for each byte, we could use cache to improve performance
 */

/////////////////////////////////////////////////////////////////////////////////////
//Java
//Solution 1
public class Solution {
    // you need treat n as an unsigned value
    public int reverseBits(int n) {
        int ret = 0;
        //need to check it 32times
        for(int i = 0; i < 32; ++i, n >>= 1){
            ret <<= 1;
            ret |= n & 1; //num = num | n&1;
        }

        return ret;
    }
}



//Solution 2:
public class Solution {
    // you need treat n as an unsigned value
    public int reverseBits(int n) {
        //unsigned right shift
        //signed left shift
        n = ((n & 0xAAAAAAAA) >>> 1) | ((n & 0x55555555) << 1);
        n = ((n & 0xCCCCCCCC) >>> 2) | ((n & 0x33333333) << 2);
        n = ((n & 0xf0f0f0f0) >>> 4) | ((n & 0x0f0f0f0f) << 4);
        n = ((n & 0xff00ff00) >>> 8) | ((n & 0x00ff00ff) << 8);
        n = ((n & 0xffff0000) >>> 16) | ((n & 0x0000ffff) << 16);
        return n;
    }
}



//Follow up
public class Solution {
    // you need treat n as an unsigned value
    private Map<Byte, Integer> cache = new HashMap<>();

    public int reverseBits(int n) {
        byte[] bytes = new byte[4];

        //convert n into 4 byte[]
        for(int i = 0; i < 4; ++i){
            bytes[i] = (byte)((n >>> 8*i) & 0xff);
        }

        //reverse each byte
        int num = 0; //return number
        for(int i = 0; i < 4; ++i){
            num += reverseByte(bytes[i]);
            if(i < 3){
                num <<= 8;
            }
        }
        return num;
    }

    public int reverseByte(byte b){
        Integer val = cache.get(b);
        //if we have already reverse this 8 bits
        if(val != null) return val;

        val = 0;
        //reverse bit
        for(int i = 0; i < 8; ++i, b >>= 1){
            val <<= 1;
            val |= (b&1);
        }
        return val;
    }
}
