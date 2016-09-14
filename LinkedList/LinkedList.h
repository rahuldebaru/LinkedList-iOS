//
//  LinkedList.h
//  LinkedList
//
//  Created by Rahul Aru on 9/14/16.
//  Copyright © 2016 Rahul Deb Aru. All rights reserved.
//

#ifndef LinkedList_h
#define LinkedList_h

#import <Foundation/Foundation.h>
#import "Node.h"

@interface LinkedList : NSObject {
    
}

- (Node*) getHead;
- (Node*) getTail;

// get node at specified position
- (Node*) getNodeAtPosition:(int)pos;

// add to end of list
- (void) add:(id)element;

// add after specified node
- (void) add:(id)element afterNode:(Node*)node;

// insert node at specified position
- (BOOL) insert:(id)element atPosition:(int)pos;

// remove given Node
- (void) remove:(Node*)node;

// remove first occurance of given data object id
- (void) removeFirst:(id)element;

// removes all nodes
- (void) clear;

// number of elements
- (int) count;

@end

#endif /* LinkedList_h */
