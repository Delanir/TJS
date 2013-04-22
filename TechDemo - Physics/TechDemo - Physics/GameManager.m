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

@synthesize isMusicON, isSoundEffectsON;

static GameManager* _sharedSingleton = nil;

+(GameManager*)shared
{
	@synchronized([GameManager class])
	{
		if (!_sharedSingleton)
			[[self alloc] init];
        
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
	if (self != nil) {
        isMusicON = YES;
        isSoundEffectsON = YES;
        currentScene = kNoSceneInitialized;
		NSLog(@"Game Manager initialized");
    }
	return self;
}


-(void)dealloc
{
    [_sharedSingleton release];
    [super dealloc];
}

-(void)runSceneWithID:(SceneTypes)sceneID {
    SceneTypes oldScene = currentScene;
    currentScene = sceneID;
    id sceneToRun = nil;
    switch (sceneID) {
        case kMainMenuScene:
            sceneToRun = [CCBReader sceneWithNodeGraphFromFile:@"MainMenu.ccbi"];
            break;
        case kSkillTreeScene:
            sceneToRun = [CCBReader sceneWithNodeGraphFromFile:@"SkillTreeLayer.ccbi"];
            break;
        case kAchievementsScene:
//            sceneToRun = ; // TODO
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
            sceneToRun = [LevelLayer scene]; // TODO interactive way to do this for every level
            break;
        case kGameOverScene:
//            sceneToRun = [GameScene node]; // TODO
            break;
        case kLevelCompleteScene:
//            sceneToRun = [GameScene node]; // TODO
            break;
        default:
            CCLOG(@"Unknown ID, cannot switch scenes");
            return;
            break;
    }
    
    if (sceneToRun == nil)
        // Revert back, since no new scene was found
        currentScene = oldScene;
    
    if ([[CCDirector sharedDirector] runningScene] == nil)
        [[CCDirector sharedDirector] runWithScene:sceneToRun];
    else
        [[CCDirector sharedDirector] replaceScene:sceneToRun];
}

@end
