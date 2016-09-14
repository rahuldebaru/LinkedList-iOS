//
//  LinkedListNode.h
//  LinkedList
//
//  Created by Rahul Aru on 9/14/16.
//  Copyright © 2016 Rahul Deb Aru. All rights reserved.
//

#ifndef LinkedListNode_h
#define LinkedListNode_h

#import <Foundation/Foundation.h>

@interface Node : NSObject {
    
}

@property (nonatomic, strong) id data;
@property (nonatomic, strong) Node *next;
@property (nonatomic, strong) Node *prev;

- (id) initWithData:(id)theData;

@end

#endif /* LinkedListNode_h */
