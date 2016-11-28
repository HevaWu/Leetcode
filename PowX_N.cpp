/*50. Pow(x, n)  QuestionEditorial Solution  My Submissions
Total Accepted: 112959 Total Submissions: 413626 Difficulty: Medium
Implement pow(x, n).

Hide Company Tags LinkedIn Google Bloomberg Facebook
Hide Tags Binary Search Math
Hide Similar Problems (M) Sqrt(x) (M) Super Pow
*/



/*O(logn) time
recursively find the pow(n)

if n==0 return 1
if n%2==0 return pow(x*x, n/2)
	else if n>0 return x*myPow(x*x, n/2)
			else return myPow(x*x, n/2)/x
half recursively do pow*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    double myPow(double x, int n) {
        if(n==0) return 1;
        return (n%2==0) ? myPow(x*x, n/2) : 
                ((n>0) ? x*myPow(x*x, n/2) : myPow(x*x, n/2)/x);
    }
};




/////////////////////////////////////////////////////////////////////////////////////
//Java
public class Solution {
    public double myPow(double x, int n) {
        if(n==0) return 1;
        return (n%2==0) ? myPow(x*x,n/2) :
                ((n>0) ? x*myPow(x*x,n/2) : myPow(x*x, n/2)/x);
    }
}
