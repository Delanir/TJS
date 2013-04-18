//
//  LevelLayerAbstract.m
//  L'Archer
//
//  Created by MiniclipMacBook on 4/17/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LevelLayerAbstract.h"
#import "MainScene.h"
#import "Yuri.h"
#import "Peasant.h"
#import "CollisionManager.h"
#import "Config.h"
#import "EnemyFactory.h"
#import "SpriteManager.h"
#import "FaerieDragon.h"
#import "Arrow.h"
#import "StimulusFactory.h"
#import "Stimulus.h"

// Particle Systems
#import "CCParticleSystem.h"

// Sound interface
#import "SimpleAudioEngine.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

@implementation LevelLayerAbstract

-(id) init
{
    if( (self=[super init]))
    {
       
        self.isTouchEnabled = YES;
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        _pauseButton= [CCSprite spriteWithFile:@"pause.png"];
//        [_pauseButton setAnchorPoint:CGPointMake(0.5f, 0.5f)];
        [_pauseButton setPosition:CGPointMake(_pauseButton.contentSize.width/2.0, winSize.height - _pauseButton.contentSize.height/2.0)];

        [_pauseButton setZOrder:1000];

        [self addChild:_pauseButton];
    }
    
    
    
    return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    [self pauseCheck:touch];
    if ([[CCDirector sharedDirector] isPaused]) {
        return;
    }
    
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if ([[CCDirector sharedDirector] isPaused]) {
        return;
    }
    
}

-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([[CCDirector sharedDirector] isPaused]) {
        return;
    }
}

-(void) pauseCheck:(UITouch *)touchLocation {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CGPoint location=[touchLocation locationInView:[touchLocation view]];
    location.y=winSize.height-location.y;
    CGPoint pausePosition = _pauseButton.position;
    float pauseRadius = _pauseButton.contentSize.width/2;
    
    if (ccpDistance(pausePosition, location)<=pauseRadius){
        [self togglePause];
    }
}

-(void) togglePause
{
    if ([[CCDirector sharedDirector] isPaused]) {
        [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
        [[CCDirector sharedDirector] resume];
        
    } else {
        [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
        
        [[CCDirector sharedDirector] pause];
    }
    
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
