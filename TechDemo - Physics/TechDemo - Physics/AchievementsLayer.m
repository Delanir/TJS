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

@implementation AchievementsLayer


-(id)init
{
    [super init];
    return self;
}

-(void)dealloc{
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}

-(void)onEnter
{
    
    [super onEnter];
    
    //Initialize art and animations
   // [self addChild:[[SpriteManager shared] addSpritesToSpriteFrameCacheWithFile:@"MenuSpritesheet.plist" andBatchSpriteSheet:@"MenuSpritesheet.png"]];
    
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
//        LevelThumbnail * level = [levelButtons objectAtIndex:i-1];
        AchievementNode * achievement = [Achievements objectAtIndex:i-1];
        
        int achievementState = [[[[GameState shared] achievementStates] objectAtIndex:i-1] intValue];
        NSLog(@"Achievement %d with state %d",i,achievementState);
        if (achievementState == 1) {
            [achievement setIsEnabled:YES];
            [achievement setImage];
            NSLog(@"ENTREI ACHIEVEMENT%d UNLOCK", i);
        } else
            [achievement setIsEnabled:NO];
        [achievement initAchievement];
        [achievement setInformation:i-1];
//        [level setThumbnail:[NSString stringWithFormat:@"level%d.png",i]];
    }
}


- (void)onExit
{
    [self removeAllChildrenWithCleanup:YES];
    [super onExit];
}



- (void) pressedGoToMainMenu:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
    [[GameManager shared] runSceneWithID:kMainMenuScene];
}

@end

