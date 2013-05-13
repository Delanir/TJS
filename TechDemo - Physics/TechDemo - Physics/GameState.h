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
    NSMutableArray * achievementStates;
    NSNumber * goldState;
    NSNumber * buyArrowsState;
    NSNumber * wallRepairState;
    NSNumber * enemiesKilledState;
    NSNumber * dragonsKilledState;
    NSNumber * fireElementalKilledState;
    BOOL firstrun;
    BOOL firstRunSkill;
}

@property (nonatomic, retain) NSMutableArray * starStates;
@property (nonatomic, retain) NSMutableArray * skillStates;
@property (nonatomic, retain) NSNumber * goldState;
@property (nonatomic, retain) NSMutableArray * achievementStates;
@property (nonatomic, retain) NSNumber * buyArrowsState;
@property (nonatomic, retain) NSNumber * wallRepairState;
@property (nonatomic, retain) NSNumber * enemiesKilledState;
@property (nonatomic, retain) NSNumber * dragonsKilledState;
@property (nonatomic, retain) NSNumber * fireElementalKilledState;

+(GameState*)shared;

-(void)saveApplicationData;
-(void)loadApplicationData;
-(void)initApplicationData;
-(void)resetApplicationData;
-(BOOL)isFirstRun;
-(void) resetSkillStates;

@end
