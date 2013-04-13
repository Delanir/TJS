//
//  Zealot.h
//  L'Archer
//
//  Created by jp on 13/04/13.
//
//

#import "Enemy.h"

@interface Zealot : Enemy
{
    CCAction *walkAction;
    CCAction *attackAction;
}

@property (nonatomic, retain) CCAction *walkAction;
@property (nonatomic, retain) CCAction *attackAction;

-(void)attack;
@end