//
//  AchievementsLayer.m
//  L'Archer
//
//  Created by João Amaral on 3/5/13.
//
//

#import "AchievementsLayer.h"
#import "SpriteManager.h"
#import "SimpleAudioEngine.h"
#import "Config.h"
#import "GameManager.h"
#import "GameState.h"
#import "Registry.h"

@implementation AchievementsLayer


-(id)init
{
    [super init];
#ifdef kDebugMode
    [[Registry shared] addToCreatedEntities:self];
#endif
    return self;
}

-(void)dealloc
{
#ifdef kDebugMode
    [[Registry shared] addToDestroyedEntities:self];
#endif
    [super dealloc];
}

-(void)onEnter
{
    
    [super onEnter];
    
    //Initialize art and animations
    [self addChild:[[SpriteManager shared] addSpritesToSpriteFrameCacheWithFile:@"MenuSpritesheet.plist" andBatchSpriteSheet:@"MenuSpritesheet.png"]];
    [self addChild:[[SpriteManager shared] addSpritesToSpriteFrameCacheWithFile:@"AchievementsSpritesheet.plist" andBatchSpriteSheet:@"AchievementsSpritesheet.png"]];
    
    Achievements = [[CCArray alloc] init];
    [Achievements addObject:_achievement1];
    [Achievements addObject:_achievement2];
    [Achievements addObject:_achievement3];
    [Achievements addObject:_achievement4];
    [Achievements addObject:_achievement5];
    [Achievements addObject:_achievement6];
    [Achievements addObject:_achievement7];
    [Achievements addObject:_achievement8];
    [Achievements addObject:_achievement9];
    [Achievements addObject:_achievement10];
    [Achievements addObject:_achievement11];
    [Achievements addObject:_achievement12];
    [Achievements addObject:_achievement13];
    [Achievements addObject:_achievement14];
    [Achievements addObject:_achievement15];
    
    for (int i = 1; i <= [Achievements count]; i++)
    {
        AchievementNode * achievement = [Achievements objectAtIndex:i-1];
        
        int achievementState = [[[[GameState shared] achievementStates] objectAtIndex:i-1] intValue];
        if (achievementState == 1) {
            [achievement setIsEnabled:YES];
            [achievement setImage:[NSString stringWithFormat:@"achievement%d.png",i]];
        } else
            [achievement setIsEnabled:NO];
        [achievement initAchievement];
        [achievement setInformation:i-1];
//        [level setThumbnail:[NSString stringWithFormat:@"level%d.png",i]];
    }
}


- (void)onExit
{
    [self release];
    [[[CCDirector sharedDirector] runningScene] stopAllActions];
    [[[CCDirector sharedDirector] runningScene] unscheduleAllSelectors];
    [self removeAllChildrenWithCleanup:YES];
    //[[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    //[[CCTextureCache sharedTextureCache] removeAllTextures];
    [super onExit];
}



- (void) pressedGoToMainMenu:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
    [[GameManager shared] runSceneWithID:kMainMenuScene];
}

@end

