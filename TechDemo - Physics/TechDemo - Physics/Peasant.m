//
//  Peasant.m
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "Peasant.h"
#import "Wall.h"

@implementation Peasant

@synthesize attackAction, walkAction;


-(id) initWithSprite:(NSString *)spriteFile andWindowSize:(CGSize)winSize
{
    if (self = [super initWithSprite:spriteFile andWindowSize:winSize])
    {
        [self setWalkAction: [CCRepeatForever actionWithAction:
                                [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"p_walk" ]]]];
        [self setAttackAction: [CCRepeatForever actionWithAction:
                         [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"p_attack" ]]]];
        [[self sprite] runAction:walkAction];
        
        [self schedule:@selector(update:)];
        
    }
    return self;
}
-(void)dealloc
{
    //self.walkAction = nil;
    [super dealloc];
}

-(void)attack
{
    currentState = attack;
    [[self sprite] stopAllActions];
    [[self sprite] setPosition:CGPointMake([self sprite].position.x +1, [self sprite].position.y)];
    //[[self sprite] runAction:walkAction];
    [[self sprite] runAction:attackAction];
}

- (void)update:(ccTime)dt
{
    switch(currentState)
    {
        case walk:
            break;
        case attack:
            [[Wall getMajor] damage:0.01];
#warning TODO damage wall. Neste momento não há como aceder à wall. O método static é temporário
            break;
        default:
            break;
    }
}

@end
