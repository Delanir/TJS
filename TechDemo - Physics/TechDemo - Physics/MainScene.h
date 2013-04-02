//
//  MainScene.h
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import <Foundation/Foundation.h>

#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"


@interface MainScene : CCNode
{
     CGSize winSize;
}


- (id) initWithWinSize: (CGSize) winSz;
- (void) setupScene;

@property CGSize winSize;

@end
