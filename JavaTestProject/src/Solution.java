
public class Solution {
	public static void main(String[] args) {
		System.out.println("Hello World!");
		
		Solution s1 = new Solution();
		s1.tryToPrint();
	}
	
	public void tryToPrint() {
		System.out.print("void");
		_tryToPrint();
	}
	
	public void _tryToPrint() {
		System.out.print("try");
	}
}
