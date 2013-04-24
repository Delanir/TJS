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

@synthesize isMusicON, isSoundEffectsON, masterScene;

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
	if (self != nil)
  {
    isMusicON = YES;
    isSoundEffectsON = YES;
    currentScene = kMasterScene;
    masterScene = [CCScene node];
  }
	return self;
}


-(void)dealloc
{
  [_sharedSingleton release];
  [super dealloc];
}

-(void)runSceneWithID:(SceneTypes)sceneID
{
  SceneTypes oldScene = currentScene;
  currentScene = sceneID;
  id sceneToRun = nil;
  switch (sceneID) {
    case kMainMenuScene:
      sceneToRun = [CCBReader nodeGraphFromFile:@"MainMenu.ccbi"];
      break;
    case kSkillTreeScene:
      CCLOG(@"we hates it, golum golum");
      sceneToRun = [[CCBReader nodeGraphFromFile:@"SkillTreeLayer.ccbi"] autorelease];
      break;
    case kAchievementsScene:
      //            sceneToRun = ; // TODO
      break;
    case kLeaderboardScene:
      //            sceneToRun = ; // TODO
      break;
    case kSettingsScene:
      sceneToRun = [CCBReader nodeGraphFromFile:@"SettingsMenu.ccbi"];
      break;
    case kSelectLevel:
      sceneToRun = [CCBReader nodeGraphFromFile:@"LevelSelectLayer.ccbi"];
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
    case kMasterScene:
      [[CCDirector sharedDirector] pushScene:masterScene];
      [self runSceneWithID:kMainMenuScene];
    default:
      CCLOG(@"Unknown ID, cannot switch scenes");
      return;
      break;
  }
  
  if (sceneToRun == nil)
    // Revert back, since no new scene was found
    currentScene = oldScene;
  
  //  if ([[CCDirector sharedDirector] runningScene] == nil)
//    [[CCDirector sharedDirector] runWithScene:sceneToRun];
//  else{
//    //        [[[CCDirector sharedDirector] runningScene] stopAllActions];
//    //        [[[CCDirector sharedDirector] runningScene] unscheduleAllSelectors];
//    //        [[[CCDirector sharedDirector] runningScene] removeAllChildrenWithCleanup:YES];
//    //        [[[CCDirector sharedDirector] runningScene] removeFromParentAndCleanup:YES];
//    [[CCDirector sharedDirector] replaceScene:sceneToRun];
  else
  {
    
    CCNode * node = [[masterScene children] objectAtIndex:0];
    
    [masterScene removeAllChildrenWithCleanup:YES];
    [masterScene addChild:sceneToRun];
    
  }
//  }
  
}


-(void)runLevel:(int)level
{
  [LevelLayer setCurrentLevel:level];
  [self runSceneWithID:kGameLevel];
}

@end
