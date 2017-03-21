/*170. Two Sum III - Data structure design Add to List
Description  Submission  Solutions
Total Accepted: 23904
Total Submissions: 102701
Difficulty: Easy
Contributors: Admin
Design and implement a TwoSum class. It should support the following operations: add and find.

add - Add the number to an internal data structure.
find - Find if there exists any pair of numbers which sum is equal to the value.

For example,
add(1); add(3); add(5);
find(4) -> true
find(7) -> false
Hide Company Tags LinkedIn
Hide Tags Hash Table Design
Hide Similar Problems (E) Two Sum (M) Unique Word Abbreviation
 */






/*
Solution 1
use set structure
two set
one for sum
one for num

Solution 2:
Map<HashMap> mymap --- key is the number ,value is the times it appears
List<Integer> num --- list of number
 */

////////////////////////////////////////////////////////////////////////
//Java
//Solution 1
public class TwoSum {
    private Set<Integer> sum = new HashSet<>();
    private Set<Integer> num = new HashSet<>();

    /** Initialize your data structure here. */
    public TwoSum() {

    }

    /** Add the number to an internal data structure.. */
    public void add(int number) {
        if(num.contains(number)) {
            sum.add(number*2);
        } else {
            for(int i : num){
                sum.add(number + i);
            }
            num.add(number);
        }
    }

    /** Find if there exists any pair of numbers which sum is equal to the value. */
    public boolean find(int value) {
        return sum.contains(value);
    }
}

/**
 * Your TwoSum object will be instantiated and called as such:
 * TwoSum obj = new TwoSum();
 * obj.add(number);
 * boolean param_2 = obj.find(value);
 */



//Solution 2
