//
//  Projectile.h
//  TechDemo - Physics
//
//  Created by jp on 02/04/13.
//
//

#import "Entity.h"

@interface Projectile : Entity

- (id) initWithSprite:(NSString *)spriteFile
          andLocation: (CGPoint) location
        andWindowSize: (CGSize) winSize;

@end
