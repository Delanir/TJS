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
        [self setSpriteWithSpriteFrameName:spriteFile];
        [self addChild:sprite];
    }
    
    return self;
}

-(void) dealloc
{
    [sprite release];
    [super dealloc];
}

- (KKPixelMaskSprite*) sprite
{
    return sprite;
}

- (void) setSprite:(NSString*)spr
{
    //sprite = [KKPixelMaskSprite spriteWithFile:spr alphaThreshold:0];
    sprite = [KKPixelMaskSprite spriteWithSpriteFrameName:spr];

    [sprite retain];
}

- (void) setSpriteWithSpriteFrameName:(NSString*)spr
{
    sprite = [KKPixelMaskSprite spriteWithSpriteFrameName:spr alphaThreshold:0];
    [sprite retain];
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
