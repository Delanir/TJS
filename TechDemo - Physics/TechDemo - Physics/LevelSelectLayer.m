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


@implementation LevelSelectLayer

-(id)init
{
    [super init];
    return self;
}

-(void)dealloc{
    [super dealloc];
    [self removeAllChildrenWithCleanup:YES];
}

-(void)onEnter
{
    [super onEnter];
    
    //Initialize art and animations
    [self addChild:[[SpriteManager shared] addSpritesToSpriteFrameCacheWithFile:@"lvl1spritesheet.plist" andBatchSpriteSheet:@"lvl1spritesheet.png"]];
    
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
    
    for (int i = 1; i <= 10; i++)
    {
        LevelThumbnail * level = [levelButtons objectAtIndex:i-1];
        [level setLevel:i];
        [level setNumberStars:0];
        if (i < 6) // Hardcoded stuff for now
            [level setIsEnabled:YES];
        else
            [level setIsEnabled:NO];
        [level initLevel];
        [level setThumbnail:[NSString stringWithFormat:@"level%d.png",i]];
    }
    
    [[SpriteManager shared] addAnimationFromFile:@"peasant_anim.plist"];
    [[SpriteManager shared] addAnimationFromFile:@"fairiedragon_anim.plist"];
    [[SpriteManager shared] addAnimationFromFile:@"zealot_anim.plist"];
    [[SpriteManager shared] addAnimationFromFile:@"yurie_anim.plist"];
    
}

- (void) pressedGoToMainMenu:(id)sender
{
    [[GameManager shared] runSceneWithID:kMainMenuScene];
}
@end
