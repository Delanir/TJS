//
//  Yuri.h
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "Entity.h"
#import "AppDelegate.h"
// Sound interface
#import "SimpleAudioEngine.h"

@interface Yuri : Entity
{
    BOOL readyToFire;
    unsigned int level;
}

@property (nonatomic) BOOL readyToFire;
@property unsigned int level;
@property (nonatomic, retain) CCFiniteTimeAction *shootUp;
@property (nonatomic, retain) CCFiniteTimeAction *shootFront;
@property (nonatomic, retain) CCFiniteTimeAction *shootDown;
//@property (nonatomic, retain) CCAction *idle;

-(void) getReady;

-(BOOL)fireIfAble:(CGPoint)location;
-(float) getCurrentFireRate;
-(void) changeFireRate: (float) fireRate;

@end
