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
#import "SpriteManager.h"

@implementation SkillTreeLayer

@synthesize availableStars;

#define DEFAULTPOINTS 18


- (id)init
{
    [[SpriteManager shared] addSpritesToSpriteFrameCacheWithFile:@"skillTreeSS.plist" andBatchSpriteSheet:@"skillTreeSS.png"];
    self = [super init];
    return self;
}


-(void)onEnter
{
    [super onEnter];
    
    NSMutableArray *skill = [[GameState shared] skillStates];
    
    availableStars = DEFAULTPOINTS + [self currentStars] - [self usedStars];
    
    [_numberStars setString:[NSString stringWithFormat:@"%i", availableStars] ];
    
    if ([[skill objectAtIndex:0] intValue] != 0) {
        [_iceMainBranch setVisible:YES];
    }
    if ([[skill objectAtIndex:1] intValue] != 0) {
        [_iceElement2 setVisible:YES];
    }
    if ([[skill objectAtIndex:2] intValue] != 0) {
        [_iceElement1 setVisible:YES];
    }
    if ([[skill objectAtIndex:3] intValue] != 0) {
        [_iceElement3 setVisible:YES];
    }
    if ([[skill objectAtIndex:4] intValue] != 0) {
        [_iceBranch3 setVisible:YES];
    }
    if ([[skill objectAtIndex:5] intValue] != 0) {
        [_iceBranch2 setVisible:YES];
    }
    if ([[skill objectAtIndex:6] intValue] != 0) {
        [_iceBranch1 setVisible:YES];
    }
    if ([[skill objectAtIndex:7] intValue] != 0) {
        [_cityMainBranch setVisible:YES];
    }
    if ([[skill objectAtIndex:8] intValue] != 0) {
        [_cityElement2 setVisible:YES];
    }
    if ([[skill objectAtIndex:9] intValue] != 0) {
        [_cityElement1 setVisible:YES];
    }
    if ([[skill objectAtIndex:10] intValue] != 0) {
        [_cityElement3 setVisible:YES];
    }
    if ([[skill objectAtIndex:11] intValue] != 0) {
        [_cityBranch3 setVisible:YES];
    }
    if ([[skill objectAtIndex:12] intValue] != 0) {
        [_cityBranch2 setVisible:YES];
    }
    if ([[skill objectAtIndex:13] intValue] != 0) {
        [_cityBranch1 setVisible:YES];
    }
    if ([[skill objectAtIndex:14] intValue] != 0) {
        [_fireMainBranch setVisible:YES];
    }
    if ([[skill objectAtIndex:15] intValue] != 0) {
        [_fireElement2 setVisible:YES];
    }
    if ([[skill objectAtIndex:16] intValue] != 0) {
        [_fireElement1 setVisible:YES];
    }
    if ([[skill objectAtIndex:17] intValue] != 0) {
        [_fireElement3 setVisible:YES];
    }
    if ([[skill objectAtIndex:18] intValue] != 0) {
        [_fireBranch3 setVisible:YES];
    }
    if ([[skill objectAtIndex:19] intValue] != 0) {
        [_fireBranch2 setVisible:YES];
    }
    if ([[skill objectAtIndex:20] intValue] != 0) {
        [_fireBranch1 setVisible:YES];
    }
    if ([[skill objectAtIndex:21] intValue] != 0) {
        [_marksmanMainBranch setVisible:NO];
    }
    if ([[skill objectAtIndex:22] intValue] != 0) {
        [_marksmanElement2 setVisible:NO];
    }
    if ([[skill objectAtIndex:23] intValue] != 0) {
        [_marksmanElement1 setVisible:NO];
    }
    if ([[skill objectAtIndex:24] intValue] != 0) {
        [_marksmanElement3 setVisible:NO];
    }
    if ([[skill objectAtIndex:25] intValue] != 0) {
        [_marksmanBranch3 setVisible:NO];
    }
    if ([[skill objectAtIndex:26] intValue] != 0) {
        [_marksmanBranch2 setVisible:NO];
    }
    if ([[skill objectAtIndex:27] intValue] != 0) {
        [_marksmanBranch1 setVisible:NO];
    }
    
    [fireMenu setVisible:NO];
    [fireMenu setStars];
    [iceMenu setVisible:NO];
    [iceMenu setStars];
    [cityMenu setVisible:NO];
    [cityMenu setStars];
    [marksmanMenu setVisible:NO];
    [marksmanMenu setStars];
    
}

- (void) pressedCitySymbol:(id)sender
{
    if ([cityMenu visible]) {
        [cityMenu setVisible:NO];
    }else{
        [fireMenu setVisible:NO];
        [iceMenu setVisible:NO];
        [marksmanMenu setVisible:NO];
        [cityMenu setVisible:YES];
        [cityMenu setZOrder:1003];
    }
}

- (void) pressedFireSymbol:(id)sender
{
 
    if ([fireMenu visible]) {
        [fireMenu setVisible:NO];
    }else{
        [fireMenu setVisible:YES];
        [iceMenu setVisible:NO];
        [marksmanMenu setVisible:NO];
        [cityMenu setVisible:NO];
        [fireMenu setZOrder:1000];
    }
    
}

- (void) pressedMarksmanSymbol:(id)sender
{
    if ([marksmanMenu visible]) {
        [marksmanMenu setVisible:NO];
    }else{
        [fireMenu setVisible:NO];
        [iceMenu setVisible:NO];
        [marksmanMenu setVisible:YES];
        [cityMenu setVisible:NO];
        [marksmanMenu setZOrder:1002];
    }
}

- (void) pressedIceSymbol:(id)sender
{
    if ([iceMenu visible]) {
        [iceMenu setVisible:NO];
    }else{
        [iceMenu setVisible:YES];
        [fireMenu setVisible:NO];
        [marksmanMenu setVisible:NO];
        [cityMenu setVisible:NO];
        [iceMenu setZOrder:1001];
    }
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
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFrames];
    [[CCTextureCache sharedTextureCache] removeAllTextures];
  [super onExit];
}

-(void)dealloc
{
    NSLog(@"fui deallocado: skill");
    // [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
    
}

///////////////////// UTILITIES

-(int) currentStars{
    int stars=0;
    int totalStars =[[[GameState shared] starStates] count];
    int aux;
    for (int i = 1; i <= totalStars; i++)
    {
        
        aux =[[[[GameState shared] starStates] objectAtIndex:i-1] intValue];
        stars = stars + aux;
        
    }
    return stars;
}

-(int) usedStars{
    int stars=0;
    for (int i = 1; i <= [[[GameState shared] skillStates] count]; i++)
    {
        
        stars = stars + [[[[GameState shared] skillStates] objectAtIndex:i-1] intValue];
        
    }
    return stars;
}

- (void) decreaseAvailableStarsBy: (int) stars{
    [self setAvailableStars:availableStars - stars];
    [_numberStars setString:[NSString stringWithFormat:@"%i", availableStars] ];
}

- (void) switchFire: (int)index withStarCost:(int)star
{
    
    NSMutableArray *skill = [[GameState shared] skillStates];
    
    [skill replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:star]];
    
    switch (index) {
        case 14:
            [_fireMainBranch setVisible:YES];
            break;
        case 15:
            [_fireElement2 setVisible:YES];
            
            break;
        case 16:
            [_fireElement1 setVisible:YES];
            break;
        case 17:
            [_fireElement3 setVisible:YES];
            break;
        case 18:
            [_fireBranch3 setVisible:YES];
            break;
        case 19:
            [_fireBranch2 setVisible:YES];
            break;
        case 20:
            [_fireBranch1 setVisible:YES];
            break;
        default:
            break;
    }
    
}

- (void) switchIce: (int)index withStarCost:(int)star
{
    
    NSMutableArray *skill = [[GameState shared] skillStates];
    
    [skill replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:star]];
    
    switch (index) {
        case 0:
            [_iceMainBranch setVisible:YES];
            break;
        case 1:
            [_iceElement2 setVisible:YES];
            
            break;
        case 2:
            [_iceElement1 setVisible:YES];
            break;
        case 3:
            [_iceElement3 setVisible:YES];
            break;
        case 4:
            [_iceBranch3 setVisible:YES];
            break;
        case 5:
            [_iceBranch2 setVisible:YES];
            break;
        case 6:
            [_iceBranch1 setVisible:YES];
            break;
        default:
            break;
    }
    
}

- (void) switchCity: (int)index withStarCost:(int)star
{
    
    NSMutableArray *skill = [[GameState shared] skillStates];
    
    [skill replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:star]];
    
    switch (index) {
        case 7:
            [_cityMainBranch setVisible:YES];
            break;
        case 8:
            [_cityElement2 setVisible:YES];
            
            break;
        case 9:
            [_cityElement1 setVisible:YES];
            break;
        case 10:
            [_cityElement3 setVisible:YES];
            break;
        case 11:
            [_cityBranch3 setVisible:YES];
            break;
        case 12:
            [_cityBranch2 setVisible:YES];
            break;
        case 13:
            [_cityBranch1 setVisible:YES];
            break;
        default:
            break;
    }
    
}

- (void) switchMarksman:(int)index withStarCost:(int)star
{
    
    NSMutableArray *skill = [[GameState shared] skillStates];
    
    [skill replaceObjectAtIndex:index withObject:[NSNumber numberWithInt:star]];
    
    switch (index) {
        case 21:
            [_marksmanMainBranch setVisible:YES];
            break;
        case 22:
            [_marksmanElement2 setVisible:YES];
            
            break;
        case 23:
            [_marksmanElement1 setVisible:YES];
            break;
        case 24:
            [_marksmanElement3 setVisible:YES];
            break;
        case 25:
            [_marksmanBranch3 setVisible:YES];
            break;
        case 26:
            [_marksmanBranch2 setVisible:YES];
            break;
        case 27:
            [_marksmanBranch1 setVisible:YES];
            break;
        default:
            break;
    }
    
}


@end
