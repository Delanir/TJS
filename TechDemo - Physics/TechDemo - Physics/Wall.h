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

typedef enum {mint, scratched, damaged, wrecked, totaled} wallStatus;

@interface Wall : Entity
{
    double health, lastHealth;
    wallStatus status;
    NSMutableArray *sprites;
    CCNode * parentNode;
}

@property (nonatomic) double health, lastHealth;
@property (nonatomic, retain) CCNode * parentNode;


-(id) initWithParent: (CCNode*) parent;


@end
