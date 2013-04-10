//
//  SpriteManager.h
//  Alpha Integration
//
//  Created by MiniclipMacBook on 4/7/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "Entity.h"

@interface Wall : Entity
- (id) initWithSpriteFromFile:(NSString *)spriteFile andWindowSize:(CGSize) winSize;

@end
