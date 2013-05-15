//
//  StoryBoard.m
//  L'Archer
//
//  Created by MiniclipMacBook on 5/15/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "StoryBoard.h"


@implementation StoryBoard


- (void) setBoard:(NSString*) message saidBy:(NSString*) person withPortrait:(NSString*)portrait{
    
    [_msg setString:message];
    [_person setString:person];
    _portrait = [CCSprite spriteWithSpriteFrameName:portrait];
    
};


@end
