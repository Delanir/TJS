//
//  HelloWorldLayer.h
//  TesteSprites
//
//  Created by NightOwl Studios on 08/03/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "SimpleAudioEngine.h" 

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    CCSprite * _bear;
    CCAction * _walkAction;
    CCAction * _moveAction;
    BOOL  _moving;NSMutableArray * _monsters;
    NSMutableArray * _projectiles;
    int _monstersDestroyed;
    CCSprite *_player;
    CCSprite *_nextProjectile;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@property (nonatomic, retain) CCSprite * bear;
@property (nonatomic, retain) CCAction * walkAction;
@property (nonatomic, retain) CCAction * moveAction;
@property BOOL  moving;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
