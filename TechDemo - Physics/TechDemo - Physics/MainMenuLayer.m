//
//  MainMenuLayer.m
//  L'Archer
//
//  Created by MiniclipMacBook on 4/13/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MainMenuLayer.h"
#import "CCBReader.h"


#import "LevelLayer.h"
#import "SpriteManager.h"
#import "Config.h"
// Sound interface
#import "SimpleAudioEngine.h"
// Needed to obtain the Navigation Controller
#import "AppDelegate.h"


@implementation MainMenuLayer

-(void) onEnter
{
	[super onEnter];
    
    // ask director for the window size
	CGSize size = [[CCDirector sharedDirector] winSize];
    //Initialize art and animations
    [self addChild:[[SpriteManager shared] addSpritesToSpriteFrameCacheWithFile:@"lvl1spritesheet.plist" andBatchSpriteSheet:@"lvl1spritesheet.png"]];
    
    [[SpriteManager shared] addAnimationFromFile:@"peasant_anim.plist"];
    [[SpriteManager shared] addAnimationFromFile:@"fairiedragon_anim.plist"];
    [[SpriteManager shared] addAnimationFromFile:@"zealot_anim.plist"];
    [[SpriteManager shared] addAnimationFromFile:@"yurie_anim.plist"];
    [[SimpleAudioEngine sharedEngine] init];
}

- (void) pressedSettings:(id)sender
{
    CCLOG(@"Setting Menu");
}

- (void) pressedSkillTree:(id)sender
{
    CCLOG(@"Skilltree Menu");
}

- (void) pressedAchievments:(id)sender
{
    GKAchievementViewController *achivementViewController = [[GKAchievementViewController alloc] init];
    achivementViewController.achievementDelegate = self;
    
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    
    [[app navController] presentModalViewController:achivementViewController animated:YES];
    
    [achivementViewController release];
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
    
    
	// In one second transition to the new scene
	//[self scheduleOnce:@selector(makeTransition:) delay:1];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[LevelLayer scene] withColor:ccWHITE]];
    
    
}

//-(void) makeTransition:(ccTime)dt
//{
//	
//}

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
