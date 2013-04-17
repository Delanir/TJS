//
//  FaerieDragon.h
//  L'Archer
//
//  Created by jp on 12/04/13.
//
//

#import "Enemy.h"

@interface FaerieDragon : Enemy
{
    CCAction *flyAction;
    CCSequence *attackAction;
}

@property (nonatomic, retain) CCAction *flyAction;
@property (nonatomic, retain) CCSequence *attackAction;

-(void)attack;
@end
