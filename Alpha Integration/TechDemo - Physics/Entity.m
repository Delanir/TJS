//
//  Entity.m
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "Entity.h"

@implementation Entity

// on "init" you need to initialize your instance
-(id) initWithSprite: (NSString*) spriteFile
{
    if( (self=[super init])) {
        
        [self setSprite:spriteFile];
        [self addChild:sprite];
    }
    
    return self;
}

- (CCSprite*) sprite
{
    return sprite;
}

- (void) setSprite:(NSString*)spr
{
    sprite = [CCSprite spriteWithFile:spr];
}

- (void) destroySprite
{
    [self removeChild:sprite cleanup:YES];
}

- (CGSize) spriteSize
{
    return [sprite contentSize];
}

@end
