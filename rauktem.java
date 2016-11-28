public class rauktem {
	private int[][] matrix = new int[][] {
		new int[] {
				1,
				0
			},
			new int[] {
				0,
				1
			}
	};
	private int[][] matrixB = new int[][] {
		new int[] {
				1,
				1
			},
			new int[] {
				1,
				0
			}
	};
	private int[][] matrixA = new int[][] {
		new int[] {
				1,
				1
			},
			new int[] {
				1,
				0
			}
	};


	public int solution(int A, int B, int N) {
		if (N == 0) {
			return A % 1000000007;
		}
		if (N == 1) {
			return B;
		}
		if (N == 2) {
			return A + B;
		}

		matrixA[0][0] = B + A;
		matrixA[0][1] = B;
		matrixA[1][0] = B;
		matrixA[1][1] = A;

		matrixPower(N - 2);
		multiply(matrix, matrixA);
		return matrix[0][0] % 1000000007;
	}

	public void matrixPower(int N) {
		if (N > 1) {
			matrixPower(N / 2);
			multiply(matrix, matrix);
		}
		for (int i = 0; i < matrix.length; i++)
			for (int j = 0; j < matrix[0].length; j++)
				System.out.print(matrix[i][j] + " ");
		System.out.println();
		if (N % 2 == 1) {
			multiply(matrix, matrixB);
		}
		for (int i = 0; i < matrix.length; i++)
			for (int j = 0; j < matrix[0].length; j++)
				System.out.print(matrix[i][j] + " ");
		System.out.println();
	}

	public void multiply(int[][] a, int[][] b) {
		int rowa = a.length;
		int cola = a[0].length;
		int rowb = b.length;
		int colb = b[0].length;
		if (cola != rowb)
			throw new IllegalArgumentException("matrices don't match: " + cola + " != " + rowb);
		int[][] ret = new int[rowa][colb];

		// multiply
		for (int i = 0; i < rowa; i++)
			for (int j = 0; j < colb; j++)
				for (int k = 0; k < cola; k++)
					ret[i][j] += a[i][k] * b[k][j];

		matrix = ret;
	}

	public static void main(String[] args) {
		rauktem f = new rauktem();
		System.out.println(f.solution(3, 4, 5));
	}
}
