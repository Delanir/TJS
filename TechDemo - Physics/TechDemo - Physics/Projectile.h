//
//  Projectile.h
//  TechDemo - Physics
//
//  Created by jp on 02/04/13.
//
//

#import "Entity.h"

typedef enum {ice, air, fire} particleType;

@interface Projectile : Entity
{
    CGPoint destination;
    double timeToLive;
}

@property (nonatomic) CGPoint destination;
@property (nonatomic) double timeToLive;

- (id) initWithSprite:(NSString *)spriteFile;


@end
