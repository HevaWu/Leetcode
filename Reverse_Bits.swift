/*
Reverse bits of a given 32 bits unsigned integer.

Note:

Note that in some languages such as Java, there is no unsigned integer type. In this case, both input and output will be given as a signed integer type. They should not affect your implementation, as the integer's internal binary representation is the same, whether it is signed or unsigned.
In Java, the compiler represents the signed integers using 2's complement notation. Therefore, in Example 2 above, the input represents the signed integer -3 and the output represents the signed integer -1073741825.
Follow up:

If this function is called many times, how would you optimize it?

 

Example 1:

Input: n = 00000010100101000001111010011100
Output:    964176192 (00111001011110000010100101000000)
Explanation: The input binary string 00000010100101000001111010011100 represents the unsigned integer 43261596, so return 964176192 which its binary representation is 00111001011110000010100101000000.
Example 2:

Input: n = 11111111111111111111111111111101
Output:   3221225471 (10111111111111111111111111111111)
Explanation: The input binary string 11111111111111111111111111111101 represents the unsigned integer 4294967293, so return 3221225471 which its binary representation is 10111111111111111111111111111111.
 

Constraints:

The input must be a binary string of length 32
*/

/*
Solution 2
bit shift

            b1 b2
shift -> b1 0,   0 b2
shift -> 0 b1,  b2 0
combine -> b2 b1

32bit 0000 0000 0000 0000 0000 0000 0000 0000
		f	f	 0	   0 |  f	f	 0	   0
		0	0	 f	   f |  0	0 	 f	   f
		f	0  | f	   0 |  f	0  | f	   0
		0	f  | 0	   f |  0	f  | 0	   f
	  1100 1100 1100 1100 1100 1100 1100 1100
	    c	c    c	   c    c	c    c	   c
	  0011 0011 0011 0011 0011 0011 0011 0011
	    3	3    3	   3    3	3    3	   3
	  1010 1010 1010 1010 1010 1010 1010 1010
	    a	a    a	   a    a	a    a	   a
	  0101 0101 0101 0101 0101 0101 0101 0101
	    5	5    5	   5    5	5    5	   5

Time Complexity: O(1)
Space Complexity: O(1)
*/
class Solution {
    func reverseBits(_ n: Int) -> Int {
        var n = (n >> 16) | (n << 16)
        n = ((n & 0xff00ff00) >> 8) | ((n & 0x00ff00ff) << 8)
        n = ((n & 0xf0f0f0f0) >> 4) | ((n & 0x0f0f0f0f) << 4)
        n = ((n & 0xcccccccc) >> 2) | ((n & 0x33333333) << 2)
        n = ((n & 0xaaaaaaaa) >> 1) | ((n & 0x55555555) << 1)
        return n
    }
}

/*
Solution 1
Bit by bit

for each bit, add it to res with power

Time Complexity: O(1)
Space Complexity: O(1)
*/
class Solution {
    func reverseBits(_ n: Int) -> Int {
        var n = n
        var res = 0
        
        var power = 31
        while n != 0 {
            res += (n&1) << power
            n = n >> 1
            power -= 1
        }
        
        return res
    }
}