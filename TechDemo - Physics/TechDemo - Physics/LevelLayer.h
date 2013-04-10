//
//  Level.h
//  TechDemo - Physics
//
//  Created by jp on 30/03/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"


// HelloWorldLayer
@interface LevelLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    BOOL toggleUpdate, fire;
    float timeSinceLastArrow;
    CGPoint location;
    CCParticleSystem *ps;

}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@property BOOL toggleUpdate;

@end
