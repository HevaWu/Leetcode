/*353. Design Snake Game   Add to List QuestionEditorial Solution  My Submissions
Total Accepted: 6216
Total Submissions: 24249
Difficulty: Medium
Contributors: Admin
Design a Snake game that is played on a device with screen size = width x height. Play the game online if you are not familiar with the game.

The snake is initially positioned at the top left corner (0,0) with length = 1 unit.

You are given a list of food's positions in row-column order. When a snake eats the food, its length and the game's score both increase by 1.

Each food appears one by one on the screen. For example, the second food will not appear until the first food was eaten by the snake.

When a food does appear on the screen, it is guaranteed that it will not appear on a block occupied by the snake.

Example:
Given width = 3, height = 2, and food = [[1,2],[0,1]].

Snake snake = new Snake(width, height, food);

Initially the snake appears at position (0,0) and the food at (1,2).

|S| | |
| | |F|

snake.move("R"); -> Returns 0

| |S| |
| | |F|

snake.move("D"); -> Returns 0

| | | |
| |S|F|

snake.move("R"); -> Returns 1 (Snake eats the first food and right after that, the second food appears at (0,1) )

| |F| |
| |S|S|

snake.move("U"); -> Returns 1

| |F|S|
| | |S|

snake.move("L"); -> Returns 2 (Snake eats the second food)

| |S|S|
| | |S|

snake.move("U"); -> Returns -1 (Game over because snake collides with border)

Credits:
Special thanks to @elmirap for adding this problem and creating all test cases.

Hide Company Tags Google
Hide Tags Design Queue
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*deque
store 2D position into 1D and store as two parts
use Set to control the eated position
use Deque to update the head of the snake
use score to get the score we need to return after moving
move function:
1. check if the body is out of boundary or eating body
2. check if current can eat the food
3. normal move,
*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
public class SnakeGame {
    private int width;
    private int height;
    private int[][] food;
    private Set<Integer> myset = new HashSet<>(); //store the eating pace
    private Deque<Integer> body = new LinkedList<>(); //update the body's head and tail
    private int score = 0; //return this value after moving
    private int foodIndex = 0; //check to eat which food in the list

    /** Initialize your data structure here.
        @param width - screen width
        @param height - screen height
        @param food - A list of food positions
        E.g food = [[1,1], [1,0]] means the first food is positioned at [1,1], the second is at [1,0]. */
    public SnakeGame(int width, int height, int[][] food) {
        this.width = width;
        this.height = height;
        this.food = food;
        myset.add(0); //init at [0,0]
        body.offerLast(0);
    }

    /** Moves the snake.
        @param direction - 'U' = Up, 'L' = Left, 'R' = Right, 'D' = Down
        @return The game's score after the move. Return -1 if game over.
        Game over when snake crosses the screen boundary or bites its body. */
    public int move(String direction) {
        if(score == -1){
            return -1;
        }

        //find the new head
        int rowhead = body.peekFirst() / width; //change 1D to 2D
        int colhead = body.peekFirst() % width;
        switch(direction){
            case "U":
                rowhead--;
                break;
            case "D":
                rowhead++;
                break;
            case "L":
                colhead--;
                break;
            default:
                colhead++;
        }
        int head = rowhead * width + colhead; change 2D to 1D

        //check if current head is out of boundary or eat the body
        myset.remove(body.peekLast());  //old head has the legal position, just remove it temporatly
        if(rowhead < 0 || rowhead == height
            || colhead < 0 || colhead == width
            || myset.contains(head)){
                return -1;
            }

        //add current head
        myset.add(head);
        body.offerFirst(head);

        //check if current head can eat the food
        if(foodIndex < food.length && rowhead == food[foodIndex][0] && colhead == food[foodIndex][1]){
            myset.add(body.peekLast()); //old tail does not change, add it back to the set
            foodIndex++;
            return ++score;
        }

        //does not eat the food, normal move
        body.pollLast();
        return score;
    }
}

/**
 * Your SnakeGame object will be instantiated and called as such:
 * SnakeGame obj = new SnakeGame(width, height, food);
 * int param_1 = obj.move(direction);
 */

