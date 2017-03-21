/*365. Water and Jug Problem   Add to List QuestionEditorial Solution  My Submissions
Total Accepted: 11153
Total Submissions: 42494
Difficulty: Medium
Contributors: Admin
You are given two jugs with capacities x and y litres. There is an infinite amount of water supply available. You need to determine whether it is possible to measure exactly z litres using these two jugs.

If z liters of water is measurable, you must have z liters of water contained within one or both buckets by the end.

Operations allowed:

Fill any of the jugs completely with water.
Empty any of the jugs.
Pour water from one jug into another till the other jug is completely full or the first jug itself is empty.
Example 1: (From the famous "Die Hard" example)

Input: x = 3, y = 5, z = 4
Output: True
Example 2:

Input: x = 2, y = 6, z = 5
Output: False
Credits:
Special thanks to @vinod23 for adding this problem and creating all test cases.

Hide Company Tags Microsoft
Hide Tags Math
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*Bézout's identity
Bézout's identity (also called Bézout's lemma) is a theorem in elementary number theory: let a and b be nonzero integers and let d be their greatest common divisor. Then there exist integers x and y such that
ax+by=d, d is their GCD(greatest common divisor)

In addition,
the greatest common divisor d is the smallest positive integer that can be written as
ax + by every integer of the form ax + by is a multiple of the greatest common divisor d.

If a or b is negative, empty a jug of x or y gallons respectively
positive, filling a jug of x or y gallons
x = 4, y = 6, z = 8.

GCD(4, 6) = 2

8 is multiple of 2

so this input is valid and we have:

-1 * 4 + 6 * 2 = 8

In this case, there is a solution obtained by filling the 6 gallon jug twice and emptying the 4 gallon jug once. (Solution. Fill the 6 gallon jug and empty 4 gallons to the 4 gallon jug. Empty the 4 gallon jug. Now empty the remaining two gallons from the 6 gallon jug to the 4 gallon jug. Next refill the 6 gallon jug. This gives 8 gallons in the end)

Solution:
first find the GCD of x and y
then check if z is multiple of d, which means if z % d == 0*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public boolean canMeasureWater(int x, int y, int z) {
        if(x < 0 || y < 0 || z < 0) return false; // all the jugs and the return should be positive

        if(x + y < z) return false; //water is finally in one or both buckets
        if(x == z || y == z || x + y == z) return true; //just fill the jugs directly

        return z % GCD(x,y) == 0; //get GCD and use the property of Bézout's identity
    }

    //get the GCD (greatest common divisor)
    public int GCD(int x, int y){
        while(y != 0){
            int temp = y;
            y = x % y;
            x = temp;
        }
        return x;
    }
}

