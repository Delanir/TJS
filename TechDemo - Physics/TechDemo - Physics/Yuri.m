//
//  Yuri.m
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "Yuri.h"


@implementation Yuri

@synthesize  readyToFire, level;

-(id) init
{
    if(self = [super initWithSprite:@"y_lvl3_06.png"])
    {
        readyToFire = YES;
        
        [self setShootUp:[CCRepeat actionWithAction:
                          [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"y_attack_up" ]] times:1]];
        [self setShootFront:[CCRepeat actionWithAction:
                             [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"y_attack_front" ]] times:1]];
        [self setShootDown:[CCRepeat actionWithAction:
                            [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"y_attack_down" ]] times:1]];
        //[self setIdle:[CCRepeatForever actionWithAction:
        //               [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"y_idle_1" ]]]];
        
        //[[self sprite] runAction:[self idle]];
    }
    return self;
}


-(BOOL)fireIfAble:(CGPoint)location
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    if(readyToFire)
    {
        readyToFire = NO;
        int direction = (int)(floor(location.y / (winSize.height/3)));
        switch (direction)
        {
            case 0:
                [[self sprite] runAction:[CCSequence actions: [self shootDown],
                                          [CCCallFuncN actionWithTarget:self selector:@selector(getReady)],
                                          nil]];
                break;
            case 1:
                [[self sprite] runAction:[CCSequence actions: [self shootFront],
                                          [CCCallFuncN actionWithTarget:self selector:@selector(getReady)],
                                          nil]];
                break;
            case 2:
                [[self sprite] runAction:[CCSequence actions: [self shootUp],
                                          [CCCallFuncN actionWithTarget:self selector:@selector(getReady)],
                                          nil]];
                break;
        }
        return true;
    }
    else return false;
}


-(void) getReady
{
    [self setReadyToFire:YES];
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

-(float) getCurrentFireRate
{
    return [[[CCAnimationCache sharedAnimationCache] animationByName:@"y_attack_front"] delayPerUnit];
}


@end
