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
#import "EnemyFactory.h"
#import "SpriteManager.h"

// Sound interface
#import "SimpleAudioEngine.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - Level

// HelloWorldLayer implementation
@implementation LevelLayer

@synthesize toggleUpdate;

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
    
    Peasant * peasant  = [[EnemyFactory shared] generatePeasant];
    
    [self addChild:peasant];
    
    peasant.tag = 1;
    [[CollisionManager shared] addToTargets:peasant];
    
}


// on "init" you need to initialize your instance
-(id) init
{
    if( (self=[super init]))
    {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        timeSinceLastArrow = 0.0f;
        
        //Startup sound
        [[SimpleAudioEngine sharedEngine] setEffectsVolume:0.5f];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Battle1.mp3" loop:YES];
        
        MainScene *mainScene = [[MainScene alloc] initWithWinSize:winSize];
        [self addChild:mainScene z:0];
        [mainScene release];
         
        Yuri * yuri = [[Yuri alloc] initWithSprite:@"yurie_lvl3_small.png"];
        yuri.position = ccp([yuri spriteSize].width/2 + 150, winSize.height/2 + 30);     // @Hardcoded - to correct
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


-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  fire = NO;
}



-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  fire = YES;
    if(timeSinceLastArrow > 0.2)
    {
        // Choose one of the touches to work with
        UITouch *touch = [touches anyObject];
        
        location = [self convertTouchToNodeSpace:touch];
    
        timeSinceLastArrow = 0.0f;
    
    }
}

- (void) addProjectile:(CGPoint) alocation
{
  // Set up initial location of projectile
  CGSize winSize = [[CCDirector sharedDirector] winSize];
  
  Arrow * arrow = [[Arrow alloc] initWithSprite: @"Projectile.png" andLocation:alocation andWindowSize:winSize];
#warning TODO 
//  ps = [[CCParticleSun node] retain];
#warning README A linha a cima estava descomentada. Estava a largar particulas q nunca eram destruídas
  if(arrow != nil)
  {
    [[SimpleAudioEngine sharedEngine] playEffect:@"hit.mp3"];
    [self addChild:arrow];
    arrow.tag = 2;
    [[CollisionManager shared] addToProjectiles:arrow];
  }
  [arrow release];
  arrow=nil;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  fire = YES;
  
  // Choose one of the touches to work with
  UITouch *touch = [touches anyObject];
  location = [self convertTouchToNodeSpace:touch];
  location = [touch locationInView:[touch view]];
  location = [[CCDirector sharedDirector] convertToGL:location];
  
  if(location.x > 950 && location.y > 690)
  {
    self.toggleUpdate = !self.toggleUpdate;
    return;
  }
  CCLOG(@"TOUCH PRESSED");
  CCLOG(@">>> X: %f  Y: %f\n", location.x, location.y);
    

}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    //Dealloc stuff below this line
	[super dealloc];
}

- (void)update:(ccTime)dt
{    
    timeSinceLastArrow += dt;
  
  

  
  if (fire) {
    
      [self addProjectile:location];

//#ifdef DEBUG
//    CCLOG(@"FIRE");
//#endif
  }
  
  
  //  if([[Config shared] getIntProperty:@"collisionMethod"] == 0)
  //      [[CollisionManager shared] updateSimpleCollisions:dt];
  //  else [[CollisionManager shared] updatePixelPerfectCollisions:dt];
      if(toggleUpdate)
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
