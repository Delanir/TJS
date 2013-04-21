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


typedef enum {walk, attack, fly, land, hit, die} state;

@interface Enemy : Entity
{
    state currentState;
    float strength;
    float speed;
    float health, maxHealth;
    unsigned int goldValue;
    CCProgressTimer * healthBar;
    NSMutableArray * stimuli;
}

@property (nonatomic, retain) CCProgressTimer * healthBar;
@property (nonatomic, retain) NSMutableArray * stimuli;
@property state currentState;
@property float strength;
@property float speed;
@property float health, maxHealth;
@property unsigned int goldValue;


- (id) initWithSprite:(NSString *)spriteFile;
- (void) postInit;
-(void) setupActions;
-(void) attack;
-(void) die;
-(void) shout;
-(void) placeRandomly;
-(void) animateWalkLeft;
-(BOOL) isDead;
-(void) enqueueStimuli:(NSMutableArray *) stimulusPackage;

-(void) takeDamage:(int) amount;
@end
