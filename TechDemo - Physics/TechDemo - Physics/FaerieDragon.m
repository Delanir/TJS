//
//  FaerieDragon.m
//  L'Archer
//
//  Created by jp on 12/04/13.
//
//

#import "FaerieDragon.h"

#define FAIRIESHOUT 1

@implementation FaerieDragon

-(id) initWithSprite:(NSString *)spriteFile initialState:(state) initialState
{
    if (self = [super initWithSprite:spriteFile initialState:initialState])
    {
        [self setCurrentState:initialState];
        [self setHealth:240];
        [self setSpeed:11];
        [self setStrength:2.4];
        [self setGoldValue:8];
        [self setDamageVulnerability:kDamageBaseVulnerability * 0.8];
        [self setFireVulnerability:kFireBaseVulnerability * 0.5];
        [self setIceVulnerability:kIceBaseVulnerability * 1.5];
        [self setPushbackVulnerability:kPushbackBaseVulnerability * 0.8];

        [self postInit];
    }
    return self;
}

-(void) setupActions
{
    walkAnimation = @"fd_fly";
    attackAnimation = @"fd_attack";
    // Setup animations
    [self setWalkAction: [CCRepeatForever actionWithAction:
                         [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName: walkAnimation]]]];
    [self setAttackAction: [CCSequence actions:
                            [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName: attackAnimation]],
                            [CCCallFuncN actionWithTarget:self selector:@selector(damageWall)],
                            nil]];
    
    // Setup Movement
    if (currentState == kWalkEnemyState)
    {
        [[self sprite] runAction:walkAction];
        [self animateWalkLeft];
    }
    if (currentState == kAttackEnemyState)
        [sprite runAction:[CCRepeatForever actionWithAction:attackAction]];
    
    shoutPercentage = FAIRIESHOUT;
}

-(void)attack
{
    [super attack];
    if ([self isDead]) return;  // may die in super because of the moat
    [self setCurrentState:kAttackEnemyState];
    [[self sprite] stopAllActions];
    [[self healthBar] stopAllActions];
    [sprite setPosition:ccp([sprite position].x +26, [sprite position].y)];
    [healthBar setPosition:ccp([sprite position].x, [sprite position].y + [sprite contentSize].height/2 + 2)];
    [[self sprite] runAction:[CCRepeatForever actionWithAction:attackAction]];
}

-(void)die
{
    [self setCurrentState:kDieEnemyState];
    [[self sprite] stopAllActions];
    
    CCFiniteTimeAction * dieAction = [CCSequence actions:
                                      [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"fd_dies" ]] times:1],
                                      [CCCallFuncN actionWithTarget:self selector:@selector(mockDie)],
                                      nil];
    [[self sprite] runAction:dieAction];
    int dragonKilled = [[[GameState shared] dragonsKilledState] intValue] + 1;
    [[GameState shared] setDragonsKilledState: [NSNumber numberWithInt:dragonKilled]];
}


-(void) mockDie
{
    [super die];
}

- (void) shout{
    
    int s;
    NSString *sound;
    
    int play= [Utils getRandomNumberBetween:1 to:100];
    if (play > shoutPercentage) {
        return;
    }
    s= [Utils getRandomNumberBetween:1 to:5];
    sound = @"fairie";
    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:sound]];
}



@end
