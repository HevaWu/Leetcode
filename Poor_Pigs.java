/*458. Poor Pigs
Description  Submission  Solutions  Add to List
Total Accepted: 2265
Total Submissions: 5983
Difficulty: Easy
Contributors: yuhaowang001
There are 1000 buckets, one and only one of them contains poison, the rest are filled with water. They all look the same. If a pig drinks that poison it will die within 15 minutes. What is the minimum amount of pigs you need to figure out which bucket contains the poison within one hour.

Answer this question, and write an algorithm for the follow-up general case.

Follow-up:

If there are n buckets and a pig drinking poison will die within m minutes, how many pigs (x) you need to figure out the "poison" bucket within p minutes? There is exact one bucket with poison.*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*
Log Solution take more times than Math(pow) solution

Solution Math:
With 2 pigs, poison killing in 15 minutes, and having 60 minutes, we can find the poison in up to 25 buckets in the following way. Arrange the buckets in a 5×5 square:

 1  2  3  4  5
 6  7  8  9 10
11 12 13 14 15
16 17 18 19 20
21 22 23 24 25
Now use one pig to find the row (make it drink from buckets 1, 2, 3, 4, 5, wait 15 minutes, make it drink from buckets 6, 7, 8, 9, 10, wait 15 minutes, etc). Use the second pig to find the column (make it drink 1, 6, 11, 16, 21, then 2, 7, 12, 17, 22, etc).

Having 60 minutes and tests taking 15 minutes means we can run four tests. If the row pig dies in the third test, the poison is in the third row. If the column pig doesn't die at all, the poison is in the fifth column (this is why we can cover five rows/columns even though we can only run four tests).

With 3 pigs, we can similarly use a 5×5×5 cube instead of a 5×5 square and again use one pig to determine the coordinate of one dimension. So 3 pigs can solve up to 125 buckets.

In general, we can solve up to (⌊minutesToTest / minutesToDie⌋ + 1)^pigs buckets this way, so just find the smallest sufficient number of pigs

(⌊minutesToTest / minutesToDie⌋ + 1)^pigs buckets


Solution Log:
Also can use log to solve this problem

log(minutesToTest)/log(minutesToDie)

 */

/////////////////////////////////////////////////////////////////////////////////////
//Java
//Math Solution(pow)
public class Solution {
    public int poorPigs(int buckets, int minutesToDie, int minutesToTest) {
        if(minutesToTest < minutesToDie) return -1; //no matter how many pigs, cannot get the result

        int count = minutesToTest/minutesToDie + 1;
        int pigs = 0; //check from 0
        //System.out.println(count);
        while(Math.pow(count, pigs) < buckets){ //use pow to check if current number of pigs satisfy
            pigs++;
        }
        return pigs;
    }
}

//Log Solution
public class Solution {
    public int poorPigs(int buckets, int minutesToDie, int minutesToTest) {
        if(minutesToTest < minutesToDie) return -1; //no matter how many pigs, cannot get the result

        int count = minutesToTest/minutesToDie + 1;
        int pigs = (int)(Math.log(buckets) / Math.log(count));  //transfer double to int
        return Math.log(buckets) % Math.log(count)==0 ? pigs : pigs+1;
        //if the % result is 0, return pigs number directly, otherwise return pigs+1
    }
}

