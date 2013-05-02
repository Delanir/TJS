//
//  SpriteManager.h
//  Alpha Integration
//
//  Created by MiniclipMacBook on 4/7/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "Entity.h"
#import "CollisionManager.h"
#import <objc/runtime.h>
#import "Registry.h"
#import "Constants.h"

@interface Wall : Entity
{
    double maxHealth, health, lastHealth;
    wallStatus status;
    CCArray *sprites;
    CCParticleSmoke *smokeTop, *smokeBottom;
    CCParticleFire *fireTop, *fireBottom;
    CGPoint topPoint1, topPoint2, fireSparksTop, bottomPoint1, bottomPoint2, fireSparksBottom;
  
    //para o som
    double losingRate;
}

@property (nonatomic) double maxHealth, health, lastHealth;


-(void) damage: (double) amount;
-(void) addMoat;


@end
