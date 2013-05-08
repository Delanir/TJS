//
//  PushbackExplosion.h
//  L'Archer
//
//  Created by jp on 08/05/13.
//
//

#import "InstantEffect.h"

@interface PushbackExplosion : InstantEffect
{
    double radius;
}

@property double radius;

- (id) initWithPosition: (CGPoint) position andRadius: (double) rad;


@end
