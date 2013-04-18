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

typedef enum {mint, scratched, damaged, wrecked, totaled} wallStatus;

@interface Wall : Entity
{
    double health, lastHealth;
    wallStatus status;
    CCArray *sprites;
}

@property (nonatomic) double health, lastHealth;


-(void) damage: (double) amount;
-(void) addMoat;


@end
