/*
Static initialization blocks are executed when the class is loaded, and you can initialize static variables in those blocks.

It's time to test your knowledge of Static initialization blocks. You can read about it here.

You are given a class Solution with a main method. Complete the given code so that it outputs the area of a parallelogram with breadth BB and height HH. You should read the variables from the standard input.

If B≤0B≤0 or HH ≤0≤0, the output should be "java.lang.Exception: Breadth and height must be positive" without quotes.

Input Format

There are two lines of input. The first line contains BB: the breadth of the parallelogram. The next line contains HH: the height of the parallelogram.

Constraints 
−100≤B≤100−100≤B≤100 
−100≤H≤100−100≤H≤100

Output Format

If both values are greater than zero, then the main method must output the area of the parallelogram. Otherwise, print "java.lang.Exception: Breadth and height must be positive" without quotes.

Sample input 1

1
3
Sample output 1

3
Sample input 2

-1
2
Sample output 2

java.lang.Exception: Breadth and height must be positive
*/

import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class Solution {
public static boolean flag;
public static int B;
public static int H;
public static Scanner Cin;
static{
    flag = true;
    Cin = new Scanner(System.in);
    B = Cin.nextInt();
    H = Cin.nextInt();
    
    if(B<=0 || H<=0){
        try{
            throw new Exception("Breadth and height must be positive");
        }catch(Exception e){
            flag = false;
            System.out.println(e.toString());
        }
    }
}
public static void main(String[] args){
        if(flag){
            int area=B*H;
            System.out.print(area);
        }
        
    }//end of main

}//end of class


