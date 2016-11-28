import java.util.Stack;

public class Google_OA_Directory_to_Dictionary {
	public int solution(String S) {
		if (S == null || S.length() == 0) return 0;
		String[] paths = S.split("\n");

		Stack<Integer> myStack = new Stack<>();

		int maxLen = 0;
		int index = 0;

		//if the picture file is at the root
		while (isImage(paths[index])) {
			index++;
			if (index >= paths.length)
				return maxLen;
		}

		myStack.push(index);
		int len = 1 + paths[index].trim().length();

		while (index < paths.length) {
		if (!myStack.isEmpty()) {
				int idx = myStack.peek();
				index++;
				if (index >= paths.length) {
					break;
				}

				if (isNextLevel(paths[index], paths[idx])) {
					if (isImage(paths[index])) {
						maxLen = Math.max(maxLen, len);
					} else {
						len += 1 + paths[index].trim().length();
						myStack.push(index);
					}
				} else {
					while (!isNextLevel(paths[index], paths[idx])) {
						len = len - 1 - paths[idx].trim().length();
						myStack.pop();
						if (myStack.isEmpty()) {
							break;
						}
						idx = myStack.peek();
					}

					if (len == 0 && isImage(paths[index])) {
						maxLen = Math.max(maxLen, 1 + paths[index].trim().length());
					} else {
						myStack.push(index);
						len += 1 + paths[idx].trim().length();
					}
				}
			} else {
				index++;
				if (index >= paths.length) {
					break;
				}
				if (isImage(paths[index])) {
					maxLen = Math.max(maxLen, 1 + paths[index].trim().length());
				} else {
					myStack.push(index);
					len += 1 + paths[index].trim().length();
				}
			}
		}
		return maxLen;
	}

	private boolean isNextLevel(String next, String cur) {
		int len_next = 0;
		int len_cur = 0;
		while (next.charAt(len_next) == ' ') {
			len_next++;
		}
		while (cur.charAt(len_cur) == ' ') {
			len_cur++;
		}
		return len_next - len_cur == 1;
	}

	private boolean isImage(String str) {
		String s  = str.trim();
		int i = 0;
		for (i = 0; i < s.length(); ++i) {
			if (s.charAt(i) == '.')
				break;
		}
		s = s.substring(i);
		return s.equals(".jpeg") || s.equals(".png") || s.equals(".gif");
	}

	public static int solution2(String S) {
		// write your code in Java
		int n = S.length();
		if (n == 0) return 0;

		String[] strs = S.split("\n");

		Stack<String> stack = new Stack<>();

		int len = 0;
		int maxlen = 0;

		for (int i = 0; i < strs.length;) {
			String cur = strs[i];

			int spaceNum = 0;
			for (int j = 0; j < cur.length(); j++) {
				if (cur.charAt(j) == ' ') {
					spaceNum++; 
				} else {
					break;
				}
			}

			String filename = cur.substring(spaceNum);
			if (spaceNum == stack.size()) {
				if (cur.contains(".jpeg") || cur.contains(".png") || cur.contains(".gif")) {
					stack.push(filename);
					len += filename.length() + 1;
					maxlen = Math.max(maxlen, len);
					if (len == maxlen) {

						for (String ss : stack) {
							System.out.print("\\" + ss);
						}
						System.out.println();
					}

				} else {
					len += filename.length() + 1;
					stack.push(filename);
				}
				i++;
			} else if (spaceNum < stack.size()) {
	
				while (spaceNum < stack.size()) {
	
					String tempname = stack.pop();
					len -= (tempname.length() + 1);
				}
			}
		}
		return maxlen;
	}

	public static int solution3(String S){
		if(S==null || S.length()==0) return 0;

		String[] paths = S.split("\n");

		Stack<String> myStack = new Stack<>();

		int maxLen = 0; // max length include the picture file
		int maxPicLen = 0; 
		int maxDicLen = 0;
		int sumLen = 0;

		int len = 0;

		for(int i = 0; i < paths.length;){
			String cur = paths[i];

			int space = 0;
			while(cur.charAt(space)==' '){
				space++;
			}

			String path = cur.substring(space);
			if(space == myStack.size()){
				if(cur.contains(".jpeg") || cur.contains(".png") || cur.contains(".gif")){
					myStack.push(path);

					maxDicLen = Math.max(maxDicLen, len);

					len += 1 + path.length();
					maxLen = Math.max(maxLen, len);
					sumLen += len;

					if(len == maxLen){
						for(String ss:myStack){
							System.out.print("\\" + ss);
						}
						System.out.println();

						maxPicLen = maxLen - 1 - path.length();
					}
				} else {
					len += 1 + path.length();
					myStack.push(path);
				}
				i++;
			} else if (space < myStack.size()){
				while(space < myStack.size()){
					String temp = myStack.pop();
					len -= (temp.length()+1);
				}
			}
		}

		System.out.println("maxLen: " + maxLen);
		System.out.println("maxPicLen: " + maxPicLen);
		System.out.println("maxDicLen: " + maxDicLen);
		System.out.println("sumLen: " + sumLen);

		return maxLen;
	}


	public static void main(String[] args) {
		Google_OA_Directory_to_Dictionary sol = new Google_OA_Directory_to_Dictionary();

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
		String S14 = "dir1\n dir2\n  p1.jpeg\n p123456789.png";
		String S15 = "dir1\n dir2\n  dir3\n   p1.gif\n psoerjiosgjsdhgiojiwenigwoiejtigwiowegi.png";


		System.out.println(sol.solution2(S1));    //maxLen: 24  maxPicLen: 11  maxDicLen: 11  sumLen: 39
		System.out.println(sol.solution3(S1));
		System.out.println();   
		System.out.println(sol.solution2(S2));	//maxLen: 14  maxPicLen: 0 maxDicLen: 5  sumLen: 51
		System.out.println(sol.solution3(S2));	
		System.out.println();  
		System.out.println(sol.solution2(S3));	//maxLen: 17  maxPicLen: 5  maxDicLen: 6  sumLen: 31
		System.out.println(sol.solution3(S3));
		System.out.println();  	
		System.out.println(sol.solution2(S4));		//maxLen: 0  maxPicLen: 0  maxDicLen: 0  sumLen: 0
		System.out.println(sol.solution3(S4));	
		System.out.println();  
		System.out.println(sol.solution2(S5));	//maxLen: 8  maxPicLen: 0  maxDicLen: 0  sumLen: 8
		System.out.println(sol.solution3(S5));	
		System.out.println();  
		System.out.println(sol.solution2(S6));	//maxLen: 17  maxPicLen: 10  maxDicLen: 10  sumLen: 30
		System.out.println(sol.solution3(S6));	
		System.out.println();  
		System.out.println(sol.solution2(S7));	//maxLen: 23  maxPicLen: 15  maxDicLen: 15  sumLen: 30
		System.out.println(sol.solution3(S7));
		System.out.println();  	
		System.out.println(sol.solution2(S8));	//maxLen: 0  maxPicLen: 0  maxDicLen: 0  sumLen: 0
		System.out.println(sol.solution3(S8)); 
		System.out.println();    
		System.out.println(sol.solution2(S9));	//maxLen: 0  maxPicLen: 0  maxDicLen: 0  sumLen: 0
		System.out.println(sol.solution3(S9)); 
		System.out.println();    
		System.out.println(sol.solution2(S10));	//maxLen: 27  maxPicLen: 20  maxDicLen: 20  sumLen: 49
		System.out.println(sol.solution3(S10)); 
		System.out.println();  
		System.out.println(sol.solution2(S11));	//maxLen: 7  maxPicLen: 0  maxDicLen: 0  sumLen: 14
		System.out.println(sol.solution3(S11));	
		System.out.println();  
		System.out.println(sol.solution2(S12));	//maxLen: 0  maxPicLen: 0  maxDicLen: 0  sumLen: 0
		System.out.println(sol.solution3(S12));
		System.out.println();  
		System.out.println(sol.solution2(S13));	//maxLen: 35  maxPicLen: 28  maxDicLen: 28  sumLen: 35
		System.out.println(sol.solution3(S13));	
		System.out.println();  
		System.out.println(sol.solution2(S14));	//maxLen: 20  maxPicLen: 5  maxDicLen: 10  sumLen: 38
		System.out.println(sol.solution3(S14));	
		System.out.println();  
		System.out.println(sol.solution2(S15));	//maxLen: 49  maxPicLen: 5  maxDicLen: 15  sumLen: 71
		System.out.println(sol.solution3(S15));	


	}
}