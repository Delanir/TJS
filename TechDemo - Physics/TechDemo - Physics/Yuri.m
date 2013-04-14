//
//  Yuri.m
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "Yuri.h"

// Sound interface
#import "SimpleAudioEngine.h"

@implementation Yuri

@synthesize fire, readyToFire;
#warning Pode ser necessário sintetizar as acções

-(id) init
{
    if(self = [super initWithSprite:@"y_lvl3_01.png"])
    {
        fire = NO;
        readyToFire = NO;
        
        
        [self setShootUp:[CCRepeat actionWithAction:
                            [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"y_attack_up" ]] times:1]];
        [self setShootFront:[CCRepeat actionWithAction:
                            [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"y_attack_front" ]] times:1]];
        [self setShootDown:[CCRepeat actionWithAction:
                            [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"y_attack_down" ]] times:1]];
        [self setIdle:[CCRepeatForever actionWithAction:
                            [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"y_idle_1" ]]]];
        
        [[self sprite] runAction:[self idle]];
    }
    return self;
}


-(void)animateInDirection:(CGPoint)location
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    [[self sprite] stopAllActions];
    int direction = (int)(floor(location.y / (winSize.height/3)));
    switch (direction) {
        case 0:
            [[self sprite] runAction:[CCSequence actions:
                           [self shootDown],
                           [CCCallFuncN actionWithTarget:self selector:@selector(getReady)],
                           nil]];
            break;
        case 1:
            [[self sprite] runAction:[CCSequence actions:
                                      [self shootFront],
                                      [CCCallFuncN actionWithTarget:self selector:@selector(getReady)],
                                      nil]];
            break;
        case 2:
            [[self sprite] runAction:[CCSequence actions:
                                      [self shootUp],
                                      [CCCallFuncN actionWithTarget:self selector:@selector(getReady)],
                                      nil]];
            break;
        default:
            break;
    }
    
}

-(void) getReady
{
    [self setReadyToFire:YES];
    [self setFire:YES];
}


-(void) resetSprite
{
    [[self sprite] stopAllActions];
    [[self sprite] runAction:[self idle]];
}

-(void) changeFireRate: (float) fireRate
{
    //setup animations
    [[[CCAnimationCache sharedAnimationCache] animationByName:@"y_attack_up" ] setDelayPerUnit:fireRate];
    [[[CCAnimationCache sharedAnimationCache] animationByName:@"y_attack_front" ] setDelayPerUnit:fireRate];
    [[[CCAnimationCache sharedAnimationCache] animationByName:@"y_attack_down" ] setDelayPerUnit:fireRate];
    
    [[self sprite] stopAllActions];
        
    [self setShootUp:[CCRepeat actionWithAction:
                        [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"y_attack_up" ]] times:1]];
    [self setShootFront:[CCRepeat actionWithAction:
                         [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"y_attack_front" ]] times:1]];
    [self setShootDown:[CCRepeat actionWithAction:
                        [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"y_attack_down" ]] times:1]];
    
}


@end
