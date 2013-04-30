//
//  SettingsMenuLayer.h
//  L'Archer
//
//  Created by MiniclipMacBook on 4/16/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCBReader.h"
#import "SimpleAudioEngine.h"

@interface SettingsMenuLayer : CCLayer
{
    CCSprite * _mute;
}

- (void) pressedMainMenu:(id)sender;
- (void) toggleMute:(id)sender;
- (void) resetUserDefaults:(id)sender;

@end
