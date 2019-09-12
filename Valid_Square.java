/*
593. Valid Square

Given the coordinates of four points in 2D space, return whether the four points could construct a square.

The coordinate (x,y) of a point is represented by an integer array with two integers.

Example:

Input: p1 = [0,0], p2 = [1,1], p3 = [1,0], p4 = [0,1]
Output: True


Note:

All the input integers are in the range [-10000, 10000].
A valid square has four equal sides with positive length and four equal angles (90-degree angles).
Input points have no order.
 */

/*
idea:
check distance between each 2 point,
and put the result into a set.
if set not contains 0.0 <- no same point
&& set only contains 2 values <- edges & diagonal
O（1）
 */

class Solution {
    public boolean validSquare(int[] p1, int[] p2, int[] p3, int[] p4) {
		Set<Double> dist = new HashSet<>();
		dist.add(distBetween(p1, p2));
		dist.add(distBetween(p1, p3));
		dist.add(distBetween(p1, p4));
		dist.add(distBetween(p2, p3));
		dist.add(distBetween(p2, p4));
		dist.add(distBetween(p3, p4));

		return !dist.contains(0.0) && dist.size() == 2;
    }

	public double distBetween(int[] p1, int[] p2) {
		double px12 = Math.abs(p1[0] - p2[0]);
		double py12 = Math.abs(p1[1] - p2[1]);
		double res = Math.hypot(px12, py12);
		return res;
	}
}