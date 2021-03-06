//
//  Enemy.m
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "Enemy.h"
#import "CollisionManager.h"
#import "Utils.h"
#import "Yuri.h"
#import "PushbackExplosion.h"

#import "SimpleAudioEngine.h"

#import "Constants.h"
#import "LevelLayer.h"

#define SHOUTPERCENTAGE 7

@implementation Enemy

@synthesize currentState, strength, speed, goldValue, health, healthBar, maxHealth, stimuli;
@synthesize damageVulnerability, fireVulnerability, iceVulnerability, pushbackVulnerability;
@synthesize coldRemainingTime, fireRemainingTime, damageOverTimeCurrentValue;
@synthesize normalAnimationSpeed, slowDown, slowDownSpeed;
@synthesize attackAction, walkAction, walkAnimation, attackAnimation;


- (id) initWithSprite:(NSString *)spriteFile initialState:(state) initialState;
{
    if( (self = [super initWithSprite:spriteFile]))
    {
        stimuli = [[NSMutableArray alloc] init];
        
        damageVulnerability = kDamageBaseVulnerability;
        fireVulnerability = kFireBaseVulnerability;
        iceVulnerability = kIceBaseVulnerability;
        pushbackVulnerability = kPushbackBaseVulnerability;
        coldRemainingTime = 0;
        fireRemainingTime = 0;
        damageOverTimeCurrentValue = 0;
        slowDown = NO;
        
        // Initialize health bar
        CCSprite * barSprite = [[CCSprite alloc] initWithSpriteFrameName:@"red_health_bar.png"];
        [self setHealthBar:[CCProgressTimer progressWithSprite:barSprite]];
        [healthBar setType: kCCProgressTimerTypeBar];
        [healthBar setBarChangeRate:ccp(1,0)];
        [healthBar setOpacity:0];
        [self addChild:healthBar z:2];
        [barSprite release];
        frozen = NO;
        freezeRemainingTime=0;
    }
    return self;
}

-(void) postInit
{
    [self setMaxHealth:health];
    [healthBar setPercentage:health];
    shoutPercentage = SHOUTPERCENTAGE;
    
    
    [self schedule:@selector(update:)];
}

-(void) onExit
{
    [sprite release];
    [stimuli removeAllObjects];
    [self removeAllChildrenWithCleanup:YES];
    [super onExit];
}

-(void) dealloc
{
    [walkAction release];
    [walkAnimation release];
    [attackAnimation release];
    [attackAction release];
    [healthBar release];

    [stimuli release];
    [super dealloc];
}

- (void) setupActions
{
    [self schedule:@selector(shout) interval:1.5];
    
}

- (void) animateWalkLeft;
{
    // Create the actions
    id actionMove = [CCMoveTo actionWithDuration:speed*kEnemySpeedMultiplier
                                        position:ccp(-9000, sprite.position.y)];
    id actionMoveDone = [CCCallFuncN actionWithTarget:self
                                             selector:@selector(spriteMoveFinished:)];
    [sprite runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
    
    id moveHealthBar = [CCMoveTo actionWithDuration:speed*kEnemySpeedMultiplier
                                           position:ccp(-9000, healthBar.position.y)];
    [[self healthBar] runAction:moveHealthBar];
    
}


- (void) freeze
{
    if (currentState != kDieEnemyState)
    {
        frozen = YES;
        [self stopAllActions];
        [sprite stopAllActions];
        [healthBar stopAllActions];
        sprite.color=ccc3(0, 183, 235);
        [sprite setOpacity:155];
    }
}

- (void) deFreeze
{
    if (currentState != kDieEnemyState)
    {
        frozen = NO;
        [self stopAllActions];
        sprite.color=ccWHITE;
        [sprite stopAllActions];
        [self setupActions];
        [sprite setOpacity:255];
    }
}



-(void) placeRandomly
{
    CGSize spriteSize = [self spriteSize];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    int minY = winSize.height/6 + spriteSize.height/2;
    int maxY = (5 * winSize.height / 6) - spriteSize.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    // Create the target slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    sprite.position = ccp(winSize.width + (spriteSize.width/2), actualY);
    
    healthBar.position = ccp(winSize.width + (spriteSize.width/2), actualY + spriteSize.height/2 + 2);
}


-(void)spriteMoveFinished:(id)sender
{
    [self removeChild:sprite cleanup:YES];
    [self removeChild:healthBar cleanup:YES];
    [[CollisionManager shared] removeFromTargets:self];
}

-(void)attack
{
    Wall * wall = [[Registry shared] getEntityByName:@"Wall"];
    if ([wall moatLevel] == kMoatOneTimeDamageInstaKillChance)
    {
        if ([Wall instaKill])
        {
            [self takeDamage:health];
        }
    }
    if ([wall moatLevel] > kMoatNoDamage)
        [self takeDamage: kMoatOneTimeDamagePercentage * maxHealth ];
}

-(void) takeDamage:(double) amount
{
    if(![self isDead])  // para garantir que só morre uma vez
    {
        health -= amount;
        
        [healthBar setPercentage:100 * (self.health/self.maxHealth)];
        [healthBar setOpacity:255];
        
        if(health <= 0)
            [self die];
    }
}

-(void) enqueueStimuli:(NSMutableArray *) stimulusPackage
{
    for (Stimulus * stimulus in stimulusPackage)
        [stimuli enqueue:stimulus];
}


- (void)update:(ccTime)dt
{
    if([healthBar opacity] > 0)
        [healthBar setOpacity:[healthBar opacity] - dt * 0.08];

    // Damage over time treatment
    if (fireRemainingTime > 0)
    {
        fireRemainingTime -= dt;
        [self takeDamage: dt * fireVulnerability * damageOverTimeCurrentValue];
        [sprite setColor:ccc3(255, 0, 0)];
    }
    else if (fireRemainingTime < 0)
    {
        fireRemainingTime = 0.0f;
        [sprite setColor:ccc3(255, 255, 255)];
    }
    
    
    // Slow down treatment
    if (coldRemainingTime > 0)
    {
        coldRemainingTime -= dt;
        
        if (slowDown == NO)
        {
            slowDown = YES;
            speed = speed * slowDownSpeed;
            [self setCurrentSpeed: normalAnimationSpeed * slowDownSpeed];
            [sprite setColor:ccc3(0, 255, 255)];
            if (!frozen)
            {
                Yuri * yuri = [[Registry shared] getEntityByName:@"Yuri"];
                if ([yuri freezeWithCold])
                    [self freeze];
            }
        }

    }
    else if (slowDown == YES)
    {
        speed = speed / slowDownSpeed;
        [self setCurrentSpeed: normalAnimationSpeed];
        slowDown = NO;
        if (frozen)
            [self deFreeze];
        
    }
    
    
    
    if([stimuli count] > 0)
    {
        for (int i = 0; i< [stimuli count]; i++)
        {
            Stimulus * stimulus = [stimuli dequeue];
            
            switch ([stimulus type])
            {
                case kDamageStimulus:
                    [self takeDamage:[stimulus value] * damageVulnerability];
                    break;
                case kDOTStimulus:
                    damageOverTimeCurrentValue = [stimulus value] * fireVulnerability;
                    fireRemainingTime = [stimulus duration] * fireVulnerability;
                    break;
                case kSlowStimulus:
                    [self takeDamage:[stimulus value] * kYuriSlowDownDamageMultiplier * iceVulnerability];
                    slowDownSpeed = [stimulus value];
                    coldRemainingTime = [stimulus duration] * iceVulnerability;
                    break;
                case KPushBackStimulus:
                    [self pushBackWithForce:[stimulus value] * pushbackVulnerability];
                    break;
                default:
                    break;
            }
        }
    }
    
    
}

-(void) pushBackWithForce: (float) force
{
    CGPoint currentPosition = [sprite position];
    [sprite setPosition:ccp(currentPosition.x + force,currentPosition.y)];
    [healthBar setPosition:ccp([sprite position].x + force, [sprite position].y + [sprite contentSize].height/2 + 2)];
    
    [[[PushbackExplosion alloc] initWithPosition:currentPosition  andRadius:0.4] release];
    
    if ([self currentState] != kDieEnemyState)
    {
        [sprite stopAllActions];
        [healthBar stopAllActions];
        currentState = kWalkEnemyState;
        [self setupActions];
    }
}


-(void)die
{
    [self removeChild:healthBar cleanup:YES];
    [[ResourceManager shared] increaseEnemyKillCount];
    [[ResourceManager shared] addGold: goldValue];
}

-(BOOL) isDead
{
    return [self health]<=0;
}

- (void)damageWall
{
    Wall * wall = [[Registry shared] getEntityByName:@"Wall"];
    [wall damage:strength];
}

-(float) getCurrentSpeed
{
    return [[[CCAnimationCache sharedAnimationCache] animationByName: walkAnimation ] delayPerUnit];
}

-(void) setCurrentSpeed: (float) newSpeed
{
    // If enemy is dying, don't slow him down
    if (currentState != kDieEnemyState)
    {    //setup animations
        [[[CCAnimationCache sharedAnimationCache] animationByName:walkAnimation ] setDelayPerUnit:newSpeed];
        [[[CCAnimationCache sharedAnimationCache] animationByName:attackAnimation ] setDelayPerUnit:newSpeed];
        
        [[self sprite] stopAllActions];
        
        [self setupActions];
    }
}

-(void ) shout
{
    
}

- (void) startGame
{
    [healthBar setPosition:ccp([sprite position].x, [sprite position].y + [sprite contentSize].height/2 + 2)];
    LevelLayer * levelLayer = [[Registry shared] getEntityByName:@"LevelLayer"];
    [levelLayer setGameStarted:YES];
}

- (void) stopWalking
{
    [self stopAction:walkAction];
}

- (void) resumeFromTaunt
{
    [[self sprite] stopAllActions];
    [self setCurrentState:kWalkEnemyState];
    [self setupActions];
}

- (void) stopAnimations
{
    [[self sprite] stopAllActions];
}


@end
