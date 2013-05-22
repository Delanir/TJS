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
#import "Registry.h"


@implementation SettingsMenuLayer

-(id)init
{
  [super init];
#ifdef kDebugMode
    [[Registry shared] addToCreatedEntities:self];
#endif
  return self;
}

- (void)onEnter{
    [super onEnter];
    maxScale = [_volume scaleX];
    [_volume setScaleX:maxScale* [[SimpleAudioEngine sharedEngine] backgroundMusicVolume]];
    
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

- (void) moreBackgroundVolume:(id)sender{
    
    if ([[SimpleAudioEngine sharedEngine] backgroundMusicVolume] <0.99f) {
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:([[SimpleAudioEngine sharedEngine] backgroundMusicVolume]+0.1f)],
        [_volume setScaleX:maxScale* [[SimpleAudioEngine sharedEngine] backgroundMusicVolume]];
    }
    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
    

    
};
- (void) lessBackgroundVolume:(id)sender{
   
    if ([[SimpleAudioEngine sharedEngine] backgroundMusicVolume] >0.01f) {
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:([[SimpleAudioEngine sharedEngine] backgroundMusicVolume]-0.1f)],
        [_volume setScaleX:maxScale* [[SimpleAudioEngine sharedEngine] backgroundMusicVolume]];
        
        
    }
    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
};

- (void) moreFXVolume:(id)sender{
    
    if ([[SimpleAudioEngine sharedEngine] effectsVolume] <0.99f) {
        
        [[SimpleAudioEngine sharedEngine] setEffectsVolume:([[SimpleAudioEngine sharedEngine] effectsVolume]+0.1f)],
        [_volumefx setScaleX:maxScale* [[SimpleAudioEngine sharedEngine] effectsVolume]];
    }
    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
//    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"ShootArrowSound"]];
    
    
};
- (void) lessFXVolume:(id)sender{
    
    if ([[SimpleAudioEngine sharedEngine] effectsVolume] >0.01f) {
        [[SimpleAudioEngine sharedEngine] setEffectsVolume:([[SimpleAudioEngine sharedEngine] effectsVolume]-0.1f)],
        [_volumefx setScaleX:maxScale* [[SimpleAudioEngine sharedEngine] effectsVolume]];
        
        
    }
    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
//    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"ShootArrowSound"]];
};


    
- (void)onExit
{
    [self release];
    [self removeAllChildrenWithCleanup:YES];
    
    //[[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    //[[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super onExit];
}

-(void)dealloc
{
#ifdef kDebugMode
    [[Registry shared] addToDestroyedEntities:self];
#endif
    [super dealloc];
}

    

@end
