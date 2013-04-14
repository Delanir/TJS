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
  CCParticleSystem *ps;
}

//@property (nonatomic, retain)  CCParticleSystem *ps;

- (id) initWithSprite:(NSString *)spriteFile
          andLocation: (CGPoint) location
        andWindowSize: (CGSize) winSize;

- (void) destroyParticleSystem;

@end
