//
//  LinkedListNode.m
//  LinkedList
//
//  Created by Rahul Aru on 9/14/16.
//  Copyright © 2016 Rahul Deb Aru. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Node.h"


@implementation Node


- (id) initWithData:(id)theData {
    if (self = [super init]) {
        _data = [theData copy];
        _next = nil;
        _prev = nil;
    }
    return self;
}

@end
