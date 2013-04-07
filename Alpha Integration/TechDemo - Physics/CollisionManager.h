//
//  CollisionManager.h
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//


#import "Enemy.h"
#import "Arrow.h"

@interface CollisionManager : NSObject
{
    NSMutableArray *_targets;
    NSMutableArray *_projectiles;
}

+(CollisionManager*)shared;

-(void)dummyMethod;
-(void)addToTargets: (Enemy*) target;
-(void)removeFromTargets: (Enemy*) target;
-(void)addToProjectiles: (Projectile*) projectile;
-(void)removeFromProjectiles: (Projectile*) projectile;
-(void)updateSimpleCollisions:(ccTime)dt;
-(void)updatePixelPerfectCollisions:(ccTime)dt;

@end

