/*279. Perfect Squares  QuestionEditorial Solution  My Submissions
Total Accepted: 46028
Total Submissions: 135058
Difficulty: Medium
Given a positive integer n, find the least number of perfect square numbers (for example, 1, 4, 9, 16, ...) which sum to n.

For example, given n = 12, return 3 because 12 = 4 + 4 + 4; given n = 13, return 2 because 13 = 4 + 9.

Credits:
Special thanks to @jianchao.li.fighter for adding this problem and creating all test cases.

Hide Company Tags Google
Hide Tags Dynamic Programming Breadth-first Search Math
Hide Similar Problems (E) Count Primes (M) Ugly Number II
*/



/*use lagrange's four square theorem
there are only 4 possible results: 1 2 3 4
return 4: n is 4^k*(8*m+7)
    1. check n % 4 == 0
    2. check n % 8 == 7   return 4
return 2: n = i*i + j*j
    isSquare(n-i*i)  --- return true, is 2
    for reduce checking, keep n-i*i >0 
    for(int i = 0; i <= (int)(sqrt(n)); ++i)
    eg: 50, did not need to check until 50, only need to check until 7( sqrt(50) )
else return 3
*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
private:
    int isSquare(int n){
        int sqrtN = (int)(sqrt(n));
        return (sqrtN*sqrtN == n);
    }
    
public:
    int numSquares(int n) {//based on lagrange's four square theorem, there are ony 4 possible results:1,2,3,4
        if(isSquare(n)){ //if n is a perfect square, return 1
            return 1;
        }
        
        //The result is 4 if and only if n can be written in the form of 4^k*(8*m+7)
        //legendre's three-square theorem
        while((n&3) == 0){ //n % 4 == 0
            n >>=2;
        }
        
        if((n & 7) == 7){ // n % 8 == 7
            return 4;
        }
        
        //check whether 2 is the result
        int sqrtN = (int)(sqrt(n));
        for(int i = 1; i <= sqrtN; i++){
            if(isSquare(n-i*i)){
                return 2;
            }
        }
        
        return 3;
    }
};






/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public int numSquares(int n) {
        if(isSquare(n)){
            return 1;
        }
        
        while(n % 4 == 0){
            n >>= 2;
        }
        
        if(n % 8 == 7){
            return 4;
        }
        
        int sqrtN = (int)Math.sqrt(n);
        // System.out.print(sqrtN);
        for(int i = 1; i <= sqrtN; i++){ //"<=sqrtN" not miss "=" 
            if(isSquare(n-i*i)){
                return 2;
            }
        }
        
        return 3;
    }
    
    private boolean isSquare(int n){
        int sqrtN = (int)Math.sqrt(n);
        // System.out.print(sqrtN);
        return (sqrtN*sqrtN == n);
    }
}



public class Solution {
    public int numSquares(int n) {
        //DP solution
        if(n<=0) return 0;
        
        //square[i] is the least number of perfect square numbers which sum to i
        int[] square = new int[n+1];
        square[0] = 0;
        for(int i = 1; i <= n; ++i){
            int num = Integer.MAX_VALUE;
            int m = (int)Math.sqrt(i);
            for(int j = 1; j <= m; ++j){
                num = Math.min(num, square[i-j*j]+1);
            }
            // System.out.println(num + " " + i);
            square[i] = num; 
        }
        return square[n];
    }
}



public class Solution {
    public int numSquares(int n) {
        //BFS solution
        if(n<=0) return 0;
        
        //squareNumber store the square number which are less than n
        LinkedList<Integer> squareNumber = new LinkedList<>();
        
        //square[i-1] store the least number of perfecto square numbers sum to i
        int[] square = new int[n]; 
        
        int m = (int)Math.sqrt(n);
        for(int i = 1; i <= m; ++i){
            squareNumber.add(i*i);
            square[i*i-1] = 1;
        }
        
        //// If n is a perfect square number, return 1 immediately.
        if(squareNumber.peekLast()==n){
            return 1;
        }
        
        
        // Consider a graph which consists of number 0, 1,...,n as
        // its nodes. Node j is connected to node i via an edge if  
        // and only if either j = i + (a perfect square number) or 
        // i = j + (a perfect square number). Starting from node 0, 
        // do the breadth-first search. If we reach node n at step 
        // m, then the least number of perfect square numbers which 
        // sum to n is m. Here since we have already obtained the 
        // perfect square numbers, we have actually finished the 
        // search at step 1.
        Queue<Integer> Q = new LinkedList<>();
        for(int i: squareNumber){
            Q.offer(i);
        }
        
        int num = 1;
        while(!Q.isEmpty()){
            num++;
            int s = Q.size();
            for(int i = 0; i < s; ++i){
                int temp = Q.peek();
                // Check the neighbors of node tmp which are the sum 
                // of tmp and a perfect square number.
                for(int j : squareNumber){
                    if(temp+j==n){
                        return num;
                    } else if(temp+j<n && square[temp+j-1]==0){
                        // If square[tmp + j - 1] > 0, this is not 
                        // the first time that we visit this node and we should 
                        // skip the node (tmp + j).
                        square[temp+j-1] = num;
                        Q.offer(temp+j);
                    } else if(temp+j>n){
                        // We don't need to consider the nodes which are greater ]
                        // than n.
                        break;
                    }
                }
                Q.poll();
            }
        }
        
        return 0;
    }
}