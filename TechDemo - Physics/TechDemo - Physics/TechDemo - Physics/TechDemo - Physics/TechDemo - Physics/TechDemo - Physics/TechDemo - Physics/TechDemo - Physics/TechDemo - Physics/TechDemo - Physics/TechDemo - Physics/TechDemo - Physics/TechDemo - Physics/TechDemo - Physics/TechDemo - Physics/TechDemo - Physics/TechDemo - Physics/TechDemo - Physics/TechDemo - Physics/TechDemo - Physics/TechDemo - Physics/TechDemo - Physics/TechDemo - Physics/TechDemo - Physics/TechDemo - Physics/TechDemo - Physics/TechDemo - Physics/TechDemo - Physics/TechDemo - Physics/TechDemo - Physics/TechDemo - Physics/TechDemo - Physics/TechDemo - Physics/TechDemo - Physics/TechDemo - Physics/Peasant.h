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
    CCSequence *attackAction;
}

@property (nonatomic, retain) CCAction *walkAction;
@property (nonatomic, retain) CCSequence *attackAction;

-(void)attack;

@end
