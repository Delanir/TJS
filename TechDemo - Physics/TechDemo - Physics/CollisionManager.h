//
//  CollisionManager.h
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "Enemy.h"
#import "Arrow.h"
#import "Wall.h"

@interface CollisionManager : NSObject
{
    CCArray *_targets;
    CCArray *_projectiles;
    CCArray * _walls;
}

+(CollisionManager*)shared;

-(void)dummyMethod;
-(void)addToTargets: (Enemy*) target;
-(void)addToProjectiles: (Projectile*) projectile;
-(void)addToWalls: (CCSprite*) wall;
-(void)removeFromTargets: (Enemy*) target;
-(void)removeFromProjectiles: (Projectile*) projectile;
-(void)removeFromWalls: (CCSprite*) wall;
-(void)clearAllEntities;

// Collisions
-(void)updateCollisions:(ccTime)dt;



@end

