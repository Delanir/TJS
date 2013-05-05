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
    float strength;
    float critical;
    
    BOOL bonusActive;
    float strengthBonus;
    float speedBonus;
    float criticalBonus;
}

@property (nonatomic) BOOL readyToFire;
@property unsigned int level;
@property float strength;
@property float critical;
@property BOOL bonusActive;
@property float strengthBonus;
@property float speedBonus;
@property float criticalBonus;
@property (nonatomic, retain) CCFiniteTimeAction *shootUp;
@property (nonatomic, retain) CCFiniteTimeAction *shootFront;
@property (nonatomic, retain) CCFiniteTimeAction *shootDown;
//@property (nonatomic, retain) CCAction *idle;

-(void) getReady;

-(void) initBasicStats;

-(BOOL)fireIfAble:(CGPoint)location;
-(int)isCritical;
-(float) getCurrentFireRate;
-(void) changeFireRate: (float) fireRate;

@end
