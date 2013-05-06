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

/**
 * I chose not to implement the fire chaining effect because it would be redundant
 * since we already have the area of effect damage set up. It just wouldn't do much
 * in situations where both powers would be selected. That could be a feature, and
 * in fact, some situations could still be explored with this power up, but I fear
 * it would do more bad than good. So I removed it and separated the damage over
 * time path in two - Damage over time, and total duration of the effect. Previously
 * they were both in the same branch of the fire skill tree and felt somehow overrated.
 * Still, I left the code ready to implement the chain reaction effect if we decide
 * to use it anyhow. We have the constants in constants.h, the variable in Yuri for
 * the number of chain targets, and the method in the collision manager to locate the
 * nearest instance of any enemy. The rest is just to emulate the logic from the area
 * of effect method in the collision manager. Cheers!
 */

@interface Yuri : Entity
{
    BOOL readyToFire;
    unsigned int level;
    float strength, critical;
    
    BOOL bonusActive;
    float strengthBonus, speedBonus, criticalBonus;
    float fireDuration, fireDamage, fireAreaOfEffect, fireNumberOfChainTargets;
    float slowTime, slowPercentage, iceAreaOfEffect, freezePercentage;
    float fireDurationBonus, fireDamageBonus, slowTimeBonus, slowPercentageBonus;
}

@property (nonatomic) BOOL readyToFire;
@property unsigned int level;
@property BOOL bonusActive;
@property float strength, critical;
@property float strengthBonus, speedBonus, criticalBonus;
@property float fireDuration, fireDamage, fireAreaOfEffect, fireNumberOfChainTargets;
@property float slowTime, slowPercentage, iceAreaOfEffect, freezePercentage;
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
