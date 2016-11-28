/*148. Sort List  QuestionEditorial Solution  My Submissions
Total Accepted: 81557
Total Submissions: 310757
Difficulty: Medium
Sort a linked list in O(n log n) time using constant space complexity.

Subscribe to see which companies asked this question*/



/*merge sort
1. divide the list into two halves
2. seperately sort each half
3. merge two parts*/

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
    ListNode* sortList(ListNode* head) {
        if(head==NULL || head->next==NULL) return head;
        
        ListNode* half = head->next->next;
        ListNode* begin = head;
        
        while(half!=NULL && half->next!=NULL){
            half = half->next->next;
            begin = begin->next;
        }
        
        ListNode* h2 = sortList(begin->next);
        begin->next = NULL;
        
        return merge(sortList(head), h2);
    }
    
    ListNode* merge(ListNode* h1, ListNode* h2){
        ListNode temp(INT_MIN);  //no "*"
        ListNode* cur = &temp;   //add "&"
        
        while(h1!=NULL && h2!=NULL){
            if(h1->val < h2->val){
                cur->next = h1;
                h1 = h1->next;
            } else {
                cur->next = h2;
                h2 = h2->next;
            }
            cur = cur->next;
        }
        
        if(h1 != NULL) cur->next = h1;
        if(h2 != NULL) cur->next = h2;
        
        return temp.next;  //"use ."
    }
};




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
    public ListNode sortList(ListNode head) {
        if(head==null || head.next==null) return head;
        
        ListNode half = head.next.next;
        ListNode begin = head;
        
        while(half!=null && half.next!=null){
            begin = begin.next;
            half = half.next.next;
        }
        
        ListNode h2 = sortList(begin.next);
        begin.next = null;
        
        return merge(sortList(head), h2);
    }
    
    public ListNode merge(ListNode h1, ListNode h2){
        ListNode temp = new ListNode(Integer.MIN_VALUE);
        ListNode cur = temp;
        
        while(h1!=null && h2!=null){
            if(h1.val < h2.val){
                cur.next = h1;
                h1 = h1.next;
            } else {
                cur.next = h2;
                h2 = h2.next;
            }
            cur = cur.next;
        }
        
        if(h1!=null){
            cur.next = h1;
        }
        
        if(h2!=null){
            cur.next = h2;
        }
        
        return temp.next;
    }
}
