//
//  MainScene.h
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import <Foundation/Foundation.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

#import "Wall.h"


@interface MainScene : CCNode
{
    CGSize winSize;
    
}


- (id) initWithWinSize: (CGSize) winSz parent: (CCNode*) parent;


@property CGSize winSize;

@end
