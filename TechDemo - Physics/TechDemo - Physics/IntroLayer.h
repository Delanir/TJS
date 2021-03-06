//
//  IntroLayer.h
//  TechDemo - Physics
//
//  Created by jp on 30/03/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "LevelLayer.h"
#import "SpriteManager.h"
#import "Config.h"
// Sound interface
#import "SimpleAudioEngine.h"
#import "CCBReader.h"

// HelloWorldLayer
@interface IntroLayer : CCLayer
{
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
