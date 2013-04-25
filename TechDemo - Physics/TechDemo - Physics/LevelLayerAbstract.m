//
//  LevelLayerAbstract.m
//  L'Archer
//
//  Created by MiniclipMacBook on 4/17/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "LevelLayerAbstract.h"
#import "GameManager.h"


@implementation LevelLayerAbstract


-(id) init
{
    if( (self=[super init]))
    {
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        _pauseButton= [CCSprite spriteWithFile:@"pause.png"];
        [_pauseButton setPosition:CGPointMake(_pauseButton.contentSize.width/2.0, winSize.height - _pauseButton.contentSize.height/2.0)];
        
        [_pauseButton setZOrder:1000];
        
        [self addChild:_pauseButton];
        [[WaveManager shared] removeFromParentAndCleanup:NO];
        [self addChild:[WaveManager shared]]; // Esta linha é imensos de feia. Mas tem de ser para haver update
        
        
            _pause= (PauseHUD *)[CCBReader nodeGraphFromFile:@"PauseMenu.ccbi"];
            [self addChild:_pause];
        
        [_pause setZOrder:1535];
        [_pause setVisible:NO];
    }
    return self;
}


- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    [self pauseCheck:touch];
    [self gameOverReturnToMainMenuCheck:touch];
    [self gameWinReturnToMainMenuCheck:touch];
    if ([[CCDirector sharedDirector] isPaused])
        return;    
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([[CCDirector sharedDirector] isPaused])
        return;
}

-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([[CCDirector sharedDirector] isPaused])
        return;
}

-(void) pauseCheck:(UITouch *)touchLocation
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CGPoint location=[touchLocation locationInView:[touchLocation view]];
    location.y=winSize.height-location.y;
    CGPoint pausePosition = _pauseButton.position;
    float pauseRadius = _pauseButton.contentSize.width/2;
    
    CGPoint pausePosition2 = [[_pause getPauseButton] position];
    float pauseRadius2 = [[_pause getPauseButton] contentSize].width/2;
    
    if (ccpDistance(pausePosition, location)<=pauseRadius || (_pause.visible&&ccpDistance(pausePosition2, location)<=pauseRadius2)){
        [self togglePause];
    }
}

-(void) gameOverReturnToMainMenuCheck:(UITouch *)touchLocation
{
    if (_gameOver!=nil) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CGPoint location=[touchLocation locationInView:[touchLocation view]];
        location.y=winSize.height-location.y;
        CGPoint btnPosition = _gameOver.mainMenuButtonPosition;
        float btnRadius = _gameOver.mainMenuButtonRadius/2;
        
        if ( ccpDistance(btnPosition, location)<=btnRadius)
        {
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
            [self setIsTouchEnabled:NO];
            [[CCDirector sharedDirector] resume];
            
            [[GameManager shared] runSceneWithID:kMainMenuScene];
            
        }
    }else
        return;
    
}

-(void) gameWinReturnToMainMenuCheck:(UITouch *)touchLocation
{
#warning calcular pontuacao e atribuir estrelas ou flores de lis
    if (_gameWin!=nil) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CGPoint location=[touchLocation locationInView:[touchLocation view]];
        location.y=winSize.height-location.y;
        CGPoint btnPosition = _gameWin.mainMenuButtonPosition;
        float btnRadius = _gameWin.mainMenuButtonRadius/2;
        
        if ( ccpDistance(btnPosition, location)<=btnRadius)
        {
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
            [self setIsTouchEnabled:NO];
            [[CCDirector sharedDirector] resume];
            
            [[GameManager shared] runSceneWithID:kMainMenuScene];
            
        }
    }else
        return;
    
}

-(void) togglePause
{
    if ([[CCDirector sharedDirector] isPaused] && _gameOver==nil)
    {
        [_pause setVisible:NO];
        [[SimpleAudioEngine sharedEngine] resumeBackgroundMusic];
        [[CCDirector sharedDirector] resume];
        
    } else if(_gameOver==nil&&(![[CCDirector sharedDirector] isPaused]))
    {
        [_pause setVisible:YES];
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

-(void) gameWin
{
    _gameWin = (GameWin *)[CCBReader nodeGraphFromFile:@"GameWin.ccbi"];
    [self addChild:_gameWin];
    [_gameWin setZOrder:1535];
    [[CCDirector sharedDirector] pause];
    
    [self calculateAndUpdateNumberOfStars];
}

-(void) calculateAndUpdateNumberOfStars
{
    
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
