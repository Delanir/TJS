//
//  SettingsMenuLayer.m
//  L'Archer
//
//  Created by MiniclipMacBook on 4/16/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "SettingsMenuLayer.h"


@implementation SettingsMenuLayer

-(id)init{
  [super init];
  [[CCDirector sharedDirector] purgeCachedData];
  return self;
}

- (void) pressedMainMenu:(id)sender{
    // Load the game scene
    CCScene* gameScene = [CCBReader sceneWithNodeGraphFromFile:@"MainMenu.ccbi"];
    
    // Go to the game scene
    [[CCDirector sharedDirector] replaceScene:gameScene];
};
- (void) toggleMute:(id)sender{
    BOOL mute = [[SimpleAudioEngine sharedEngine] mute];
    if (mute) {
        [[SimpleAudioEngine sharedEngine] setMute:NO];
        [_mute setVisible:YES];
    }else{
        [[SimpleAudioEngine sharedEngine] setMute:YES];
        [_mute setVisible:NO];
    }
    
};
@end
