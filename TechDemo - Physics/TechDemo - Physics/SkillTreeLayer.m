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
#import "ResourceManager.h"
#import "Config.h"
#import "GameState.h"
#import "SpriteManager.h"
#import "Constants.h"
#import "Flurry.h"
//#import "TestFlight.h"

@implementation SkillTreeLayer

@synthesize availableStars;




- (id)init
{
    
    [[SpriteManager shared] addSpritesToSpriteFrameCacheWithFile:@"skillTreeSS.plist" andBatchSpriteSheet:@"skillTreeSS.png"];
    self = [super init];
#ifdef kDebugMode
    [[Registry shared] addToCreatedEntities:self];
#endif
    return self;
}




-(void)onEnter
{
    [super onEnter];
    [[Registry shared] registerEntity:self withName:@"skillTree"];
    [Flurry logEvent:@"Entered SkillTree with Flurry :D Test2!"];
    [Flurry logEvent:@"Entered SkillTree with Flurry!" timed:YES];
//    [TestFlight passCheckpoint:@"SkillTree - Selected"];
    
    
    NSMutableArray *skill = [[GameState shared] skillStates];
    
    availableStars = DEFAULTSKILLPOINTS + [self currentStars] - [self usedStars];
    
    [_numberStars setString:[NSString stringWithFormat:@"%i", availableStars] ];
    
    if ([[skill objectAtIndex:kIceMainBranch] intValue] != 0) {
        [_iceMainBranch setVisible:YES];
    }
    if ([[skill objectAtIndex:kIceElement2] intValue] != 0) {
        [_iceElement2 setVisible:YES];
    }
    if ([[skill objectAtIndex: kIceElement1] intValue] != 0) {
        [_iceElement1 setVisible:YES];
    }
    if ([[skill objectAtIndex:kIceElement3] intValue] != 0) {
        [_iceElement3 setVisible:YES];
    }
    if ([[skill objectAtIndex:kIceBranch3] intValue] != 0) {
        [_iceBranch3 setVisible:YES];
    }
    if ([[skill objectAtIndex:kIceBranch2] intValue] != 0) {
        [_iceBranch2 setVisible:YES];
    }
    if ([[skill objectAtIndex:kIceBranch1] intValue] != 0) {
        [_iceBranch1 setVisible:YES];
    }
    if ([[skill objectAtIndex:kCityMainBranch] intValue] != 0) {
        [_cityMainBranch setVisible:YES];
    }
    if ([[skill objectAtIndex:kCityElement2] intValue] != 0) {
        [_cityElement2 setVisible:YES];
    }
    if ([[skill objectAtIndex:kCityElement1] intValue] != 0) {
        [_cityElement1 setVisible:YES];
    }
    if ([[skill objectAtIndex:kCityElement3] intValue] != 0) {
        [_cityElement3 setVisible:YES];
    }
    if ([[skill objectAtIndex:kCityBranch3] intValue] != 0) {
        [_cityBranch3 setVisible:YES];
    }
    if ([[skill objectAtIndex:kCityBranch2] intValue] != 0) {
        [_cityBranch2 setVisible:YES];
    }
    if ([[skill objectAtIndex:kCityBranch1] intValue] != 0) {
        [_cityBranch1 setVisible:YES];
    }
    if ([[skill objectAtIndex:kFireMainBranch] intValue] != 0) {
        [_fireMainBranch setVisible:YES];
    }
    if ([[skill objectAtIndex:kFireElement2] intValue] != 0) {
        [_fireElement2 setVisible:YES];
    }
    if ([[skill objectAtIndex:kFireElement1] intValue] != 0) {
        [_fireElement1 setVisible:YES];
    }
    if ([[skill objectAtIndex:kFireElement3] intValue] != 0) {
        [_fireElement3 setVisible:YES];
    }
    if ([[skill objectAtIndex:kFireBranch3] intValue] != 0) {
        [_fireBranch3 setVisible:YES];
    }
    if ([[skill objectAtIndex:kFireBranch2 ] intValue] != 0) {
        [_fireBranch2 setVisible:YES];
    }
    if ([[skill objectAtIndex:kFireBranch1] intValue] != 0) {
        [_fireBranch1 setVisible:YES];
    }
    if ([[skill objectAtIndex:kMarksmanMainBranch] intValue] != 0) {
        [_marksmanMainBranch setVisible:YES];
    }
    if ([[skill objectAtIndex:kMarksmanBranch2] intValue] != 0) {
        [_marksmanElement2 setVisible:YES];
    }
    if ([[skill objectAtIndex:kMarksmanBranch1] intValue] != 0) {
        [_marksmanElement1 setVisible:YES];
    }
    if ([[skill objectAtIndex:kMarksmanBranch3] intValue] != 0) {
        [_marksmanElement3 setVisible:YES];
    }
    if ([[skill objectAtIndex:kMarksmanElement3] intValue] != 0) {
        [_marksmanBranch3 setVisible:YES];
    }
    if ([[skill objectAtIndex:kMarksmanElement2] intValue] != 0) {
        [_marksmanBranch2 setVisible:YES];
    }
    if ([[skill objectAtIndex: kMarksmanElement1] intValue] != 0) {
        [_marksmanBranch1 setVisible:YES];
        
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

- (void) resetSkillTree:(id)sender
{
    
    [[GameState shared]  resetSkillStates];
    
    availableStars = DEFAULTSKILLPOINTS + [self currentStars] - [self usedStars];
    
    [_numberStars setString:[NSString stringWithFormat:@"%i", availableStars] ];
    
    [_iceMainBranch setVisible:NO];
    [_iceElement2 setVisible:NO];
    
    [_iceElement1 setVisible:NO];
    [_iceElement3 setVisible:NO];
    [_iceBranch3 setVisible:NO];
    [_iceBranch2 setVisible:NO];
    [_iceBranch1 setVisible:NO];
    [_cityMainBranch setVisible:NO];
    [_cityElement2 setVisible:NO];
    [_cityElement1 setVisible:NO];
    [_cityElement3 setVisible:NO];
    [_cityBranch3 setVisible:NO];
    [_cityBranch2 setVisible:NO];
    [_cityBranch1 setVisible:NO];
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
    [fireMenu setStars];
    [iceMenu setVisible:NO];
    [iceMenu setStars];
    [cityMenu setVisible:NO];
    [cityMenu setStars];
    [marksmanMenu setVisible:NO];
    [marksmanMenu setStars];
    
//    [TestFlight passCheckpoint:@"SkillTree - Reset"];
    
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
#warning not working yet must release all sub-ccbis
    // [self release];
    [[[CCDirector sharedDirector] runningScene] stopAllActions];
    [[[CCDirector sharedDirector] runningScene] unscheduleAllSelectors];
    [self removeAllChildrenWithCleanup:YES];
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFrames];
    [[CCTextureCache sharedTextureCache] removeAllTextures];
    
    
    [Flurry endTimedEvent:@"Entered SkillTree with Flurry!" withParameters:nil];
    
    [super onExit];
}


-(void)dealloc
{
#ifdef kDebugMode
    [[Registry shared] addToDestroyedEntities:self];
#endif
    [super dealloc];
}

///////////////////// UTILITIES

-(int) currentStars
{
    return [[ResourceManager shared] determineSkillPoints];
}

-(int) usedStars{
    int stars=0;
    for (int i = 0; i < [[[GameState shared] skillStates] count]; i++)
        stars = stars + [[[[GameState shared] skillStates] objectAtIndex:i] intValue];
    return stars;
}

-(int) nonUsedStars{
     return DEFAULTSKILLPOINTS + [self currentStars] - [self usedStars];
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
  //          [TestFlight passCheckpoint:@"SkillTree - Fire branch evolution"];
            break;
        case 15:
            [_fireElement2 setVisible:YES];
   //         [TestFlight passCheckpoint:@"SkillTree - Fire branch evolution"];
            
            break;
        case 16:
            [_fireElement1 setVisible:YES];
    //        [TestFlight passCheckpoint:@"SkillTree - Fire branch evolution"];
            break;
        case 17:
            [_fireElement3 setVisible:YES];
    //        [TestFlight passCheckpoint:@"SkillTree - Fire branch evolution"];
            break;
        case 18:
            [_fireBranch3 setVisible:YES];
     //       [TestFlight passCheckpoint:@"SkillTree - Fire branch evolution"];
            break;
        case 19:
            [_fireBranch2 setVisible:YES];
    //        [TestFlight passCheckpoint:@"SkillTree - Fire branch evolution"];
            break;
        case 20:
            [_fireBranch1 setVisible:YES];
     //       [TestFlight passCheckpoint:@"SkillTree - Fire branch evolution"];
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
      //      [TestFlight passCheckpoint:@"SkillTree - Ice branch evolution"];
            break;
        case 1:
            [_iceElement2 setVisible:YES];
        //    [TestFlight passCheckpoint:@"SkillTree - Ice branch evolution"];
            
            break;
        case 2:
            [_iceElement1 setVisible:YES];
          //  [TestFlight passCheckpoint:@"SkillTree - Ice branch evolution"];
            break;
        case 3:
            [_iceElement3 setVisible:YES];
           // [TestFlight passCheckpoint:@"SkillTree - Ice branch evolution"];
            break;
        case 4:
            [_iceBranch3 setVisible:YES];
           // [TestFlight passCheckpoint:@"SkillTree - Ice branch evolution"];
            break;
        case 5:
            [_iceBranch2 setVisible:YES];
          //  [TestFlight passCheckpoint:@"SkillTree - Ice branch evolution"];
            break;
        case 6:
            [_iceBranch1 setVisible:YES];
         //   [TestFlight passCheckpoint:@"SkillTree - Ice branch evolution"];
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
       //     [TestFlight passCheckpoint:@"SkillTree - City branch evolution"];
            break;
        case 8:
            [_cityElement2 setVisible:YES];
         //   [TestFlight passCheckpoint:@"SkillTree - City branch evolution"];
            
            break;
        case 9:
            [_cityElement1 setVisible:YES];
         //   [TestFlight passCheckpoint:@"SkillTree - City branch evolution"];
            break;
        case 10:
            [_cityElement3 setVisible:YES];
         //   [TestFlight passCheckpoint:@"SkillTree - City branch evolution"];
            break;
        case 11:
            [_cityBranch3 setVisible:YES];
           // [TestFlight passCheckpoint:@"SkillTree - City branch evolution"];
            break;
        case 12:
            [_cityBranch2 setVisible:YES];
           // [TestFlight passCheckpoint:@"SkillTree - City branch evolution"];
            break;
        case 13:
            [_cityBranch1 setVisible:YES];
           // [TestFlight passCheckpoint:@"SkillTree - City branch evolution"];
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
     //       [TestFlight passCheckpoint:@"SkillTree - Marksman branch evolution"];
            break;
        case 22:
            [_marksmanElement2 setVisible:YES];
       //     [TestFlight passCheckpoint:@"SkillTree - Marksman branch evolution"];
            
            break;
        case 23:
            [_marksmanElement1 setVisible:YES];
         //   [TestFlight passCheckpoint:@"SkillTree - Marksman branch evolution"];
            break;
        case 24:
            [_marksmanElement3 setVisible:YES];
           // [TestFlight passCheckpoint:@"SkillTree - Marksman branch evolution"];
            break;
        case 25:
            [_marksmanBranch3 setVisible:YES];
          //  [TestFlight passCheckpoint:@"SkillTree - Marksman branch evolution"];
            break;
        case 26:
            [_marksmanBranch2 setVisible:YES];
         //   [TestFlight passCheckpoint:@"SkillTree - Marksman branch evolution"];
            break;
        case 27:
            [_marksmanBranch1 setVisible:YES];
         //   [TestFlight passCheckpoint:@"SkillTree - Marksman branch evolution"];
            break;
        default:
            break;
    }
    
}


- (void) pressedPlay:(id)sender{
    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
    [[GameManager shared] runSceneWithID:kSelectLevel];
};


@end
