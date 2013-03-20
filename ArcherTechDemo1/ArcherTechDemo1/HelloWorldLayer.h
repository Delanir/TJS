//
//  HelloWorldLayer.h
//  L'Archer D'Amiens Tech Demo Particle System Testing (LADA)
//
//  Created by Joao Amaral on 17/03/2013.
//  Copyright NightOwl Studios 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#define NUMBER_OF_MONSTERS_TO_WIN 30

// HelloWorldLayer
@interface HelloWorldLayer : CCLayerColor
{
    NSMutableArray * _monsters;
    NSMutableArray * _projectiles;
    int _monstersDestroyed;
    CCSprite *_player;
    CCSprite *_player2;
    CCParticleSystem *_nextProjectile;
    CCLabelTTF* label;
    CCLabelTTF* label2;
    CCLabelTTF* label3;


}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
