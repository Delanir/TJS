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
#import "CollisionManager.h"
#import "Config.h"
#import "EnemyFactory.h"
#import "SpriteManager.h"
#import "FaerieDragon.h"
#import "Arrow.h"
#import "StimulusFactory.h"
#import "Stimulus.h"
#import "Registry.h"
#import "ResourceManager.h"


// Particle Systems
#import "CCParticleSystem.h"

// Sound interface
#import "SimpleAudioEngine.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - Level

// HelloWorldLayer implementation
@implementation LevelLayer
@synthesize hud;

// Helper class method that creates a Scene
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	LevelLayer *level = [LevelLayer node];
    Hud *levelHud = [Hud node];
	
	// add layer as a child to scene
	[scene addChild: level];
	[scene addChild: levelHud];
    
    level.hud = levelHud;
    
	// return the scene
	return scene;
}

-(void)gameLogic:(ccTime)dt
{
    timeElapsedSinceBeginning += dt;
    
    if((int)floor(timeElapsedSinceBeginning) % 4 == 1)
        [self addPeasant];
    if((int)floor(timeElapsedSinceBeginning) % 10 == 1)
        [self addFaerieDragon];
    if((int)floor(timeElapsedSinceBeginning) % 6 == 1)
        [self addZealot];

    
}

-(void) onEnter
{
    //Startup sound
    [super onEnter];
}


// on "init" you need to initialize your instance
-(id) init
{
    if( (self=[super init]))
    {
        [[Registry shared] registerEntity:self withName:@"LevelLayer"];
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Battle1.mp3" loop:YES];

        CGSize winSize = [[CCDirector sharedDirector] winSize];
        timeElapsedSinceBeginning = 2.0f;
        fire = NO;
        
        // Criação da cena com castelo
        MainScene *mainScene = [[MainScene alloc] init];
        [self addChild:mainScene z:0];
        [mainScene release];
        
        // Meter yuri na cena
        Yuri * yuri = [[Yuri alloc] init];
        yuri.position = ccp([yuri spriteSize].width/2 + 120, winSize.height/2 + 30);     // @Hardcoded - to correct
        [yuri setTag:9];
        [self addChild:yuri z:1000];
        [[Registry shared] registerEntity:yuri withName:@"Yuri"];
        [yuri release];
        
        
        // inicializar recursos
        [self initializeResources];
        
        // This dummy method initializes the collision manager
        [[CollisionManager shared] dummyMethod];
      
        [self schedule:@selector(update:)];
    }
    
    self.isTouchEnabled = YES;
    [self schedule:@selector(gameLogic:) interval:1.0];
    
    
    return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    //Dealloc stuff below this line
	[super dealloc];
}

- (void) initializeResources
{
    ResourceManager * rm = [ResourceManager shared];
    Config * conf = [Config shared];
    [rm setArrows:[conf getIntProperty:@"InitialArrows"]];
    [rm setGold: [conf getIntProperty:@"InitialGold"]];
    [rm setSkillPoints: [conf getIntProperty:@"InitialSkillPoints"]];
    [rm setMana: [[conf getNumberProperty:@"InitialMana"] doubleValue]];
}

- (void)update:(ccTime)dt
{
    if(fire && [[ResourceManager shared] arrows] > 0 && [(Yuri*)[self getChildByTag:9]fireIfAble: location] )
        [self addProjectile:location];
    
    [[CollisionManager shared] updatePixelPerfectCollisions:dt];
    [[CollisionManager shared] updateWallsAndEnemies:dt];
    [hud updateWallHealth];
    [hud updateData];
}


- (void) addProjectile:(CGPoint) alocation
{
    
    CCArray * stimulusPackage = [[CCArray alloc] init];
    [stimulusPackage removeAllObjects];
    NSMutableArray * buttons = [hud buttonsPressed];
    
    
    [stimulusPackage addObject:[[StimulusFactory shared] generateDamageStimulusWithValue:2]];
    if ([[buttons objectAtIndex:power1button] boolValue])
        [stimulusPackage addObject:[[StimulusFactory shared] generateColdStimulusWithValue:2]];
    if ([[buttons objectAtIndex:power2button] boolValue])
        [stimulusPackage addObject:[[StimulusFactory shared] generateFireStimulusWithValue:2]];
    if ([[buttons objectAtIndex:power3button] boolValue])
        [stimulusPackage addObject:[[StimulusFactory shared] generatePushBackStimulusWithValue:2]];
    
    Arrow * arrow = [[Arrow alloc] initWithDestination:alocation andStimulusPackage:stimulusPackage];
    
    [stimulusPackage release];
    
    if(arrow != nil)
    {
        [[ResourceManager shared] increaseArrowsUsedCount];
        [[SimpleAudioEngine sharedEngine] playEffect:@"Swoosh.caf"];
        [self addChild:arrow z:1201];
        
        arrow.tag = 2;
        [[CollisionManager shared] addToProjectiles:arrow];
        [hud updateArrows];
    }
    [arrow release];
    arrow=nil;

}


-(void)addPeasant
{
    
    Peasant * peasant  = [[EnemyFactory shared] generatePeasant];
    
    NSInteger zOrder = [[CCDirector sharedDirector] winSize].height - [peasant sprite].position.y;
    
    [self addChild:peasant z:zOrder];
    
    peasant.tag = 1;
    [[CollisionManager shared] addToTargets:peasant];
    [[ResourceManager shared] increaseEnemyCount];
}

-(void)addFaerieDragon
{
    FaerieDragon * faerieDragon = [[EnemyFactory shared] generateFaerieDragon];
    
    NSInteger zOrder = [[CCDirector sharedDirector] winSize].height - [faerieDragon sprite].position.y;
    
    [self addChild:faerieDragon z:zOrder];
    
    faerieDragon.tag = 3;
    [[CollisionManager shared] addToTargets:faerieDragon];
    [[ResourceManager shared] increaseEnemyCount];
    
}

-(void)addZealot
{
    Zealot * zealot = [[EnemyFactory shared] generateZealot];
    
    NSInteger zOrder = [[CCDirector sharedDirector] winSize].height - [zealot sprite].position.y;
    
    [self addChild:zealot z:zOrder];
    
    zealot.tag = 4;
    [[CollisionManager shared] addToTargets:zealot];
    [[ResourceManager shared] increaseEnemyCount];
}


- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    [super ccTouchesBegan:touches withEvent:event];
   
    fire = YES;
    // Choose one of the touches to work with
    UITouch *touch = [touches anyObject];
    location = [self convertTouchToNodeSpace:touch];
    location = [touch  locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

    [super ccTouchesMoved:touches withEvent:event];

    fire = NO;
}

-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super ccTouchesMoved:touches withEvent:event];
    // Update touch position
    
    // Choose one of the touches to work with
    UITouch *touch = [touches anyObject];
    location = [self convertTouchToNodeSpace:touch];
    location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
}


@end
