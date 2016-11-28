
public class Google_OA_Integer_Adjacent_Two_Number_Average {
	public static int solution(int X) {
		/*given an integer X, choose two adjacent digits
			and replace them with the averange number of these two digits*/

		/*start from 0, once a[i]<a[i+1], check
		a[i]==a[i-1]*/
		if (X < 10 || X > 1e8) {
			return -1;
		}

		String str = String.valueOf(X);
		char[] arr = str.toCharArray();
		if (arr.length < 2) {
			return X;
		}
		System.out.println(arr);

		int n = arr.length;
		String ret;
		for (int i = 0; i < n - 1; ++i) {
			if (arr[i] >= arr[i + 1]) {
				continue;
			} else if (arr[i] < arr[i + 1]) {
				if (i >= 1 && (arr[i] == arr[i - 1] || arr[i] == arr[i - 1] - 1)) {
					ret = str.substring(0, i) + str.substring(i + 1);
					return Integer.parseInt(ret);
				} else {
					int i1 = Character.getNumericValue(arr[i]);
					int i2 = Character.getNumericValue(arr[i + 1]);
					// int aver = ceil((i1+i2)/2);
					int aver = (int)((i1 + i2 - 1) / 2 + 1);
					ret = str.substring(0, i) + String.valueOf(aver) + str.substring(i + 2);
					return Integer.parseInt(ret);
				}
			}
		}
		int i1 = Character.getNumericValue(arr[n - 1]);
		int i2 = Character.getNumericValue(arr[n - 2]);
		int aver = (int)((i1 + i2 - 1) / 2 + 1);
		ret = str.substring(0, n - 2) + String.valueOf(aver);
		return Integer.parseInt(ret);
	}

	public static int solution2(int X) {
		if (X < 10 || X > 1e8) {
			return -1;
		}

		StringBuilder str = new StringBuilder(String.valueOf(X));
		int n = str.length();
		if (n < 2) {
			return X;
		}
		System.out.println(str);

		for (int i = 0; i < n - 1; ++i) {
			if (str.charAt(i) - '0' >= str.charAt(i + 1) - '0') {
				continue;
			} else if (str.charAt(i) - '0' < str.charAt(i + 1) - '0') {
				if (i >= 1 && (str.charAt(i) - '0' == str.charAt(i - 1) - '0' || str.charAt(i) - '0' == str.charAt(i - 1) - '0' - 1)) {
					str.deleteCharAt(i);
					return Integer.valueOf(str.toString());
				} else {
					int i1 = str.charAt(i) - '0';
					int i2 = str.charAt(i + 1) - '0';
					// int aver = ceil((i1+i2)/2);
					int aver = (int)((i1 + i2 + 1) / 2);
					str.deleteCharAt(i);
					str.replace(i, i + 1, String.valueOf(aver));
					return Integer.valueOf(str.toString());
				}
			}
		}
		int i1 = str.charAt(n - 1) - '0';
		int i2 = str.charAt(n - 2) - '0';
		int aver = (int)((i1 + i2 - 1) / 2 + 1);
		str.deleteCharAt(n - 2);
		str.replace(n - 2, n - 1, String.valueOf(aver));
		return Integer.valueOf(str.toString());
	}

	public static int solution3(int X) {
		if (X < 10 || X > 1e8) {
			return -1;
		}

		StringBuilder str = new StringBuilder(String.valueOf(X));
		int n = str.length();
		if (n < 2) {
			return X;
		}
		System.out.println(str);

		int max = 0;
		for (int i = 0; i < n - 1; ++i) {
			StringBuilder nstr = str;
			int i1 = str.charAt(i) - '0';
			int i2 = str.charAt(i + 1) - '0';
			int aver = (int)((i1 + i2 + 1) / 2);
			nstr.deleteCharAt(i);
			nstr.replace(i, i + 1, String.valueOf(aver));
			max = Math.max(max, Integer.valueOf(nstr.toString()));
		}

		return max;
	}

	public static void main(String[] args) {
		System.out.println(solution(62215));
		System.out.println(solution2(62215));
		System.out.println(solution2(62215));
		System.out.println();
		System.out.println(solution(612215));
		System.out.println(solution2(612215));
		System.out.println(solution2(612215));
		System.out.println();
		System.out.println(solution(222228));
		System.out.println(solution2(222228));
		System.out.println(solution2(222228));
		System.out.println();
		System.out.println(solution(13323554));
		System.out.println(solution2(13323554));
		System.out.println(solution2(13323554));
		System.out.println();
		System.out.println(solution(532743));
		System.out.println(solution2(532743));
		System.out.println(solution2(532743));
		System.out.println();
		System.out.println(solution(97531));
		System.out.println(solution2(97531));
		System.out.println(solution2(97531));
		System.out.println();
		System.out.println(solution(2));
		System.out.println(solution2(2));
		System.out.println(solution2(2));
		System.out.println();
		System.out.println(solution(0));
		System.out.println(solution2(0));
		System.out.println(solution2(0));
		System.out.println();
	}
}
