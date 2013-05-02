//
//  SkillTreeLayer.m
//  L'Archer
//
//  Created by MiniclipMacBook on 4/16/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "SkillTreeLayer.h"
#import "Registry.h"
#import "GameManager.h"
#import "SimpleAudioEngine.h"
#import "Config.h"
#import "GameState.h"

@implementation SkillTreeLayer

-(void)dealloc
{
    NSLog(@"fui deallocado: skill");
    // [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
    
}

-(void)onEnter
{
    [super onEnter];
    
    NSMutableArray *skill = [[GameState shared] skillStates];
    
    if ([[skill objectAtIndex:0] intValue] == 0) {
        [_iceMainBranch setVisible:NO];
    }
    if ([[skill objectAtIndex:1] intValue] == 1) {
        [_iceElement2 setVisible:NO];
    }
    if ([[skill objectAtIndex:2] intValue] == 2) {
        [_iceElement1 setVisible:NO];
    }
    if ([[skill objectAtIndex:3] intValue] == 3) {
        [_iceElement3 setVisible:NO];
    }
    if ([[skill objectAtIndex:4] intValue] == 4) {
        [_iceBranch3 setVisible:NO];
    }
    if ([[skill objectAtIndex:5] intValue] == 5) {
        [_iceBranch2 setVisible:NO];
    }
    if ([[skill objectAtIndex:6] intValue] == 6) {
        [_iceBranch1 setVisible:NO];
    }
  
    if ([[skill objectAtIndex:7] intValue] == 7) {
        [_cityMainBranch setVisible:NO];
    }
    if ([[skill objectAtIndex:8] intValue] == 8) {
        [_cityElement2 setVisible:NO];
    }
    if ([[skill objectAtIndex:9] intValue] == 9) {
        [_cityElement1 setVisible:NO];
    }
    if ([[skill objectAtIndex:10] intValue] == 10) {
        [_cityElement3 setVisible:NO];
    }
    if ([[skill objectAtIndex:11] intValue] == 11) {
        [_cityBranch3 setVisible:NO];
    }
    if ([[skill objectAtIndex:12] intValue] == 12) {
        [_cityBranch2 setVisible:NO];
    }
    if ([[skill objectAtIndex:13] intValue] == 13) {
        [_cityBranch1 setVisible:NO];
    }
    
    if ([[skill objectAtIndex:14] intValue] == 14) {
        [_fireMainBranch setVisible:NO];
    }
    if ([[skill objectAtIndex:15] intValue] == 15) {
        [_fireElement2 setVisible:NO];
    }
    if ([[skill objectAtIndex:16] intValue] == 16) {
        [_fireElement1 setVisible:NO];
    }
    if ([[skill objectAtIndex:17] intValue] == 17) {
        [_fireElement3 setVisible:NO];
    }
    if ([[skill objectAtIndex:18] intValue] == 18) {
        [_fireBranch3 setVisible:NO];
    }
    if ([[skill objectAtIndex:19] intValue] == 19) {
        [_fireBranch2 setVisible:NO];
    }
    if ([[skill objectAtIndex:20] intValue] == 20) {
        [_fireBranch1 setVisible:NO];
    }
    
    
    [_fireMainBranch setVisible:NO];
    [_fireElement2 setVisible:NO];
    [_fireElement1 setVisible:NO];
    [_fireElement3 setVisible:NO];
    [_fireBranch3 setVisible:NO];
    [_fireBranch2 setVisible:NO];
    [_fireBranch1 setVisible:NO];
    
    [_marksmanMainBranch setVisible:NO];
    [_marksmanElement2 setVisible:NO];
    [_marksmanElement1 setVisible:NO];
    [_marksmanElement3 setVisible:NO];
    [_marksmanBranch3 setVisible:NO];
    [_marksmanBranch2 setVisible:NO];
    [_marksmanBranch1 setVisible:NO];
    
    
    [fireMenu setVisible:NO];
}

- (void) pressedCitySymbol:(id)sender
{
    [_cityMainBranch setVisible:YES];
    [_cityElement2 setVisible:YES];
    [_cityElement1 setVisible:YES];
    [_cityElement3 setVisible:YES];
    [_cityBranch3 setVisible:YES];
    [_cityBranch2 setVisible:YES];
    [_cityBranch1 setVisible:YES];
}

- (void) pressedFireSymbol:(id)sender
{
//    [_fireMainBranch setVisible:YES];
//    [_fireElement2 setVisible:YES];
//    [_fireElement1 setVisible:YES];
//    [_fireElement3 setVisible:YES];
//    [_fireBranch3 setVisible:YES];
//    [_fireBranch2 setVisible:YES];
//    [_fireBranch1 setVisible:YES];
    
    [fireMenu setVisible:YES];
    [fireMenu setZOrder:1000];
}

- (void) pressedMarksmanSymbol:(id)sender
{
    [_marksmanMainBranch setVisible:YES];
    [_marksmanElement2 setVisible:YES];
    [_marksmanElement1 setVisible:YES];
    [_marksmanElement3 setVisible:YES];
    [_marksmanBranch3 setVisible:YES];
    [_marksmanBranch2 setVisible:YES];
    [_marksmanBranch1 setVisible:YES];
}

- (void) pressedIceSymbol:(id)sender
{
    [_iceMainBranch setVisible:YES];
    [_iceElement2 setVisible:YES];
    [_iceElement1 setVisible:YES];
    [_iceElement3 setVisible:YES];
    [_iceBranch3 setVisible:YES];
    [_iceBranch2 setVisible:YES];
    [_iceBranch1 setVisible:YES];
}

- (void) pressedMainMenu:(id)sender
{
   [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
    [[GameManager shared] runSceneWithID:kMainMenuScene];
}

-(void)onExit
{
  
  [[[CCDirector sharedDirector] runningScene] stopAllActions];
  [[[CCDirector sharedDirector] runningScene] unscheduleAllSelectors];
  [self removeAllChildrenWithCleanup:YES];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
  [super onExit];
}




@end
