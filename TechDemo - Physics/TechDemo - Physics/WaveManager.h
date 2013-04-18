//
//  WaveManager.h
//  L'Archer
//
//  Created by jp on 18/04/13.
//
//

#import <Foundation/Foundation.h>
#import "NSMutableArray+QueueAdditions.h"

@interface WaveManager : CCNode
{
    double intervalBetweenWaves;
    NSMutableArray *waves;
}

@property double intervalBetweenWaves, timeElapsedSinceLastWave;
@property (nonatomic, retain) NSMutableArray* waves;

+(WaveManager*)shared;

-(void) initializeLevelLogic: (NSString *) level;
-(void) beginWaves;
-(void) stopWaves;
-(void) clearLevel;

#warning criar classe utils
-(NSDictionary *) openPlist: (NSString *) plist;

@end
