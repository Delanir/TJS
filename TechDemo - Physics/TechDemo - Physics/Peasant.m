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
        [self setCurrentState:walk];
        
        // Setup movement
        
        // Determine speed of the target
        int minDuration = 10;                                                   //@TODO ficheiro de configuraçao
        int maxDuration = 20;                                                   //@TODO ficheiro de configuracao
        int rangeDuration = maxDuration - minDuration;
        int actualDuration = (arc4random() % rangeDuration) + minDuration;
        
        // Create the actions
        id actionMove = [CCMoveTo actionWithDuration:actualDuration
                                            position:ccp(-sprite.contentSize.width/2, sprite.position.y)];
        id actionMoveDone = [CCCallFuncN actionWithTarget:self
                                                 selector:@selector(spriteMoveFinished:)];
        [sprite runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];

        // Setup Animations
        
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
    [self setCurrentState:attack];
    [[self sprite] stopAllActions];
    [[self sprite] setPosition:CGPointMake([self sprite].position.x +6, [self sprite].position.y)];
    //[[self sprite] runAction:walkAction];
    [[self sprite] runAction:attackAction];
}

-(void)die
{
    [super die];
    [self setCurrentState:die];
    [[self sprite] stopAllActions];
    
    CCFiniteTimeAction * dieAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"p_dies" ]] times:1];
    [[self sprite] runAction:dieAction];
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
