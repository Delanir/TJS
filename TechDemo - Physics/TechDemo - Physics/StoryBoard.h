//
//  StoryBoard.h
//  L'Archer
//
//  Created by MiniclipMacBook on 5/15/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface StoryBoard : CCNode {
    CCSprite *_portrait;
    CCLabelTTF *_msg;
    CCLabelTTF *_person;
    
    
    
}

- (void) setBoard:(NSString*) message saidBy:(NSString*) person withPortrait:(NSString*)portrait;

@end
