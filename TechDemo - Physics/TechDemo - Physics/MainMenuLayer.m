//
//  MainMenuLayer.m
//  L'Archer
//
//  Created by MiniclipMacBook on 4/13/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MainMenuLayer.h"
#import "Registry.h"

@implementation MainMenuLayer

-(id)init{
    [super init];
    
    
    return self;
}

-(void) onEnter
{
	[super onEnter];
    [[CCDirector sharedDirector] purgeCachedData];
}


- (void) pressedSettings:(id)sender
{
    CCScene* gameScene = [CCBReader sceneWithNodeGraphFromFile:@"SettingsMenu.ccbi"];
    
    [[CCDirector sharedDirector] replaceScene:gameScene];
}

- (void) pressedSkillTree:(id)sender
{
    CCScene* gameScene = [CCBReader sceneWithNodeGraphFromFile:@"SkillTreeLayer.ccbi"];
    
    [[CCDirector sharedDirector] replaceScene:gameScene];
}

- (void) pressedAchievments:(id)sender
{
    GKAchievementViewController *achievementViewController = [[GKAchievementViewController alloc] init];
    achievementViewController.achievementDelegate = self;
    
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    
    [[app navController] presentModalViewController:achievementViewController animated:YES];
    
    [achievementViewController release];
}

- (void) pressedLeaderboard:(id)sender
{
    GKLeaderboardViewController *leaderboardViewController = [[GKLeaderboardViewController alloc] init];
    leaderboardViewController.leaderboardDelegate = self;
    
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    
    [[app navController] presentModalViewController:leaderboardViewController animated:YES];
    
    [leaderboardViewController release];
}

- (void) pressedPlay:(id)sender
{
    CCScene* gameScene = [CCBReader sceneWithNodeGraphFromFile:@"LevelSelectLayer.ccbi"];
    
    // Go to the game scene
    [[CCDirector sharedDirector] replaceScene:gameScene];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

@end
