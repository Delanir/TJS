//
//  Stimulus.h
//  L'Archer
//
//  Created by João Amaral on 13/4/13.
//
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

typedef enum {pushBack, slow, dot, damage} stimulusType;

@interface Stimulus : NSObject
{
  stimulusType type;
  double value;
}

@property (nonatomic) stimulusType type;
@property (nonatomic) double value;

-(id) initWithStimulusType: (stimulusType) stimulus andValue: (double) val;

@end
