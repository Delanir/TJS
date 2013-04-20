//
//  Arrow.h
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "Projectile.h"
#import "Stimulus.h"

@interface Arrow : Projectile


- (id) initWithDestination: (CGPoint) location andStimulusPackage: (CCArray *) stimulusPackage;

@end
