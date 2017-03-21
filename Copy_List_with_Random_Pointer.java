/*138. Copy List with Random Pointer Add to List
Description  Submission  Solutions
Total Accepted: 99646
Total Submissions: 374823
Difficulty: Medium
Contributors: Admin
A linked list is given such that each node contains an additional random pointer which could point to any node in the list or null.

Return a deep copy of the list.

Hide Company Tags Amazon Microsoft Bloomberg Uber
Hide Tags Hash Table Linked List
Hide Similar Problems (M) Clone Graph
 */






/*
Solution 1:
O(n) time O(1) space
iterate the list in 2 rounds respectively to crate ndoes and assign the values for their random pointers
idea: associate the original node with its copy node in a single linked list
in this way, we don't need extra space to keep track of the new nodes
1. iterate the original list and duplicate each node,
    the duplicate of each node follows its original immediately
2. iterate the new list and assign the random pointer for each duplicate node
3. restore the original list and extract the duplicated nodes


Solution 2:
keep a hash table for each node in the list
O(N) time O(N) space
 */

////////////////////////////////////////////////////////////////////////
//Java
/**
 * Definition for singly-linked list with a random pointer.
 * class RandomListNode {
 *     int label;
 *     RandomListNode next, random;
 *     RandomListNode(int x) { this.label = x; }
 * };
 */
public class Solution {
    public RandomListNode copyRandomList(RandomListNode head) {
        RandomListNode iter = head;
        RandomListNode next;

        //1. make copy of each node
        //link them together side by side in a single list
        while(iter != null){
            next = iter.next;
            RandomListNode copy = new RandomListNode(iter.label);
            iter.next = copy;
            copy.next = next;
            iter = next;
        }


        //2. assign random pointers for the copy nodes
        iter = head;
        while(iter != null){
            if(iter.random != null){
                iter.next.random = iter.random.next;
            }
            iter = iter.next.next;
        }

        //3. restore the original list, extract the copy list
        iter = head;
        RandomListNode preHead = new RandomListNode(0);
        RandomListNode copy = preHead;
        RandomListNode copyIter = preHead;
        while(iter != null){
            next = iter.next.next;

            //extract the copy
            copy = iter.next;
            copyIter.next = copy;
            copyIter = copy;

            //restore the original list
            iter.next = next;

            iter = next;
        }

        return preHead.next;
    }
}
