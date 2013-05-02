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
    NSMutableArray * skillStates;
    NSNumber * goldState;
}

@property (nonatomic, retain) NSMutableArray * starStates;
@property (nonatomic, retain) NSMutableArray * skillStates;
@property (nonatomic, retain) NSNumber * goldState;

+(GameState*)shared;

-(void)saveApplicationData;
-(void)loadApplicationData;
-(void)initApplicationData;
-(void)resetApplicationData;

@end
