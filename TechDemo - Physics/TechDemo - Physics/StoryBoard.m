//
//  StoryBoard.m
//  L'Archer
//
//  Created by MiniclipMacBook on 5/15/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "StoryBoard.h"
#import "Utils.h"
#import "Registry.h"


@implementation StoryBoard

-(id) init
{
    self = [super init];
#ifdef kDebugMode
    [[Registry shared] addToCreatedEntities:self];
#endif
    return self;
}

-(void) setInformation:(int) num inChapter:(int) c
{
    NSDictionary * storyInfo = [Utils openPlist:@"story"];
    NSArray* temp = [storyInfo objectForKey:[NSString stringWithFormat:@"chapter%d", c]];
    
    NSString* person = [[temp objectAtIndex:num] objectAtIndex:0];
    [_person setString:person];
    
    NSString* message = [[temp objectAtIndex:num] objectAtIndex:1];
    [_msg setString:message];
    
    NSString* portrait = [[temp objectAtIndex:num] objectAtIndex:2];
    _portrait =[CCSprite spriteWithFile:portrait];
    _portrait.position = _portrait1.position;
    [self addChild:_portrait z:3000];
    [_portrait1 setVisible:NO];
    
}

-(void) dealloc
{
#ifdef kDebugMode
    [[Registry shared] addToDestroyedEntities:self];
#endif
    [super dealloc];
}

-(void)onExit
{
    [self removeAllChildrenWithCleanup:YES];
    [super onExit];
}


@end
