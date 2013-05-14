//
//  Level.h
//  TechDemo - Physics
//
//  Created by jp on 30/03/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//

// When you import this file, you import all the cocos2d classes

#import "Hud.h"

#import "Registry.h"


///////////////////////
#import <GameKit/GameKit.h>
#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "GameOver.h"
#import "GameWin.h"
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

#import "GameManager.h"

#import "CCBReader.h"

// Particle Systems
#import "CCParticleSystem.h"

// Sound interface
#import "SimpleAudioEngine.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "WaveManager.h"


// HelloWorldLayer
@interface LevelLayer : CCLayer
{
    CCSprite *_pauseButton;
    GameOver *_gameOver;
    GameWin  *_gameWin;
    PauseHUD *_pause;
    
    int level;
    float manaRegenerationBonus, healthRegenerationRate;
    BOOL fire, gameStarted;
    Hud *hud;
    CGPoint location;
}
@property (nonatomic,retain) Hud *hud;
@property int level;
@property float manaRegenerationBonus, healthRegenerationRate;
@property BOOL gameStarted;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
+(void)setCurrentLevel:(int) newLevel;

-(void) togglePause;
-(void) pauseCheck:(UITouch *)touchLocation;
-(void) gameOver;
-(void) gameWin;
-(void) calculateAndUpdateNumberOfStars;
-(void) makeMoneyPersistent;
-(void) makeEnemiesKilledPersistent;

-(void) addEnemy:(Enemy *) newEnemy;

@end
