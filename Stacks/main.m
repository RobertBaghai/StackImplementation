//
//  main.m
//  Stacks
//
//  Created by Robert Baghai on 5/13/16.
//  Copyright © 2016 Robert Baghai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct Node {
    char data;
    struct Node *nextNode;
} Node;

struct Node *top;     //represents top
struct Node *topOfStack; //tracks what top points to

void stackOverFlow();
void createTop();
void push(char data);
void pop();
void traverseStack();
BOOL stackIsEmpty ();
BOOL stringHasBalancedParenthesis(char *string);


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        top     = NULL;
        topOfStack = NULL;
        createTop();
        
        if (stringHasBalancedParenthesis("()"))
            NSLog(@"Balanced!!");
        else
            NSLog(@"Not balanced!!");
        
    }
    return 0;
}

/*
 *Creates the top(head) for the list
 *Top will point to NULL for list termination
 *topOfStack will be used to track whatever top points to
*/
void createTop() {
    top = (Node *)malloc(sizeof(Node));
    top->nextNode = NULL;
    topOfStack = top->nextNode;
}

/*
 *creates a new node for top to point to
 *assigns new node data from parameter
 *that new node will point to what top previously pointed to
 *topOfStack will be reset to the new node that top points to
*/
void push(char data) {
    if (top != NULL) {
        top->nextNode = (Node *)malloc(sizeof(Node));
        top->nextNode->data = data;
        top->nextNode->nextNode = topOfStack;
        topOfStack = top->nextNode;
    }
}

/*
 *changes the value that top points to, to the node that topOfStack points to
 *re-assigns topOfStack to the new node that top points to
*/
void pop() {
    if (top->nextNode != NULL) {
        top->nextNode = topOfStack->nextNode;
        topOfStack = top->nextNode;
    }
}

/*
    *Checks if stack is empty, if empty return true, else return false
*/
BOOL stackIsEmpty (){
    return (top->nextNode == NULL) ? true : false;
}

/*
    *Helper method to iterate through the stack to check the data in all of the nodes in the stack
*/
void traverseStack() {
    if (top != NULL) {
        Node *ptr = top->nextNode;
        while (ptr != NULL) {
            NSLog(@"%c",ptr->data);
            ptr = ptr->nextNode;
        }
    }
}

/*
    *Iterates through string.. if char at index i opening paranthesis, push it to the stack
    *Else if char at index is closing parenthesis, I check if the stack is empty, or if the element at the top of the stack is not its opening counterpart, it is not balanced
    *If the stack is not empty and the element at the top of the stack is it's counterpart, then we pop the opening parenthesis off the stack
*/

BOOL stringHasBalancedParenthesis(char *string) {
    NSInteger length = strlen(string);
    for (int i = 0; i < length; i++) {
        if (string[i] == '(') {
            push(string[i]);
        } else if (string[i] == ')') {
            if (stackIsEmpty() || top->nextNode->data != '(') {
                return false;
            } else {
                pop();
            }
        }
    }
    return (stackIsEmpty() ) ? true : false;
}


/*
    *Do not call this method unless you want to cause a stack overflow
*/
void stackOverFlow() {
    NSLog(@"Oops!");
    stackOverFlow();
}
