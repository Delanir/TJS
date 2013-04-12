//
//  EnemyFactory.h
//  TechDemo - Physics
//
//  Created by jp on 03/04/13.
//
//

#import <Foundation/Foundation.h>
#import "Peasant.h"
#import "FaerieDragon.h"

@interface EnemyFactory : CCScene
{
    
}

+(EnemyFactory*)shared;

-(Peasant*)generatePeasant;
-(FaerieDragon*)generateFaerieDragon;

@end


