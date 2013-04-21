//
//  NSMutableArray+QueueAdditions.h
//  L'Archer
//
//  Created by jp on 18/04/13.
//
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (QueueAdditions)
- (id) dequeue;
- (void) enqueue:(id)obj;
@end