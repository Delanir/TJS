//
//  Yuri.h
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "Entity.h"
#import "AppDelegate.h"

@interface Yuri : Entity
{
    BOOL readyToFire;
}

@property (nonatomic) BOOL readyToFire;
@property (nonatomic) float timeSinceLastArrow;
@property (nonatomic, retain) CCFiniteTimeAction *shootUp;
@property (nonatomic, retain) CCFiniteTimeAction *shootFront;
@property (nonatomic, retain) CCFiniteTimeAction *shootDown;
@property (nonatomic, retain) CCAction *idle;

-(void) getReady;
-(void) resetSprite;

-(BOOL)fireIfAble:(CGPoint)location;
-(void) changeFireRate: (float) fireRate;

@end
