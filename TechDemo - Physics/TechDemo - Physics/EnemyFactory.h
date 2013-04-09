//
//  EnemyFactory.h
//  TechDemo - Physics
//
//  Created by jp on 03/04/13.
//
//

#import <Foundation/Foundation.h>
#import "Peasant.h"

@interface EnemyFactory : CCScene
{
    
}

+(EnemyFactory*)shared;

-(Peasant*)generatePeasant;

@end


