//
//  IceExplosion.h
//  L'Archer
//
//  Created by jp on 07/05/13.
//
//

#import "InstantEffect.h"

@interface IceExplosion : InstantEffect

{
    double radius;
}

@property double radius;

- (id) initWithPosition: (CGPoint) position andRadius: (double) rad;

@end

