//
//  SettingsMenuLayer.m
//  L'Archer
//
//  Created by MiniclipMacBook on 4/16/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "SettingsMenuLayer.h"
#import "GameManager.h"
#import "GameState.h"
#import "SimpleAudioEngine.h"
#import "Config.h"


@implementation SettingsMenuLayer

-(id)init
{
  [super init];
  
  return self;
}

- (void)onEnter{
    [super onEnter];
    if ([[SimpleAudioEngine sharedEngine] mute])
    {
        
        
        [[SimpleAudioEngine sharedEngine] setMute:YES];
        [_mute setVisible:NO];
    }
    else
    {
        [[SimpleAudioEngine sharedEngine] setMute:NO];
        [_mute setVisible:YES];
    }
}

- (void) pressedMainMenu:(id)sender
{
    [[GameManager shared] runSceneWithID:kMainMenuScene];
};

- (void) toggleMute:(id)sender
{
    if ([[SimpleAudioEngine sharedEngine] mute])
    {
        [[SimpleAudioEngine sharedEngine] setMute:NO];
        [_mute setVisible:YES];
    }
    else
    {
        [[SimpleAudioEngine sharedEngine] setMute:YES];
        [_mute setVisible:NO];
    }
    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
};

- (void) resetUserDefaults:(id)sender{
   
    [[GameState shared] resetApplicationData];
    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
    
}
    
    
    


-(void)dealloc
{
    [self removeAllChildrenWithCleanup:YES];
    [super dealloc];
}
@end
