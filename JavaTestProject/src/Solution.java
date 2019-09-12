import java.util.*;

public class Solution {
	public static void main(String[] args) {
		System.out.println("Hello World!");
		
		Solution s1 = new Solution();
		int[] p1 = {0,0};
		int[] p2 = {1,1};
		int[] p3 = {0,0};
		int[] p4 = {0,0};
		boolean res = s1.validSquare(p1, p2, p3, p4);
		System.out.println(res);
	}
	
	public boolean validSquare(int[] p1, int[] p2, int[] p3, int[] p4) {
		Set<Double> dist = new HashSet<>();
		dist.add(distBetween(p1, p2));
		dist.add(distBetween(p1, p3));
		dist.add(distBetween(p1, p4));
		dist.add(distBetween(p2, p3));
		dist.add(distBetween(p2, p4));
		dist.add(distBetween(p3, p4));
		dist.forEach(v -> System.out.print(v));
		
		System.out.print(dist.contains(0.0));
		
		return !dist.contains(0.0) && dist.size() == 2;
    }
	
	public double distBetween(int[] p1, int[] p2) {
		double px12 = Math.abs(p1[0] - p2[0]);
		double py12 = Math.abs(p1[1] - p2[1]);
		double res = Math.hypot(px12, py12);
		return res;
	}
}
