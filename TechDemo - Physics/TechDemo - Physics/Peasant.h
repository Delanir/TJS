//
//  Peasant.h
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "Enemy.h"

@interface Peasant : Enemy
{
    CCAction *walkAction;
    CCAction *attackAction;
    BOOL _moving;
}

@property (nonatomic, retain) CCAction *walkAction;
@property (nonatomic, retain) CCAction *attackAction;

-(void)attack;

@end
