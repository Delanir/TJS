//
//  Enemy.h
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "Entity.h"

@interface Enemy : Entity


- (id) initWithSprite:(NSString *)spriteFile
        andWindowSize:(CGSize) winSize;

@end
