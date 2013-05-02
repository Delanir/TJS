//
//  LevelSelectLayer.m
//  L'Archer
//
//  Created by João Amaral on 20/4/13.
//
//

#import "LevelSelectLayer.h"
#import "SpriteManager.h"
#import "SimpleAudioEngine.h"
#import "Config.h"
#import "GameManager.h"
#import "GameState.h"



@implementation LevelSelectLayer

-(id)init
{
    [super init];
    return self;
}

-(void)dealloc{
    [self removeAllChildrenWithCleanup:YES];
#warning acho que ]e suposto fazer este release aqui
    [levelButtons release];
    [super dealloc];
}

-(void)onEnter
{
    
    [super onEnter];
    
    //Initialize art and animations
    [self addChild:[[SpriteManager shared] addSpritesToSpriteFrameCacheWithFile:@"MenuSpritesheet.plist" andBatchSpriteSheet:@"MenuSpritesheet.png"]];
    
    levelButtons = [[CCArray alloc] init];
    [levelButtons addObject:_level1];
    [levelButtons addObject:_level2];
    [levelButtons addObject:_level3];
    [levelButtons addObject:_level4];
    [levelButtons addObject:_level5];
    [levelButtons addObject:_level6];
    [levelButtons addObject:_level7];
    [levelButtons addObject:_level8];
    [levelButtons addObject:_level9];
    [levelButtons addObject:_level10];
    
    int prevStars = 0;
    for (int i = 1; i <= [levelButtons count]; i++)
    {
        LevelThumbnail * level = [levelButtons objectAtIndex:i-1];
        [level setLevel:i];
        int stateStars = [[[[GameState shared] starStates] objectAtIndex:i-1] intValue];
        [level setNumberStars:stateStars];
        if ((stateStars > 0 || i == 1 || prevStars > 0) && i <= 10) {// Hardcoded stuff for now
            [level setIsEnabled:YES];
            prevStars = stateStars;
        } else
            [level setIsEnabled:NO];
        [level initLevel];
        [level setThumbnail:[NSString stringWithFormat:@"level%d.png",i]];
        
    }
    
    
}






- (void) pressedGoToMainMenu:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
    [[GameManager shared] runSceneWithID:kMainMenuScene];
}

@end
