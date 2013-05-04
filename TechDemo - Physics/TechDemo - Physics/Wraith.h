//
//  Wraith.h
//  L'Archer
//
//  Created by jp on 03/05/13.
//
//

#import "Enemy.h"

@interface Wraith : Enemy
{
    CCAction *walkAction;
    CCSequence *attackAction;
}

@property (nonatomic, retain) CCAction *walkAction;
@property (nonatomic, retain) CCSequence *attackAction;

-(void)attack;
@end