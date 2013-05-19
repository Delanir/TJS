//
//  LevelUp.h
//  L'Archer
//
//  Created by jp on 19/05/13.
//
//

#import "InstantEffect.h"

@interface LevelUp : InstantEffect
{
    int level;
}

- (id) initWithLevel: (int) lvl;

@end
