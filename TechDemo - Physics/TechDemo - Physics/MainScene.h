//
//  MainScene.h
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import <Foundation/Foundation.h>
#import "Registry.h"

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

#import "Wall.h"


@interface MainScene : CCNode
{
    CCSprite * background;
    
}

@property (nonatomic, retain) CCSprite * background;

- (void) setBackgroundWithSpriteType:(NSString *) type;

@end
