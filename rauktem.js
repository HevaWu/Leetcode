public class Fibonacci {
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
	private int[][] matrix3 = new int[][] {
		new int[] {
				1,
				1
			},
			new int[] {
				1,
				0
			}
	};
	private int[][] matrix2 = new int[][] {
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
			return A;
		}
		if (N == 1) {
			return B;
		}
		if (N == 2) {
			return A + B;
		}

		matrix2[0][0] = B + A;
		matrix2[0][1] = B;
		matrix2[1][0] = B;
		matrix2[1][1] = A;

		matrixPower(N - 2);
		multiply(matrix, matrix2);
		return matrix[0][0];
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
			multiply(matrix, matrix3);
		}
		for (int i = 0; i < matrix.length; i++)
			for (int j = 0; j < matrix[0].length; j++)
				System.out.print(matrix[i][j] + " ");
		System.out.println();
	}

	public void multiply(int[][] m1, int[][] m2) {
		int m1rows = m1.length;
		int m1cols = m1[0].length;
		int m2rows = m2.length;
		int m2cols = m2[0].length;
		if (m1cols != m2rows)
			throw new IllegalArgumentException("matrices don't match: " + m1cols + " != " + m2rows);
		int[][] result = new int[m1rows][m2cols];

		// multiply
		for (int i = 0; i < m1rows; i++)
			for (int j = 0; j < m2cols; j++)
				for (int k = 0; k < m1cols; k++)
					result[i][j] += m1[i][k] * m2[k][j];

		matrix = result;
	}

	public static void main(String[] args) {
		Fibonacci f = new Fibonacci();
		System.out.println(f.solution(3, 4, 5));
	}
}
