//
//  MainMenuLayer.h
//  L'Archer
//
//  Created by MiniclipMacBook on 4/13/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import <GameKit/GameKit.h>

#import "CCBReader.h"

#import "LevelLayer.h"
#import "SpriteManager.h"
#import "Config.h"
// Sound interface
#import "SimpleAudioEngine.h"
// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

@interface MainMenuLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    
}
- (void) pressedPlay:(id)sender;
@end
