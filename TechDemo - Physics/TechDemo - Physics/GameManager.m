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
        ScenePointerDic=[[NSMutableDictionary alloc] init];
    }
	return self;
}


-(void)dealloc
{
    [ScenePointerDic release];
    ScenePointerDic=nil;
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
            CCLOG(@"we hates it, golum golum");
            if ([ScenePointerDic objectForKey:[NSString stringWithFormat:@"%i",kSkillTreeScene]] !=nil) {
                [ScenePointerDic removeObjectForKey:[NSString stringWithFormat:@"%i",kSkillTreeScene]];
              
//                sceneToRun = [CCBReader sceneWithNodeGraphFromFile:@"SkillTreeLayer.ccbi" owner:self];
                [ScenePointerDic setValue:[CCBReader sceneWithNodeGraphFromFile:@"SkillTreeLayer.ccbi" ] forKey:[NSString stringWithFormat:@"%i",kSkillTreeScene] ];
                sceneToRun =[ScenePointerDic objectForKey:[NSString stringWithFormat:@"%i",kSkillTreeScene]];
            }else{
                
                sceneToRun = [CCBReader sceneWithNodeGraphFromFile:@"SkillTreeLayer.ccbi"];
                [ScenePointerDic setValue:sceneToRun forKey:[NSString stringWithFormat:@"%i",kSkillTreeScene] ];
            }
            break;
        case kAchievementsScene:
//            sceneToRun = ; // TODO
            break;
        case kLeaderboardScene:
//            sceneToRun = ; // TODO
            break;
        case kSettingsScene:
            
            if ([ScenePointerDic objectForKey:[NSString stringWithFormat:@"%i",kSettingsScene]] !=nil) {
                [ScenePointerDic removeObjectForKey:[NSString stringWithFormat:@"%i",kSettingsScene]];
                
                //                sceneToRun = [CCBReader sceneWithNodeGraphFromFile:@"SkillTreeLayer.ccbi" owner:self];
                [ScenePointerDic setValue:sceneToRun = [CCBReader sceneWithNodeGraphFromFile:@"SettingsMenu.ccbi"] forKey:[NSString stringWithFormat:@"%i",kSettingsScene] ];
                sceneToRun =[ScenePointerDic objectForKey:[NSString stringWithFormat:@"%i",kSettingsScene]];
            }else{
                
                sceneToRun = [CCBReader sceneWithNodeGraphFromFile:@"SettingsMenu.ccbi"];
                [ScenePointerDic setValue:sceneToRun forKey:[NSString stringWithFormat:@"%i",kSettingsScene] ];
            }
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
    else{
        [[[CCDirector sharedDirector] runningScene]stopAllActions];
        [[[CCDirector sharedDirector] runningScene] unscheduleAllSelectors];
        [[[CCDirector sharedDirector] runningScene] removeAllChildrenWithCleanup:YES];
        [[[CCDirector sharedDirector] runningScene] removeFromParentAndCleanup:YES];
        [[CCDirector sharedDirector] replaceScene:sceneToRun];
                
    }
    
}

-(void) startMain
{
    id main = [CCBReader sceneWithNodeGraphFromFile:@"MainMenu.ccbi"];

    [[CCDirector sharedDirector] pushScene:main];
}

@end
