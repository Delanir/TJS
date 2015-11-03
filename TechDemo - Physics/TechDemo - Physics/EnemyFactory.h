//
//  EnemyFactory.h
//  TechDemo - Physics
//
//  Created by jp on 03/04/13.
//
//

#import <Foundation/Foundation.h>
#import "Config.h"
#import "Enemy.h"

@interface EnemyFactory : CCScene
{
    float enemyChanceTotal;
    NSArray * enemyTypes;
}

@property (nonatomic, retain) NSArray * enemyTypes;
@property float enemyChanceTotal;

+(EnemyFactory*)shared;

-(Enemy*)generateEnemyWithType:(NSString*) type vertical:(int) vpos displacement:(CGPoint) disp taunt:(BOOL) isTaunt;
-(Enemy*)generateRandomEnemy;

@end


