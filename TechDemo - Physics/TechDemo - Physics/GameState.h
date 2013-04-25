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
    NSMutableArray * starStates;
}

@property (nonatomic, retain) NSMutableArray * starStates;

+(GameState*)shared;

-(void)saveApplicationData;
-(void)loadApplicationData;
-(void)initApplicationData;
-(void)resetApplicationData;

@end
