//
//  FaerieDragon.m
//  L'Archer
//
//  Created by jp on 12/04/13.
//
//

#import "FaerieDragon.h"
#import "Wall.h"

@implementation FaerieDragon

@synthesize attackAction, flyAction;

-(id) initWithSprite:(NSString *)spriteFile
{
    if (self = [super initWithSprite:spriteFile])
    {
        [self setCurrentState:fly];
        [self setStrength:2.0];
        [self setGoldValue:6];
        [self setSpeed:10];
        [self setHealth:200];
        
        [self postInit];
    }
    return self;
}

-(void) setupActions
{
    // Setup Movement
    [self animateWalkLeft];
    
    // Setup animations
    [self setFlyAction: [CCRepeatForever actionWithAction:
                         [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"fd_fly" ]]]];
    [self setAttackAction: [CCSequence actions:
                            [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"fd_attack"]],
                            [CCCallFuncN actionWithTarget:self selector:@selector(damageWall)],
                            nil]];
    [[self sprite] runAction:flyAction];
}

-(void)attack
{
    [self setCurrentState:attack];
    [[self sprite] stopAllActions];
    [[self healthBar] stopAllActions];
    [sprite setPosition:ccp([sprite position].x +26, [sprite position].y)];
    [healthBar setPosition:ccp([sprite position].x, [sprite position].y + [sprite contentSize].height/2 + 2)];
    [[self sprite] runAction:[CCRepeatForever actionWithAction:attackAction]];
}

-(void)die
{
    [super die];
    [self setCurrentState:die];
    [[self sprite] stopAllActions];
    
    CCFiniteTimeAction * dieAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"fd_dies" ]] times:1];
    [[self sprite] runAction:dieAction];
}



@end
