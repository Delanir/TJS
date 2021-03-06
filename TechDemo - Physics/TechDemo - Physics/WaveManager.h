//
//  WaveManager.h
//  L'Archer
//
//  Created by jp on 18/04/13.
//
//

#import <Foundation/Foundation.h>
#import "NSMutableArray+QueueAdditions.h"
#import "Registry.h"
#import "EnemyFactory.h"
#import "Enemy.h"
#import "Utils.h"

@interface WaveManager : CCNode
{
    double intervalBetweenWaves;
    NSMutableArray *waves;
    NSString *currentTauntType;
}

@property double intervalBetweenWaves, timeElapsedSinceLastWave;
@property (nonatomic, retain) NSMutableArray* waves;
@property (nonatomic, retain) NSString *currentTauntType;
@property int enemies;

+(WaveManager*)shared;

-(void) initializeLevelLogic: (NSString *) level;
-(void) beginWaves;
-(void) stopWaves;
-(void) clearLevel;
-(BOOL) anymoreWaves;
-(void) dispatchTaunt;


@end
