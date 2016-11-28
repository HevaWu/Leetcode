
public class Google_OA_Merge {

	public static int solution(int X) {
		if(X < 10 || X > 1e8) {
			return -1;
		}
		char[] arr = String.valueOf(X).toCharArray();
		if(arr.length < 2) {
			return X;
		}
		System.out.println(arr);
		for(int i = 0; i < arr.length - 2; i++) {
			if(arr[i] >= arr[i+1] && arr[i+1] > arr[i+2]) {
				for(int j = i+1; j < arr.length - 1; j++) {
					arr[j] = arr[j+1];				
				}
				return Integer.parseInt(String.valueOf(arr).substring(0,arr.length-1));
			}
		}
		
		arr[arr.length-2] = (arr[arr.length-2] - '0') > (arr[arr.length-1] - '0') ? arr[arr.length-2] : arr[arr.length-1];
		
		
		return Integer.parseInt(String.valueOf(arr).substring(0, arr.length-1));
	}
	
	public static int solution2( int X) {
		if(X < 10 || X > 1e8) {
			return -1;
		}
		
		StringBuilder str = new StringBuilder(String.valueOf(X));
		for (int i = 0; i < str.length() - 2; i++) {
			if(str.charAt(i) - '0' >= str.charAt(i + 1) - '0' && str.charAt(i+1) - '0' > str.charAt(i + 2) - '0') {
				str.deleteCharAt(i+1);
				return Integer.valueOf(str.toString());
			}
		}
		char c = str.charAt(str.length() - 2) - '0' > str.charAt(str.length() - 1) - '0' ? str.charAt(str.length() - 2) : str.charAt(str.length() - 1);
		str.setCharAt(str.length() - 2, c);
		return Integer.valueOf(str.substring(0, str.length()-1));
	}

	public static int solution3(int X){
		if (X < 10 || X > 1e8) {
			return -1;
		}

		StringBuilder str = new StringBuilder(String.valueOf(X));
		int n = str.length();
		if (n < 2) {
			return X;
		}
		System.out.println(str);

		int min = Integer.MIN_VALUE;
		for (int i = 0; i < n - 1; ++i) {
			StringBuilder nstr = str;
			int i1 = str.charAt(i) - '0';
			int i2 = str.charAt(i + 1) - '0';
			if(i1>=i2){
				nstr.deleteCharAt(i+1);
			} else {
				nstr.deleteCharAt(i);
			}
			min = Math.min(min, Integer.valueOf(nstr.toString()));
		}

		return min;
	}
	
	public static void main(String[] args) {
		System.out.println(solution(233614));
		System.out.println(solution2(233614));
		System.out.println(solution2(233614));
		System.out.println();
		System.out.println(solution(532743));
		System.out.println(solution2(532743));
		System.out.println(solution2(532743));
		System.out.println();
		System.out.println(solution(2));
		System.out.println(solution2(2));
		System.out.println(solution2(2));
		System.out.println();
		System.out.println(solution(23));
		System.out.println(solution2(23));
		System.out.println(solution2(23));
		System.out.println();
		System.out.println(solution(0));
		System.out.println(solution2(0));
		System.out.println(solution2(0));
		System.out.println();
		System.out.println(solution(234));
		System.out.println(solution2(234));
		System.out.println(solution2(234));
		System.out.println();
		System.out.println(solution(13323554));
		System.out.println(solution2(13323554));
		System.out.println(solution2(13323554));
		System.out.println();
		System.out.println(solution(323444));
		System.out.println(solution2(323444));
		System.out.println(solution2(323444));
		System.out.println();
	}
}
