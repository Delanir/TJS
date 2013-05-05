//
//  Enemy.h
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "Entity.h"
#import "Registry.h"
#import "ResourceManager.h"
#import "NSMutableArray+QueueAdditions.h"
#import "Constants.h"
#import "SimpleAudioEngine.h"

@interface Enemy : Entity
{
    state currentState;
    float strength;
    float speed;
    int shoutPercentage;
    float health, maxHealth;
    unsigned int goldValue;
    float damageVulnerability, fireVulnerability, iceVulnerability, pushbackVulnerability;
    double coldRemainingTime, fireRemainingTime;
    unsigned int damageOverTimeCurrentValue;
    CCProgressTimer * healthBar;
    NSMutableArray * stimuli;
}

@property (nonatomic, retain) CCProgressTimer * healthBar;
@property (nonatomic, retain) NSMutableArray * stimuli;
@property state currentState;
@property float strength;
@property float speed;
@property float health, maxHealth;
@property float damageVulnerability, fireVulnerability, iceVulnerability, pushbackVulnerability;
@property double coldRemainingTime, fireRemainingTime;
@property unsigned int damageOverTimeCurrentValue;
@property unsigned int goldValue;


-(id) initWithSprite:(NSString *)spriteFile;
-(void) postInit;
-(void) setupActions;
-(void) attack;
-(void) die;
-(void) shout;
-(void) placeRandomly;
-(void) animateWalkLeft;
-(BOOL) isDead;
-(void) enqueueStimuli:(NSMutableArray *) stimulusPackage;

-(void) takeDamage:(double) amount;
@end
