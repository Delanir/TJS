//
//  EnemyManager.h
//  Alpha Integration
//
//  Created by MiniclipMacBook on 4/7/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Enemy.h"

@interface EnemyManager : CCNode {
    NSMutableArray * _enemies;
}
+(EnemyManager*)shared;
-(void)removeEnemy: (Enemy*) target;
-(void)addToEnemies: (Enemy*) target;

@end
