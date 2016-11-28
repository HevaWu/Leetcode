/*420. Strong Password Checker   QuestionEditorial Solution  My Submissions
Total Accepted: 828
Total Submissions: 3736
Difficulty: Hard
Contributors: yduan7
A password is considered strong if below conditions are all met:

It has at least 6 characters and at most 20 characters.
It must contain at least one lowercase letter, at least one uppercase letter, and at least one digit.
It must NOT contain three repeating characters in a row ("...aaa..." is weak, but "...aa...a..." is strong, assuming other conditions are met).
Write a function strongPasswordChecker(s), that takes a string s as input, and return the MINIMUM change required to make s a strong password. If s is already strong, return 0.

Insertion, deletion or replace of any one character are all considered as one change.

Subscribe to see which companies asked this question*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*
use upper, lower, digit boolean type to makesure it contains at least one lowercase letter, one upper, one digit
use repeat check if the same letters repeat three times
mark these repeat letters
at the end, check if the string.length is larger than 20, reduce the number of repleace ment operation by deletion
 */

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int strongPasswordChecker(String s) {
        //3 might have repeat letters
        if(s.length()<2) return 6-s.length();

        char cur = s.charAt(0);
        boolean upper = cur>='A'&&cur<='Z';
        boolean lower = cur>='a'&&cur<='z';
        boolean digit = cur>='0'&&cur<='9';

        int cur_rep = 1; //record current repeat times
        int[] del = new int[3]; //record how many letters need to be deleted
        int change = 0; //record change times

        for(int i = 1; i < s.length(); ++i){
            if(s.charAt(i)==cur){
                cur_rep++;
            } else {
                change += cur_rep/3;
                if(cur_rep/3>0) ++del[cur_rep%3];
                cur = s.charAt(i);
                upper = upper || cur>='A'&&cur<='Z';
                lower = lower || cur>='a'&&cur<='z';
                digit = digit || cur>='0'&&cur<='9';
                cur_rep = 1;
            }
        }

        change += cur_rep/3;
        if(cur_rep/3>0) ++del[cur_rep%3];

        int check_req = (upper?0:1) + (lower?0:1) + (digit?0:1);
        if(s.length()>20){
            int delete = s.length()-20; //record how many letters we need to delete
            if(delete <= del[0]) change -= delete;
            else if(delete-del[0]<=2*del[1]) change -= del[0]+(delete-del[0])/2;
            else change -= del[0]+del[1]+(delete-del[0]-2*del[1])/3;

            return delete+Math.max(change, check_req);
        } else {
            return Math.max(6-s.length(), Math.max(check_req, change));
        }
    }
}
