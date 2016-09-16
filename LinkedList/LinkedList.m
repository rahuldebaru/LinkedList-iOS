//
//  LinkedList.m
//  LinkedList
//
//  Created by Rahul Aru on 9/14/16.
//  Copyright © 2016 Rahul Deb Aru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LinkedList.h"

@interface LinkedList() {

    Node *head;
    Node *tail;
    int nodeCount;
}

@end

@implementation LinkedList

- (id) init {
    if (self = [super init]) {
        head = NULL;
        tail = NULL;
        nodeCount=0;
    }
    return self;
}

- (Node*) getHead {
    return head;
}

- (Node*) getTail {
    return tail;
}

// add to end of list
- (BOOL) add:(id)element {
    if(!element)
        return NO;
    Node *node = [[Node alloc] initWithData:element];
        
    if (head == NULL) {
        head = node;
    }
    
    if (tail != NULL) {
        tail.next = node;
        node.prev = tail;
    }
    ++nodeCount;
    tail = node;
    if(node)
        return YES;
    return NO;
}

- (BOOL) add:(id)element afterNode:(Node*)node {
    if(!element || !node)
        return NO;
    Node *newNode = [[Node alloc] initWithData:element];
    
    if (node == nil) {
        // new node becomes the head
        Node *oldHead = head;
        head = newNode;
        
        // forward links
        head.next = oldHead;
        if (oldHead != nil) {
            oldHead.prev = head;
        }
    }
    else {
        Node *newNextNode = [node next];
        
        // back links
        node.next = newNode;
        newNode.prev = node;
        
        // forward links
        newNode.next = newNextNode;
        if (newNextNode != nil) {
            newNextNode.prev = newNode;
        }
        else {
            // move tail if there is no next node
            tail = newNode;
        }
    }
    ++nodeCount;
    if(newNode)
        return YES;
    return NO;
}

// remove given Node
- (BOOL) remove:(Node*)node {
    
    if(!node)
        return NO;
    
    Node *prev = node.prev;
    Node *next = node.next;
    
    // element is head
    if (prev == NULL && next != NULL) {
        next.prev = NULL;
        head = next;
    }
    // element is tail
    else if (prev != NULL && next == NULL) {
        prev.next = NULL;
        tail = prev;
    }
    // element is in the middle
    else if (prev != NULL && next != NULL) {
        next.prev = prev;
        prev.next = next;
    }
    // element is the only element
    else {
        head = NULL;
        tail = NULL;
    }
    
    --nodeCount;
    node = nil;
    return YES;
}

// remove given Node
- (BOOL) removeNodeAtPosition:(long)position {
    
    if(!nodeCount || nodeCount < position)
        return NO;
    Node *n = head;
    int i = 0;
    while(i < position-1)
    {
        n = n.next;
        i++;
    }
    return [self remove:n];
}


- (BOOL) removeFirst:(id)element {
    for (Node *n=head; n != NULL; n = n.next) {
        if (n.data == element) {
            return [self remove:n];
        }
    }
    return NO;
}

- (void) clear {
    Node *n = head;
    while (n != NULL) {
        Node *nodeToRemove = n;
        n = n.next;
        [self remove:nodeToRemove];
    }
}

- (void) dealloc {
    Node *n = head;
    while (n != NULL) {
        Node *nodeToDealloc = n;
        n = n.next;
        nodeToDealloc = nil;
    }
}

- (int) count {
    return nodeCount;
}

- (Node*) getNodeAtPosition:(long)position {
    
    if(!nodeCount || nodeCount < position || position < 0)
        return nil;
    Node *n = head;
    int i = 0;
    while(i < position-1)
    {
        n = n.next;
        i++;
    }
    return n;
}

- (BOOL) insert:(id)element atPosition:(long)position {

    if(nodeCount && nodeCount+1 < position)
        return NO;

    if(position == nodeCount+1)
    {
        [self add:element];
        return YES;
    }
    
    Node *n = head;
    int i = 0;
    while(i < position-1)
    {
        n = n.next;
        i++;
    }
    
    if(n)
    {
        Node *newNode = [[Node alloc] initWithData:element];
        // Adjust Head and Tail if required
        if(n==head)
        {
            newNode.next = head;
            head.prev = newNode;
            head = newNode;
        }
        else
        {
            Node *newNode = [[Node alloc] initWithData:element];
            newNode.prev = n.prev;
            newNode.next = n;
            newNode.prev.next = newNode;
            newNode.next.prev = newNode;
        }
        
        ++nodeCount;
        return YES;
    }
    return NO;
}

@end
