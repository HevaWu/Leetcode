import java.util.*;

public class Solution {
	public static void main(String[] args) {
		System.out.println("Hello World!");
		
		Solution s1 = new Solution();
		int[] A = {18, 3, 6, 2};
		int res = s1.numFactoredBinaryTrees(A);
		System.out.println(res);
	}
	
	public int numFactoredBinaryTrees(int[] A) {
		if (A.length == 0) {
			return 0;
		}
		
        long res = 0;
        long mod = (long)1e9 + 7;
        
        Arrays.sort(A);
        HashMap<Integer, Long> dp = new HashMap<>();
        
        for (int i = 0; i < A.length; ++i) {
        	dp.put(A[i], 1L);
        	for (int j = 0; j < i; ++j) {
        		if (A[i] % A[j] == 0) {
        			dp.put(A[i], 
        					(dp.get(A[i]) + 
        							dp.get(A[j])*dp.getOrDefault(A[i] / A[j], 0L)) % mod);
        		}
        	}
        	res = (res + dp.get(A[i])) % mod;
        }
        return (int)res;
    }
}
