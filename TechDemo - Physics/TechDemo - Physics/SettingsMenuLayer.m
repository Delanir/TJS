//
//  SettingsMenuLayer.m
//  L'Archer
//
//  Created by MiniclipMacBook on 4/16/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "SettingsMenuLayer.h"
#import "GameManager.h"


@implementation SettingsMenuLayer

-(id)init
{
  [super init];
  
  return self;
}

- (void) pressedMainMenu:(id)sender
{
    [[GameManager shared] runSceneWithID:kMainMenuScene];
};

- (void) toggleMute:(id)sender
{
    BOOL mute = [[SimpleAudioEngine sharedEngine] mute];
    if (mute)
    {
        [[SimpleAudioEngine sharedEngine] setMute:NO];
        [_mute setVisible:YES];
    }
    else
    {
        [[SimpleAudioEngine sharedEngine] setMute:YES];
        [_mute setVisible:NO];
    }
    
};

-(void)dealloc{
    [super dealloc];
    [self removeAllChildrenWithCleanup:YES];
}
@end
