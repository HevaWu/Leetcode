'''
Given a singly linked list, return a random node's value from the linked list. Each node must have the same probability of being chosen.

Implement the Solution class:

Solution(ListNode head) Initializes the object with the integer array nums.
int getRandom() Chooses a node randomly from the list and returns its value. All the nodes of the list should be equally likely to be choosen.


Example 1:


Input
["Solution", "getRandom", "getRandom", "getRandom", "getRandom", "getRandom"]
[[[1, 2, 3]], [], [], [], [], []]
Output
[null, 1, 3, 2, 2, 3]

Explanation
Solution solution = new Solution([1, 2, 3]);
solution.getRandom(); // return 1
solution.getRandom(); // return 3
solution.getRandom(); // return 2
solution.getRandom(); // return 2
solution.getRandom(); // return 3
// getRandom() should return either 1, 2, or 3 randomly. Each element should have equal probability of returning.


Constraints:

The number of nodes in the linked list will be in the range [1, 104].
-104 <= Node.val <= 104
At most 104 calls will be made to getRandom.


Follow up:

What if the linked list is extremely large and its length is unknown to you?
Could you solve this efficiently without using extra space?
'''

'''
Solution 2:
Reservoir Sampling

Time Complexity:
- init: O(1)
- get: O(n)
Space Complexity: O(1)
'''
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:

    def __init__(self, head: Optional[ListNode]):
        self.head = head

    def getRandom(self) -> int:
        chosen = 0
        scope = 1
        cur = self.head
        while cur:
            if random.randint(0, scope-1) == 0:
                chosen = cur.val
            scope += 1
            cur = cur.next
        return chosen



# Your Solution object will be instantiated and called as such:
# obj = Solution(head)
# param_1 = obj.getRandom()

'''
Solution 1:
save to array, then pick random element

Time Complexity:
- init: O(n)
- get: O(1)
Space Complexity: O(n)
'''
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:

    def __init__(self, head: Optional[ListNode]):
        self.arr = []
        while head:
            self.arr.append(head.val)
            head = head.next


    def getRandom(self) -> int:
        index = random.randint(0, len(self.arr)-1)
        return self.arr[index]


# Your Solution object will be instantiated and called as such:
# obj = Solution(head)
# param_1 = obj.getRandom()