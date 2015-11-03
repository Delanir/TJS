//
//  GameManager.m
//  L'Archer
//
//  Created by jp on 21/04/13.
//
//

#import "GameManager.h"
#import "LevelLayer.h"

@implementation GameManager

static GameManager* _sharedSingleton = nil;

+(GameManager*)shared
{
	@synchronized([GameManager class])
	{
        if (_sharedSingleton == nil) {
            [[self alloc] init];
        }
        
		return _sharedSingleton;
	}
    
	return nil;
}


+(id)alloc
{
	@synchronized([GameManager class])
	{
		NSAssert(_sharedSingleton == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedSingleton = [super alloc];
		return _sharedSingleton;
	}
    
	return nil;
}

-(id)init
{
	self = [super init];
	if (self != nil)
    {
#ifdef kDebugMode
        [[Registry shared] addToCreatedEntities:self];
#endif
    }
	return self;
}


-(void)dealloc
{
#ifdef kDebugMode
    [[Registry shared] addToDestroyedEntities:self];
#endif
    [_sharedSingleton release];
    [super dealloc];
}

-(void)runSceneWithID:(SceneTypes)sceneID
{
    id sceneToRun = nil;
    switch (sceneID) {
        case kMainMenuScene:
            sceneToRun = [CCBReader sceneWithNodeGraphFromFile:@"MainMenu.ccbi"];
            break;
        case kSkillTreeScene:
            sceneToRun = [CCBReader sceneWithNodeGraphFromFile:@"SkillTreeLayerZWOP.ccbi"];
            break;
        case kAchievementsScene:
            sceneToRun = [CCBReader sceneWithNodeGraphFromFile:@"AchievementsLayer.ccbi"];
            break;
        case kLeaderboardScene:
            //            sceneToRun = ; // TODO
            break;
        case kSettingsScene:
            sceneToRun = [CCBReader sceneWithNodeGraphFromFile:@"SettingsMenu.ccbi"];
            break;
        case kSelectLevel:
            sceneToRun = [CCBReader sceneWithNodeGraphFromFile:@"LevelSelectLayer.ccbi"];
            break;
        case kGameLevel:
            sceneToRun = [LevelLayer scene];
            break;
        default:
            CCLOG(@"Unknown ID, cannot switch scenes");
            return;
            break;
    }
    
    if ([[CCDirector sharedDirector] runningScene] == nil)
        [[CCDirector sharedDirector] runWithScene:sceneToRun];
    else{
        [[[CCDirector sharedDirector] runningScene] stopAllActions];
        [[[CCDirector sharedDirector] runningScene] unscheduleAllSelectors];
        [[[CCDirector sharedDirector] runningScene] removeAllChildrenWithCleanup:YES];
        [[[CCDirector sharedDirector] runningScene] removeFromParentAndCleanup:YES];
        
        
        if (sceneID == kMainMenuScene)
            [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL transitionWithDuration:0.5f scene:sceneToRun]];
        else
            [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR transitionWithDuration:0.5f scene:sceneToRun]];
    }
}


-(void)runLevel:(int)level
{
    [LevelLayer setCurrentLevel:level];
    [self runSceneWithID:kGameLevel];
}

@end
