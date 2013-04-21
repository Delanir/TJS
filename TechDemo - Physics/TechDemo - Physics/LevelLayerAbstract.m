//
//  LevelLayerAbstract.m
//  L'Archer
//
//  Created by MiniclipMacBook on 4/17/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LevelLayerAbstract.h"


@implementation LevelLayerAbstract

-(id) init
{
    if( (self=[super init]))
    {
       
        self.isTouchEnabled = YES;
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        _pauseButton= [CCSprite spriteWithFile:@"pause.png"];
        [_pauseButton setPosition:CGPointMake(_pauseButton.contentSize.width/2.0, winSize.height - _pauseButton.contentSize.height/2.0)];

        [_pauseButton setZOrder:1000];

        [self addChild:_pauseButton];
        [self addChild:[WaveManager shared]]; // Esta linha é imensos de feia. Mas tem de ser para haver update
    }
    
    
    
    return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    [self pauseCheck:touch];
    [self gameOverReturnToMainMenuCheck:touch];
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

-(void) gameOverReturnToMainMenuCheck:(UITouch *)touchLocation {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CGPoint location=[touchLocation locationInView:[touchLocation view]];
    location.y=winSize.height-location.y;
    CGPoint btnPosition = _gameOver.mainMenuButtonPosition;
    float btnRadius = _gameOver.mainMenuButtonRadius/2;
    
    if (ccpDistance(btnPosition, location)<=btnRadius){
        [[CCDirector sharedDirector] resume];
        CCScene* gameScene = [CCBReader sceneWithNodeGraphFromFile:@"MainMenu.ccbi"];
        [[CCDirector sharedDirector] replaceScene:gameScene];
        
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

-(void) addEnemy:(Enemy *) newEnemy
{
    NSInteger zOrder = [[CCDirector sharedDirector] winSize].height - [newEnemy sprite].position.y;
    
    [self addChild:newEnemy z:zOrder];
    
    [[CollisionManager shared] addToTargets:newEnemy];
    [[ResourceManager shared] increaseEnemyCount];
}

-(void) gameOver
{
    _gameOver= (GameOver *)[CCBReader nodeGraphFromFile:@"GameOver.ccbi"];
    [self addChild:_gameOver];
    [_gameOver setZOrder:1535];
    [[CCDirector sharedDirector] pause];
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