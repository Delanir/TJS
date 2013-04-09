//
//  SpriteManager.h
//  Alpha Integration
//
//  Created by MiniclipMacBook on 4/7/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SpriteManager : CCNode {
    
}
+(SpriteManager*)shared;
+ (CCSpriteBatchNode *) addSpritesToSpriteFrameCacheWithFile: (NSString *)filePlist andBatchSpriteSheet: (NSString *)filePng;
- (void) addAnimationFromFile: (NSString *)file;

@end
