/*
21. Merge Two Sorted Lists  QuestionEditorial Solution  My Submissions
Total Accepted: 160653 Total Submissions: 432490 Difficulty: Easy
Merge two sorted linked lists and return it as a new list. The new list should be made by splicing together the nodes of the first two lists.

Hide Company Tags Amazon LinkedIn Apple Microsoft
Hide Tags Linked List
Hide Similar Problems (H) Merge k Sorted Lists (E) Merge Sorted Array (M) Sort List (M) Shortest Word Distance II
*/



/*O(n) time
recursive merge the element*/

/////////////////////////////////////////////////////////////////////////////////////
//C++
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */
class Solution {
public:
    ListNode* mergeTwoLists(ListNode* l1, ListNode* l2) {
        if(l1 == NULL) return l2;
        if(l2 == NULL) return l1;
        
        if(l1->val < l2->val){
            l1->next = mergeTwoLists(l1->next,l2);
            return l1;
        }
        else {
            l2->next = mergeTwoLists(l2->next,l1);
            return l2;
        }
    }
};





/*O(n) time
set a head listnode and cur listnode to help build the new list*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
public class Solution {
    public ListNode mergeTwoLists(ListNode l1, ListNode l2) {
        if(l1==null) return l2;
        if(l2==null) return l1;
        
        ListNode head = null;
        ListNode cur = null;
        while(l1!=null && l2!=null){
            if(l1.val <= l2.val){
                if(cur==null){
                    cur = l1;
                } else {
                    cur.next = l1;
                }
                
                if(head==null){
                    head = cur;
                } else {
                    cur = cur.next;
                }
                
                l1 = l1.next;
            } else {
                if(cur==null){
                    cur = l2;
                } else {
                    cur.next = l2;
                }
                
                if(head==null){
                    head = cur;
                } else {
                    cur = cur.next;
                }
                
                l2 = l2.next;
            }
        }
        
        if(l2!=null) l1 = l2;
        cur.next = l1;
        return head;
    }
}