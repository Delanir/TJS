//
//  EnemyFactory.h
//  TechDemo - Physics
//
//  Created by jp on 03/04/13.
//
//

#import <Foundation/Foundation.h>
#import "Config.h"
#import "Peasant.h"
#import "FaerieDragon.h"
#import "Zealot.h"

@interface EnemyFactory : CCScene
{
    NSArray * enemyTypes;
}

@property (nonatomic, retain) NSArray * enemyTypes;

+(EnemyFactory*)shared;

-(Peasant*)generatePeasant;
-(FaerieDragon*)generateFaerieDragon;
-(Zealot*)generateZealot;
-(Enemy*)generateEnemyWithType:(NSString*) type vertical:(int) vpos displacement:(CGPoint) disp;

@end


