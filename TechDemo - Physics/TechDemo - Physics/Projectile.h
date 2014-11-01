//
//  Projectile.h
//  TechDemo - Physics
//
//  Created by jp on 02/04/13.
//
//

#import "Entity.h"
#import "Constants.h"

@interface Projectile : CCNode
{
    CCSprite * sprite;
    CGPoint destination;
    double timeToLive;
    CCArray * stimuli;
}

@property (nonatomic) CGPoint destination;
@property (nonatomic) double timeToLive;
@property (nonatomic, retain) CCArray * stimuli;
@property (nonatomic, retain) CCSprite * sprite;

-(void)spriteMoveFinished:(id)sender;
- (void) destroy;


@end
