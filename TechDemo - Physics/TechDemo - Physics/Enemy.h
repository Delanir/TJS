//
//  Enemy.h
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "Entity.h"

typedef enum {walk, attack, fly, land, hit, die} state;

@interface Enemy : Entity
{
    state currentState;
    float strength;
    float speed;
    unsigned int goldValue;
}

@property state currentState;
@property float strength;
@property float speed;
@property unsigned int goldValue;


- (id) initWithSprite:(NSString *)spriteFile;
-(void) setupActions;
-(void) attack;
-(void) die;
-(void) shout;
-(void) placeRandomly;

@end
