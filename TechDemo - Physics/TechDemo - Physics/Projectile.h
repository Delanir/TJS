//
//  Projectile.h
//  TechDemo - Physics
//
//  Created by jp on 02/04/13.
//
//

#import "Entity.h"
#import "Constants.h"

@interface Projectile : Entity
{
    CGPoint destination;
    double timeToLive;
    CCArray * stimuli;
}

@property (nonatomic) CGPoint destination;
@property (nonatomic) double timeToLive;
@property (nonatomic, retain) CCArray * stimuli;

- (id) initWithSprite:(NSString *)spriteFile;


@end
