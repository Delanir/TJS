//
//  Stimulus.h
//  L'Archer
//
//  Created by João Amaral on 13/4/13.
//
//

#import "Entity.h"

typedef enum {pushBack, slow, dot, damage} stimulusType;

@interface Stimulus : Entity
{
  stimulusType type;
  double value;
}

@end
