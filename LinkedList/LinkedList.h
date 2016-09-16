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
- (Node*) getNodeAtPosition:(long)position;

// add to end of list
- (BOOL) add:(id)element;

// add after specified node
- (BOOL) add:(id)element afterNode:(Node*)node;

// insert node at specified position
- (BOOL) insert:(id)element atPosition:(long)position;

// remove given Node
- (BOOL) remove:(Node*)node;

// remove Node at given Position
- (BOOL) removeNodeAtPosition:(long)position;

// remove first occurance of given data object id
- (BOOL) removeFirst:(id)element;

// removes all nodes
- (void) clear;

// number of elements
- (int) count;

@end

#endif /* LinkedList_h */
