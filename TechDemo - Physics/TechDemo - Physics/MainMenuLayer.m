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
#import "LoadingEffect.h"

@implementation MainMenuLayer

-(id)init
{
    [super init];
    
#ifdef kDebugMode
    [[Registry shared] addToCreatedEntities:self];
#endif
    return self;
}

-(void)dealloc
{
#ifdef kDebugMode
    [[Registry shared] addToDestroyedEntities:self];
#endif
    [super dealloc];
    //    [self removeAllChildrenWithCleanup:YES];
}

-(void) onEnter
{
	[super onEnter];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:[[Config shared] getStringProperty:@"MainMenuMusic"] loop:YES];
    [[SpriteManager shared] addSpritesToSpriteFrameCacheWithFile:@"MenuSpritesheet.plist" andBatchSpriteSheet:@"MenuSpritesheet.png"];
    
    // Calculate number of used stars
    NSMutableArray *skillPoints = [[GameState shared] skillStates];
    int usedSkillPoints = 0;
    for (int i = 0; i < 28; i++)
        usedSkillPoints += [[skillPoints objectAtIndex:i] intValue];
    
    // Calculate number of total stars
    int stars = [[ResourceManager shared] determineSkillPoints];
    
    int res = DEFAULTSKILLPOINTS + stars - usedSkillPoints;
    if (res>0)
    {
        [lblNotification setVisible:YES];
        [spriteNotification setVisible:YES];
        [lblNotification setString:[NSString stringWithFormat:@"%i", res]];
    }
    else
    {
        [lblNotification setVisible:NO];
        [spriteNotification setVisible:NO];
    }
    [NSThread detachNewThreadSelector:@selector(loading) toTarget:self  withObject:self];

//Uncomment for interesting effect
    //[[[self children] objectAtIndex:0] setZOrder:0];
    //for (int i = 1 ; i < [[self children] count] ; i++)
    //    [[[self children] objectAtIndex:i] setZOrder:2];
    
}

-(void) onEnterTransitionDidFinish
{
#ifdef kDebugMode
    [[Registry shared] printAllExistingEntities];
#endif
}

- (void)onExit
{
    [self unscheduleAllSelectors];
    [self removeAllChildrenWithCleanup:YES];
    
    //[[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
    //[[CCTextureCache sharedTextureCache] removeUnusedTextures];
    [super onExit];
}



- (void) loading
{
    NSAutoreleasePool *autoreleasepool = [[NSAutoreleasePool alloc] init];
    //Create a shared opengl context so this texture can be shared with main context
    EAGLContext *k_context = [[EAGLContext alloc]
                              initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:k_context];
    
    LoadingEffect * le = [[LoadingEffect alloc] init];
    [self addChild:le z:1];
    [le release];
    [autoreleasepool release];
    [NSThread exit];
    
}

- (void) pressedSettings:(id)sender
{
    [NSThread detachNewThreadSelector:@selector(loading) toTarget:self  withObject:self];
    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
    [[GameManager shared] runSceneWithID:kSettingsScene];
}

- (void) pressedSkillTree:(id)sender
{
    [NSThread detachNewThreadSelector:@selector(loading) toTarget:self  withObject:self];
    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
    [[GameManager shared] runSceneWithID:kSkillTreeScene];
}

- (void) pressedAchievments:(id)sender
{
    [NSThread detachNewThreadSelector:@selector(loading) toTarget:self  withObject:self];
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
