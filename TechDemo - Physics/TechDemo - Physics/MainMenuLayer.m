//
//  MainMenuLayer.m
//  L'Archer
//
//  Created by MiniclipMacBook on 4/13/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MainMenuLayer.h"
#import "Registry.h"
#import "GameManager.h"
#import "SkillTreeLayer.h"
#import "GameState.h"

@implementation MainMenuLayer

-(id)init{
    [super init];
    
    
    
    return self;
}

-(void)dealloc
{
    [super dealloc];
    //    [self removeAllChildrenWithCleanup:YES];
}

-(void) onEnter
{
	[super onEnter];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:[[Config shared] getStringProperty:@"MainMenuMusic"] loop:YES];
//    [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:1.0f];
    
    // Calculate number of used stars
    NSMutableArray *skillPoints = [[GameState shared] skillStates];
    int usedSkillPoints = 0;
    for (int i = 0; i < 28; i++) {
        usedSkillPoints += [[skillPoints objectAtIndex:i] intValue];
    }
    
    // Calculate number of total stars
    int stars = 0;
    int totalStars =[[[GameState shared] starStates] count];
    int aux;
    for (int i = 1; i <= totalStars; i++)
    {
        
        aux =[[[[GameState shared] starStates] objectAtIndex:i-1] intValue];
        stars = stars + aux;
        
    }
    
    int res = DEFAULTSKILLPOINTS + stars - usedSkillPoints;
    if (res>0) {
        [lblNotification setVisible:YES];
        [spriteNotification setVisible:YES];
        [lblNotification setString:[NSString stringWithFormat:@"%i", res]];
    }else{
        [lblNotification setVisible:NO];
        [spriteNotification setVisible:NO];
    }
    
    
}

- (void)onExit{
    [self removeAllChildrenWithCleanup:YES];
    
    //[[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    //[[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super onExit];
}


- (void) pressedSettings:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
    [[GameManager shared] runSceneWithID:kSettingsScene];
}

- (void) pressedSkillTree:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
    [[GameManager shared] runSceneWithID:kSkillTreeScene];
}

- (void) pressedAchievments:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
    [[GameManager shared] runSceneWithID:kAchievementsScene];
    //    GKAchievementViewController *achievementViewController = [[GKAchievementViewController alloc] init];
    //    achievementViewController.achievementDelegate = self;
    //
    //    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    //
    //    [[app navController] presentViewController:achievementViewController animated:YES completion:nil];
    //
    //    [achievementViewController release];
}

- (void) pressedLeaderboard:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
    GKLeaderboardViewController *leaderboardViewController = [[GKLeaderboardViewController alloc] init];
    leaderboardViewController.leaderboardDelegate = self;
    
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    
    [[app navController] presentViewController:leaderboardViewController animated:YES completion:nil];
    
    [leaderboardViewController release];
}

- (void) pressedPlay:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
    if ([[GameState shared] isFirstRun]) 
        [[GameManager shared] runSceneWithID:kSkillTreeScene];
    else
        [[GameManager shared] runSceneWithID:kSelectLevel];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissViewControllerAnimated:YES completion:nil];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissViewControllerAnimated:YES completion:nil];
}

@end
