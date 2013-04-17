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
    CCSequence *attackAction;
}

@property (nonatomic, retain) CCAction *walkAction;
@property (nonatomic, retain) CCSequence *attackAction;

-(void)attack;
@end