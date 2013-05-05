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
    float strength, critical;
    
    BOOL bonusActive;
    float strengthBonus, speedBonus, criticalBonus;
    float fireDuration, fireDamage, slowTime, slowPercentage;
    float fireDurationBonus, fireDamageBonus, slowTimeBonus, slowPercentageBonus;
}

@property (nonatomic) BOOL readyToFire;
@property unsigned int level;
@property BOOL bonusActive;
@property float strength, critical;
@property float strengthBonus, speedBonus, criticalBonus;
@property float fireDuration, fireDamage, slowTime, slowPercentage;
@property float fireDurationBonus, fireDamageBonus, slowTimeBonus, slowPercentageBonus;

@property (nonatomic, retain) CCFiniteTimeAction *shootUp;
@property (nonatomic, retain) CCFiniteTimeAction *shootFront;
@property (nonatomic, retain) CCFiniteTimeAction *shootDown;

-(void) getReady;

-(void) initBasicStats;

-(BOOL)fireIfAble:(CGPoint)location;
-(int)isCritical;
-(float) getCurrentFireRate;
-(void) changeFireRate: (float) fireRate;

@end
