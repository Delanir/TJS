//
//  Peasant.m
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "Peasant.h"

@implementation Peasant

@synthesize moveAction = _moveAction;
@synthesize walkAction = _walkAction;


-(id) initWithSprite:(NSString *)spriteFile andWindowSize:(CGSize)winSize
{
    if (self = [super initWithSprite:spriteFile andWindowSize:winSize])
    {
        _walkAction = [CCRepeatForever actionWithAction:
                                [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"p_walk" ]]];
        [[self sprite] runAction:_walkAction];
        
    }
    return self;
}
-(void)dealloc
{
    //self.walkAction = nil;
    [super dealloc];
}

@end
