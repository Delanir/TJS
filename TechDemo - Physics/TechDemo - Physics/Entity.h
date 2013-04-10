//
//  Entity.h
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// For pixel-perfect collisions
#import "KKPixelMaskSprite.h"

@interface Entity : CCNode
{
    KKPixelMaskSprite * sprite;
}

- (id) initWithSprite: (NSString*) spriteFile;
- (void) setSprite: (NSString*) spr;
- (void) setSpriteWithSpriteFrameName:(NSString*)spr;
- (void) destroySprite;
- (KKPixelMaskSprite*) sprite;
- (CGSize) spriteSize;

@end
