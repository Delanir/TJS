//
//  Entity.h
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

@interface Entity : CCNode
{
    CCSprite * sprite;
}

- (id) initWithSprite: (NSString*) spriteFile;
- (void) setSprite: (NSString*) spr;
- (void) destroySprite;
- (CCSprite*) sprite;
- (CGSize) spriteSize;

@end
