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

-(id) initWithSprite:(NSString *)spriteFile andWindowSize:(CGSize)winSize
{
    if (self = [super initWithSprite:spriteFile andWindowSize:winSize])
    {
        currentState = fly;
        
        
        // Setup Movement
        // Determine speed of the target
        int minDuration = 8;                                                   //@TODO ficheiro de configuraçao
        int maxDuration = 12;                                                   //@TODO ficheiro de configuracao
        int rangeDuration = maxDuration - minDuration;
        int actualDuration = (arc4random() % rangeDuration) + minDuration;
        
        // Create the actions
        id actionMove = [CCMoveTo actionWithDuration:actualDuration
                                            position:ccp(-sprite.contentSize.width/2, sprite.position.y)];
        id actionMoveDone = [CCCallFuncN actionWithTarget:self
                                                 selector:@selector(spriteMoveFinished:)];
        [sprite runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
        
        
        // Setup animations
        [self setFlyAction: [CCRepeatForever actionWithAction:
                              [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"fd_fly" ]]]];
        [self setAttackAction: [CCRepeatForever actionWithAction:
                                [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"fd_depart" ]]]];
        [[self sprite] runAction:flyAction];
        
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
        case fly:
            break;
        case attack:
            [[Wall getMajor] damage:0.02];
#warning TODO damage wall. Neste momento não há como aceder à wall. O método static é temporário
            break;
        default:
            break;
    }
}

@end
