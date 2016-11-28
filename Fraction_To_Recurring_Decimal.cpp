/*166. Fraction to Recurring Decimal  QuestionEditorial Solution  My Submissions
Total Accepted: 39665 Total Submissions: 242506 Difficulty: Medium
Given two integers representing the numerator and denominator of a fraction, return the fraction in string format.

If the fractional part is repeating, enclose the repeating part in parentheses.

For example,

Given numerator = 1, denominator = 2, return "0.5".
Given numerator = 2, denominator = 1, return "2".
Given numerator = 2, denominator = 3, return "0.(6)".
Hint:

No scary math, just apply elementary math knowledge. Still remember how to perform a long division?
Try a long division on 4/9, the repeating part is obvious. Now try 4/333. Do you see a pattern?
Be wary of edge cases! List out as many test cases as you can think of and test your code thoroughly.
Credits:
Special thanks to @Shangrila for adding this problem and creating all test cases.

Hide Company Tags Google
Hide Tags Hash Table Math
*/



/*
numerator 分子
denominator 分母
1. check the return is negative or positive, using XOR^ operator
	then change all of them to positive, store them into long, since int might over limit
2. get the integral part
3. get the fractional part and store them into HashMap<Long, Integer>
	each time num*10 to get the next denominator part
	then res.append(num/den) to get the next fraction
	num %= den change num to the next denominator part
		check if map is already contain this den part
		if it is add (), and break
		if not, put this num in map
return res.toString()*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    string fractionToDecimal(int numerator, int denominator) {
        if(numerator==0 || denominator==0) return "0"; //return string "0"
        string ret;
        //check if the result is negative
        if((numerator>0)^(denominator>0)){
            ret += "-";
        }
        
        //change into positive
        long num = abs((long)numerator);
        long den = abs((long)denominator);
        
        //push the integer part
        ret += to_string(num/den);
        num %= den;
        if(num==0) return ret;
        ret += ".";
        
        //push the fractional part
        unordered_map<int, int> mymap;
        mymap[num] = ret.size(); // here should put the num key
        while(num!=0){
            num *= 10;
            ret += to_string(num/den);
            num %= den;
            if(mymap.find(num) != mymap.end()){
                ret.insert(mymap[num], 1, '('); // remember '(' is a char
                // cout << ret << " " << mymap[num] << endl;
                ret += ")";
                break;
            } else {
                mymap[num] = ret.size();
                // cout << num << " " << mymap[num] << " " << ret << endl;
            }
        }
        
        return ret;
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public String fractionToDecimal(int numerator, int denominator) {
        if(numerator==0 || denominator==0) return "0"; //remember string "0"
        StringBuilder ret = new StringBuilder(); //use Stringbuilder to add string
        //check the return value is positive or negative
        ret.append(((numerator>0)^(denominator>0)) ? "-" : "");
        
        //change to positive number
        long num = Math.abs((long)numerator);//remember long
        long den = Math.abs((long)denominator);
        
        //push the integral part
        ret.append(num/den);
        num %= den;
        if(num==0) return ret.toString();
        
        //push the fractional part
        ret.append(".");
        HashMap<Long, Integer> mymap = new HashMap<>(); //length should return int
        mymap.put(num, ret.length()); //remember put the size here
        while(num!=0){
            num *= 10;
            ret.append(num/den);
            num %= den;
            if(mymap.containsKey(num)){
                ret.insert(mymap.get(num), "(");
                ret.append(")");
                break;
            } else {
                mymap.put(num, ret.length());
            }
        }
        
        return ret.toString();
    }
}
