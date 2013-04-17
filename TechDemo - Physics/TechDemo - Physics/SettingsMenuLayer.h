//
//  SettingsMenuLayer.h
//  L'Archer
//
//  Created by MiniclipMacBook on 4/16/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SettingsMenuLayer : CCLayer {
    CCSprite * _mute;
}

- (void) pressedMainMenu:(id)sender;
- (void) toggleMute:(id)sender;

@end
