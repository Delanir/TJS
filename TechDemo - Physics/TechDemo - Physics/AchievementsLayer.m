//
//  AchievementsLayer.m
//  L'Archer
//
//  Created by João Amaral on 3/5/13.
//
//

#import "AchievementsLayer.h"

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
    
//    int prevStars = 0;
//    for (int i = 1; i <= [Achievements count]; i++)
//    {
//        LevelThumbnail * level = [Achievements objectAtIndex:i-1];
//        [level setLevel:i];
//        int stateStars = [[[[GameState shared] achievementsStates] objectAtIndex:i-1] intValue];
//        [level setNumberStars:stateStars];
//        if ((stateStars > 0 || i == 1 || prevStars > 0) && i <= 10) {// Hardcoded stuff for now
//            [level setIsEnabled:YES];
//            prevStars = stateStars;
//        } else
//            [level setIsEnabled:NO];
//        [level initLevel];
//        [level setThumbnail:[NSString stringWithFormat:@"level%d.png",i]];
//    }
}


- (void)onExit
{
    [self removeAllChildrenWithCleanup:YES];
    [super onExit];
}





- (void) pressedGoToMainMenu:(id)sender
{
    //[[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
    //[[GameManager shared] runSceneWithID:kMainMenuScene];
}

@end

