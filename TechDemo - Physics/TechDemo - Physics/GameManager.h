//
//  GameManager.h
//  L'Archer
//
//  Created by jp on 21/04/13.
//
//

#import <Foundation/Foundation.h>
#import "CCBReader.h"

typedef enum {
    kNoSceneInitialized=0,
    kMainMenuScene=1,
    kSkillTreeScene=2,
    kAchievementsScene=3,
    kLeaderboardScene=4,
    kSettingsScene=5,
    kSelectLevel=6,
    kGameLevel=7,
    kGameOverScene=8,
    kLevelCompleteScene=9,
    kCreditsScene=101,
} SceneTypes;

@interface GameManager : NSObject
{
    BOOL isMusicON;
    BOOL isSoundEffectsON;
    SceneTypes currentScene;
}

@property BOOL isMusicON;
@property BOOL isSoundEffectsON;

+(GameManager*)shared;
-(void)runSceneWithID:(SceneTypes)sceneID;

@end
