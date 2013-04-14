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
}

@property state currentState;

- (id) initWithSprite:(NSString *)spriteFile
        andWindowSize:(CGSize) winSize;
-(void)attack;
-(void)die;

@end
