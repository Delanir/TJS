//
//  GameState.h
//  L'Archer
//
//  Created by jp on 22/04/13.
//
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface GameState : NSObject
{
    CCArray * starStates;
}

@property (nonatomic, retain) CCArray * starStates;

+(GameState*)shared;

@end
