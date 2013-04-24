//
//  MainMenuLayer.m
//  L'Archer
//
//  Created by MiniclipMacBook on 4/13/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MainMenuLayer.h"
#import "Registry.h"
#import "GameManager.H"

@implementation MainMenuLayer

-(id)init{
    [super init];
    
    
    return self;
}

-(void)dealloc{
    [super dealloc];
//    [self removeAllChildrenWithCleanup:YES];
}

-(void) onEnter
{
	[super onEnter];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:[[Config shared] getStringProperty:@"MainMenuMusic"] loop:YES];
}


- (void) pressedSettings:(id)sender
{
    [[GameManager shared] runSceneWithID:kSettingsScene];
}

- (void) pressedSkillTree:(id)sender
{
    [[GameManager shared] runSceneWithID:kSkillTreeScene];
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
    [[GameManager shared] runSceneWithID:kSelectLevel];
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
