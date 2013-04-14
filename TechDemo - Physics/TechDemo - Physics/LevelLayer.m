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
#import "FaerieDragon.h"
#import "StimulusFactory.h"
#import "Stimulus.h"

// Particle Systems
#import "CCParticleSystem.h"

// Sound interface
#import "SimpleAudioEngine.h"

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
    timeElapsedSinceBeginning += dt;
    
    if((int)floor(timeElapsedSinceBeginning) % 3 == 1)
        [self addPeasant];
    if((int)floor(timeElapsedSinceBeginning) % 8 == 1)
        [self addFaerieDragon];
    if((int)floor(timeElapsedSinceBeginning) % 5 == 1)
        [self addZealot];
}


-(void)addPeasant
{
    
    Peasant * peasant  = [[EnemyFactory shared] generatePeasant];
    
    NSInteger zOrder = [[CCDirector sharedDirector] winSize].height - [peasant sprite].position.y;
    
    [self addChild:peasant z:zOrder];
    
    peasant.tag = 1;
    [[CollisionManager shared] addToTargets:peasant];
}

-(void)addFaerieDragon
{
    FaerieDragon * faerieDragon = [[EnemyFactory shared] generateFaerieDragon];
    
    NSInteger zOrder = [[CCDirector sharedDirector] winSize].height - [faerieDragon sprite].position.y;
    
    [self addChild:faerieDragon z:zOrder];
    
    faerieDragon.tag = 3;
    [[CollisionManager shared] addToTargets:faerieDragon];
    
}

-(void)addZealot
{
    Zealot * zealot = [[EnemyFactory shared] generateZealot];
    
    NSInteger zOrder = [[CCDirector sharedDirector] winSize].height - [zealot sprite].position.y;
    
    [self addChild:zealot z:zOrder];
    
    zealot.tag = 4;
    [[CollisionManager shared] addToTargets:zealot];
    
}


// on "init" you need to initialize your instance
-(id) init
{
    if( (self=[super init]))
    {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        timeSinceLastArrow = 0.0f;
        timeElapsedSinceBeginning = 0.0f;
        
        //Startup sound
        //[[SimpleAudioEngine sharedEngine] setEffectsVolume:0.5f];
        //[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Battle1.mp3" loop:YES];
        
        MainScene *mainScene = [[MainScene alloc] initWithWinSize:winSize parent:self];
        [self addChild:mainScene z:0];
        [mainScene release];
        
        Yuri * yuri = [[Yuri alloc] initWithSprite:@"yurie.png"];
        yuri.position = ccp([yuri spriteSize].width/2 + 150, winSize.height/2 + 30);     // @Hardcoded - to correct
        [self addChild:yuri z:1000];
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
    // Update touch position
    
    // Choose one of the touches to work with
    UITouch *touch = [touches anyObject];
    location = [self convertTouchToNodeSpace:touch];
    location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
}

- (void) addProjectile:(CGPoint) alocation
{
    
    CCArray * stimulusPackage = [[CCArray alloc] init];
    [stimulusPackage addObject:[[StimulusFactory shared] generateColdStimulusWithValue:2]];
    [stimulusPackage addObject:[[StimulusFactory shared] generateDamageStimulusWithValue:2]];
    [stimulusPackage addObject:[[StimulusFactory shared] generatePushBackStimulusWithValue:2]];
    [stimulusPackage addObject:[[StimulusFactory shared] generateFireStimulusWithValue:2]];
    
    Arrow * arrow = [[Arrow alloc] initWithDestination:alocation andStimulusPackage:stimulusPackage];
    
    [stimulusPackage release];
    
    if(arrow != nil)
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"Swoosh.caf"];
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
    location = [touch  locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    
    //CCLOG(@">>> X: %f  Y: %f\n", location.x, location.y);
    
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
    
    if (fire && timeSinceLastArrow > 0.1)
    {
        timeSinceLastArrow = 0.0f;
        [self addProjectile:location];
    }
    
    [[CollisionManager shared] updatePixelPerfectCollisions:dt];
    [[CollisionManager shared] updateWallsAndEnemies:dt];
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
