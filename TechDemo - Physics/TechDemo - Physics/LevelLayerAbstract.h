//
//  LevelLayerAbstract.h
//  L'Archer
//
//  Created by MiniclipMacBook on 4/17/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <GameKit/GameKit.h>
#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "Enemy.h"
#import "GameOver.h"

@interface LevelLayerAbstract : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>{
    CCSprite *_pauseButton;
    GameOver *_gameOver;
}



-(void) togglePause;
-(void) pauseCheck:(UITouch *)touchLocation;
-(void) gameOver;

-(void) addEnemy:(Enemy *) newEnemy;

@end
