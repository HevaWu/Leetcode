import java.util.Stack;

public class Google_OA_Directory {
	public int solution(String S) {
		if(S == null || S.length() == 0) {
			return 0;
		}
		String[] strByLine = S.split("\n");
		return CountImagePath(strByLine);
	}
	
	private int CountImagePath(String[] str) {
		if(str.length == 0) {
			return 0;
		}
		Stack<Integer> stk = new Stack<>();
		int sum = 0;
		int len = 0;
		int index = 0;
		
		while(isImage(str[index])) {
			sum = sum + 1 + str[index].trim().length();
			index++;
			if(index >= str.length)
				return sum;
		}
		stk.push(index);
		len = len + 1 + str[index].trim().length();
		
		while(index < str.length) {
			if(!stk.isEmpty()) {
				int idx = stk.peek();
				index++;
				if(index >= str.length) {
					break;
				}
				if(isNextLevel(str[index], str[idx])){
					if(isImage(str[index])) {
						sum = sum + len + 1 + str[index].trim().length();
					} else {
						len += 1 + str[index].trim().length();
						stk.push(index);
					}
				} else {
					while(!isNextLevel(str[index], str[idx])) {
						len = len - 1 - str[idx].trim().length();
						stk.pop();
						if(stk.isEmpty()) {
							break;
						}
						idx = stk.peek();
					} 
					if(len == 0 && isImage(str[index])) {
						sum = sum + 1 + str[index].trim().length();
					} else {
						stk.push(index);
						len = len + 1 + str[index].trim().length();
					}
				}	
			} else {
				index++;
				if(index >= str.length) {
					break;
				}
				if(isImage(str[index])) {
					sum = sum + 1 + str[index].trim().length();
				} else {
					stk.push(index);
					len = len + 1 +str[index].trim().length();
				}
			}
		}
		return sum;
	}
	
	private boolean isImage(String str) {
		String s = str.trim();
		int idx = 0;
		while(idx < s.length()) {
			if(s.charAt(idx) == '.')
				break;
			idx++;
		}
		s = s.substring(idx);
		return s.equals(".jpeg") || s.equals(".gif") || s.equals(".png");
	}
	
	private boolean isNextLevel(String next, String current) {
		int len_next = 0;
		int len_current = 0;
		while(next.charAt(len_next) == ' ') {
			len_next++;
		}
		while(current.charAt(len_current) == ' ') {
			len_current++;
		}
		return len_next - len_current == 1;
	}
	
	public static void main(String[] args) {
		Google_OA_Directory sol = new Google_OA_Directory();
		/*String S = "dir1\n dir11\n dir12\n  picture.jpeg\n  dir121\n  file1.txt\ndir2\n file2.gif";
		String S1 = "p1.jpeg\ndir1\n p2.jpeg\n p3.gif\n p4.png";
		String S2 = "p1.jpeg";
		String S3 = "";
		String S4 = null;
		String S5 = "dir1\n p1.jpeg\ndir2\n p2.gif";
		String S6 = "dir1\n p1.jpeg\n dir2\n  p2.gif";
		String S7 = "dir0\ndir1\n dir2\n  dir3\n   p1.jpeg\np2.png";
		String S8 = "dir1";
		String S9 = "dir1\np1.png";
		String S10 = "dir1\ndir2\np1.png\np2.gif";
		String S11 = "dir1\n dir2\n  dir3\n dir4\ndir5\n dir6\n  dir7\ndir8";
		String S12 = "dir1\n dir2\n  dir3\n dir4\ndir5\n dir6\n  dir7\ndir8\n dir9\n  dir10\n   dir11\n    dir12\n     p1.png";*/

		String S1 = "dir1\n dir11\n dir12\n  picture.jpeg\n  dir121\n  file1.txt\ndir2\n file2.gif";
		String S2 = "picture1.jpeg\ndir1\n p2.jpeg\n p3.gif\n p4.png";
		String S3 = "dir12\n p1.jpeg\ndir2\n p256789.gif";
		String S4 = "";
		String S5 = "p1.jpeg";
		String S6 = "dir1\n p1.jpeg\n dir2\n  g2.gif";
		String S7 = "dir0\ndir1\n dir2\n  dir3\n   dir4\n   p5.jpeg\np4.gif";
		String S8 = "dir1";
		String S9 = "dir1\n dir2";
		String S10 = "dir1\n dir2\n  dir3\n   dir4\n   p4.gif\n   dir5\n    p5.png";
		String S11 = "dir1\ndir2\np1.png\np2.gif";
		String S12 = "dir1\n dir2\n  dir3\n dir4\ndir5\n dir6\n  dir7\ndir8";
		String S13 = "dir1\n dir2\n  dir3\n dir4\ndir5\n dir6\n  dir7\ndir8\n dir9\n  dir10\n   dir11\n    dir12\n     p1.png";
		

		// System.out.println(sol.solution(S));    //39
		System.out.println(sol.solution(S1));   //45
		System.out.println(sol.solution(S2));	//8
		System.out.println(sol.solution(S3));	//0
		System.out.println(sol.solution(S4));	//0
		System.out.println(sol.solution(S5));	//25
		System.out.println(sol.solution(S6));	//30
		System.out.println(sol.solution(S7));	//30
		System.out.println(sol.solution(S8));   //0
		System.out.println(sol.solution(S9));   //7
		System.out.println(sol.solution(S10));  //14
		System.out.println(sol.solution(S11));	//0
		System.out.println(sol.solution(S12));	//
		System.out.println(sol.solution(S13));
		
		
	}
}
