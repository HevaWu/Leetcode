/*
In computer science, a double-ended queue (dequeue, often abbreviated to deque, pronounced deck) is an abstract data type that generalizes a queue, for which elements can be added to or removed from either the front (head) or back (tail).

Deque interfaces can be implemented using various types of collections such as LinkedList or ArrayDeque classes. For example, deque can be declared as:

Deque deque = new LinkedList<>();
or
Deque deque = new ArrayDeque<>();
You can find more details about Deque here.

In this problem, you are given  integers. You need to find the maximum number of unique integers among all the possible contiguous subarrays of size .

Note: Time limit is  second for this problem.

Input Format

The first line of input contains two integers  and : representing the total number of integers and the size of the subarray, respectively. The next line contains  space separated integers.

Constraints




The numbers in the array will range between .

Output Format

Print the maximum number of unique integers among all possible contiguous subarrays of size .

Sample Input

6 3
5 3 5 2 3 2
Sample Output

3
Explanation

In the sample testcase, there are 4 subarrays of contiguous numbers.

s1<5,3,5> - Has 2 unique numbers.

s1<3,5,2> - Has 3 unique numbers.

s1<5,2,3> - Has 3 unique numbers.

s1<2,3,2> - Has 2 unique numbers.

In these subarrays, there are 2,3,3,2 unique numbers, respectively. The maximum amount of unique numbers among all possible contiguous subarrays is 3.
*/

  import java.util.*;
    public class test {
        public static void main(String[] args) {
            Scanner in = new Scanner(System.in);
            Deque deque = new ArrayDeque<Integer>();
            int n = in.nextInt();
            int m = in.nextInt();


            int nunique = 0;
            Deque<Integer> deq = new LinkedList<Integer>();
            Map<Integer, Integer> mymap = new HashMap<Integer, Integer>();
            
            for (int i = 0; i < n; i++) {
                int num = in.nextInt();
                deq.addLast(num);
                mymap.put(num, mymap.getOrDefault(num,0)+1);
                if(deq.size()>m){
                    num = deq.removeFirst();
                    int c = mymap.getOrDefault(num,0)-1;
                    if(c<=0)
                        mymap.remove(num);
                    else 
                        mymap.put(num,c);
                }
                
                nunique = Math.max(nunique,mymap.size());
                
                              
                /*
                if(deque.size() == m){
                    int last = deque.pollLast();
                    int val = mymap.get(last)-1;
                    mymap.put(last,val);
                    if(val==0)
                        --curr;
                }
                
                if(!mymap.contiansKey(num) || mymap.get(num)==0)
                    ++curr;
                deque.offerFirst(num);
                nunique = Math.max(nunique, curr);
                
                Integer val = mymap.get(num);
                if(val == null)
                    val = new Integer(0);
                mymap.put(num, val+1);*/
            }
            
            System.out.println(nunique);
            
        }
    }
