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

@interface LevelLayerAbstract : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>{
    CCSprite *_pauseButton;
}

-(void) togglePause;
-(void) pauseCheck:(UITouch *)touchLocation;

@end
