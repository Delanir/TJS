//
//  StoryBoard.m
//  L'Archer
//
//  Created by MiniclipMacBook on 5/15/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "StoryBoard.h"
#import "Utils.h"


@implementation StoryBoard


-(void) setInformation:(int) num inChapter:(int) c
{
#warning plist historia
    NSDictionary * storyInfo = [Utils openPlist:@"story"];
    NSArray* temp = [storyInfo objectForKey:[NSString stringWithFormat:@"chapter%d", c]];
    
    NSString* person = [[temp objectAtIndex:num] objectAtIndex:0];
    [_person setString:person];
    
    NSString* message = [[temp objectAtIndex:num] objectAtIndex:1];
   [_msg setString:message];
    
#warning TODO sprite, desta maneira o peholder mantem-se
     NSString* portrait = [[temp objectAtIndex:num] objectAtIndex:2];
    _portrait =[CCSprite spriteWithFile:portrait];
    _portrait.position = _portrait1.position;
    [self addChild:_portrait z:3000];
    
}




@end
