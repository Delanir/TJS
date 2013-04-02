//
//  Level.m
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

// Import the interfaces
#import "LevelLayer.h"
#import "MainScene.h"
#import "Yuri.h"
#import "Peasant.h"
#import "Arrow.h"
#import "CollisionManager.h"
#import "Config.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - Level

// HelloWorldLayer implementation
@implementation LevelLayer

// Helper class method that creates a Scene
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	LevelLayer *level = [LevelLayer node];
	
	// add layer as a child to scene
	[scene addChild: level];
	
	// return the scene
	return scene;
}

-(void)gameLogic:(ccTime)dt
{
    [self addTarget];
}


-(void)addTarget
{
    
    // Determine where to spawn the target along the Y axis
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    Enemy *peasant = [[Peasant alloc] initWithSprite:@"Target.png" andWindowSize:winSize];
    
    [self addChild:peasant];
    
    peasant.tag = 1;
    [[CollisionManager shared] addToTargets:peasant];
    
    [peasant release];
    
}


// on "init" you need to initialize your instance
-(id) init
{
    if( (self=[super init]))
    {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        
        //TODO criar Main Scene (antes do Yuri)
        MainScene *mainScene = [[MainScene alloc] initWithWinSize:winSize];
        [self addChild:mainScene z:0];
        [mainScene release];
        
        Yuri * yuri = [[Yuri alloc] initWithSprite:@"Player.png"];
        yuri.position = ccp([yuri spriteSize].width/2 + 50, winSize.height/2);
        [self addChild:yuri z:1];
        [yuri release];
        
        // This dummy method initializes the collision manager
        [[CollisionManager shared] dummyMethod];
        
        [self schedule:@selector(update:)];
    }
    
    self.isTouchEnabled = YES;
    [self schedule:@selector(gameLogic:) interval:1.0];
    
    return self;
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Choose one of the touches to work with
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    // Set up initial location of projectile
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    Arrow * arrow = [[Arrow alloc] initWithSprite: @"Projectile.png" andLocation:location andWindowSize:winSize];
    if(arrow != nil)
    {
        [self addChild:arrow];
        arrow.tag = 2;
        [[CollisionManager shared] addToProjectiles:arrow];
    }
    [arrow release];
    
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    //Dealloc stuff below this line
	[super dealloc];
}

- (void)update:(ccTime)dt {
    
    if([[Config shared] getIntProperty:@"collisionMethod"] == 0)
        [[CollisionManager shared] updateSimpleCollisions:dt];
    else [[CollisionManager shared] updatePixelPerfectCollisions:dt];
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
