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
#import "GameState.h"
#import "Registry.h"

@class LevelLayer;

@interface Enemy : Entity
{
    CCAction *walkAction;
    NSString * walkAnimation, * attackAnimation;
    CCSequence *attackAction;
    state currentState;
    float strength, speed;
    int shoutPercentage;
    float health, maxHealth;
    unsigned int goldValue;
    float damageVulnerability, fireVulnerability, iceVulnerability, pushbackVulnerability;
    double coldRemainingTime, fireRemainingTime, freezeRemainingTime;
    unsigned int damageOverTimeCurrentValue;
    float normalAnimationSpeed, slowDownSpeed;
    BOOL slowDown;
    CCProgressTimer * healthBar;
    NSMutableArray * stimuli;
    BOOL frozen;
}

@property (nonatomic, retain) CCAction *walkAction;
@property (nonatomic, retain) NSString * walkAnimation, * attackAnimation;
@property (nonatomic, retain) CCSequence *attackAction;
@property (nonatomic, retain) CCProgressTimer * healthBar;
@property (nonatomic, retain) NSMutableArray * stimuli;
@property state currentState;
@property float strength, speed;
@property float health, maxHealth;
@property float damageVulnerability, fireVulnerability, iceVulnerability, pushbackVulnerability;
@property double coldRemainingTime, fireRemainingTime;
@property unsigned int damageOverTimeCurrentValue;
@property unsigned int goldValue;
@property float normalAnimationSpeed, slowDownSpeed;
@property BOOL slowDown;


-(id) initWithSprite:(NSString *)spriteFile initialState:(state) initialState;
-(void) postInit;
-(void) setupActions;
-(void) attack;
-(void) die;
-(void) shout;
-(void) placeRandomly;
-(void) animateWalkLeft;
-(BOOL) isDead;
-(void) enqueueStimuli:(NSMutableArray *) stimulusPackage;
-(float) getCurrentSpeed;
-(void) setCurrentSpeed: (float) newSpeed;
- (void) startGame;
- (void) stopWalking;
- (void) resumeFromTaunt;
- (void) stopAnimations;
-(void) freeze;

-(void) takeDamage:(double) amount;
@end
