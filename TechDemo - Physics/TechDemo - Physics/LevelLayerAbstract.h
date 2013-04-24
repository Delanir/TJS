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

#import "GameOver.h"
#import "MainScene.h"
#import "Yuri.h"
#import "Enemy.h"
#import "GameOver.h"
#import "PauseHUD.h"
#import "Peasant.h"
#import "CollisionManager.h"
#import "Config.h"
#import "EnemyFactory.h"
#import "SpriteManager.h"
#import "FaerieDragon.h"
#import "Arrow.h"
#import "StimulusFactory.h"
#import "Stimulus.h"
#import "ResourceManager.h"

#import "CCBReader.h"

// Particle Systems
#import "CCParticleSystem.h"

// Sound interface
#import "SimpleAudioEngine.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "WaveManager.h"

@interface LevelLayerAbstract : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    CCSprite *_pauseButton;
    GameOver *_gameOver;
    PauseHUD *_pause;
}



-(void) togglePause;
-(void) pauseCheck:(UITouch *)touchLocation;
-(void) gameOver;
-(void) victory;

-(void) addEnemy:(Enemy *) newEnemy;

@end
