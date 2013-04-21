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

// on "init" you need to initialize your instance
-(id) initWithSpriteFromFile: (NSString*) spriteFile
{
  if( (self=[super init])) {
    [self setSprite:spriteFile];
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
    sprite = [KKPixelMaskSprite spriteWithFile:spr alphaThreshold:0.8f];
    [sprite retain];
    
    sprite.anchorPoint=ccp(0.5f,0.5f);
    sprite.zOrder = [[CCDirector sharedDirector] winSize].height - sprite.position.y;
    

}

- (void) setSpriteWithSpriteFrameName:(NSString*)spr
{
    sprite = [KKPixelMaskSprite spriteWithSpriteFrameName:spr alphaThreshold:0.8f];
    [sprite retain];
    
    sprite.anchorPoint=ccp(0.5f,0.5f);
    sprite.zOrder = [[CCDirector sharedDirector] winSize].height - sprite.position.y;
}

- (void) destroySprite
{
    [self removeChild:sprite cleanup:YES];
}

- (CGSize) spriteSize
{
    return [sprite contentSize];
}

- (void) destroy
{
    [self removeAllChildrenWithCleanup:YES];
}

@end
