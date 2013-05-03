//
//  FireElemental.h
//  L'Archer
//
//  Created by jp on 03/05/13.
//
//

#import "Enemy.h"

@interface FireElemental : Enemy
{
    CCAction *walkAction;
    CCSequence *blastAction;
}

@property (nonatomic, retain) CCAction *walkAction;
@property (nonatomic, retain) CCSequence *blastAction;

-(void)attack;
@end