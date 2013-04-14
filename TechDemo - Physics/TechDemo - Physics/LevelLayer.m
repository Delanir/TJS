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

-(void) onEnter
{
    //Startup sound
    [super onEnter];
    //[[SimpleAudioEngine sharedEngine] setEffectsVolume:0.5f];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Battle1.mp3" loop:YES];
}


// on "init" you need to initialize your instance
-(id) init
{
    if( (self=[super init]))
    {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        timeElapsedSinceBeginning = 0.0f;
        _arrows = 50;
        
        // Criação da cena com castelo
        MainScene *mainScene = [[MainScene alloc] initWithWinSize:winSize parent:self];
        [self addChild:mainScene z:0];
        [mainScene release];
        
        // Meter yuri na cena
        Yuri * yuri = [[Yuri alloc] init];
        yuri.position = ccp([yuri spriteSize].width/2 + 120, winSize.height/2 + 30);     // @Hardcoded - to correct
        [yuri setTag:9];
        [self addChild:yuri z:1000];
        [yuri release];
        
        // This dummy method initializes the collision manager
        [[CollisionManager shared] dummyMethod];
      
        
        // Estes labels deviam estar noutro sitio
      label = [CCLabelTTF labelWithString:@"Number of Arrows Left: 50" fontName:@"Futura" fontSize:20];
      label2 = [CCLabelTTF labelWithString:@"Wall health: 100" fontName:@"Futura" fontSize:20];
      label3 = [CCLabelTTF labelWithString:@"Money: 0" fontName:@"Futura" fontSize:20];
      label.position = CGPointMake(label.contentSize.width/2 + 70, 80);
      label2.position = CGPointMake(label2.contentSize.width/2 + 70,50);
      label3.position = CGPointMake(label3.contentSize.width/2 + 70, 20);
      
      //Power Buttons
      CCMenuItem *plusMenuItem = [CCMenuItemImage
                                 itemWithNormalImage:@"plus.png" selectedImage:@"cross.png"
                                 target:self selector:@selector(plusButtonTapped:)];
      plusMenuItem.position = ccp(810, 60);
      
      CCMenuItem *crossMenuItem = [CCMenuItemImage
                                   itemWithNormalImage:@"cross.png" selectedImage:@"plus.png"
                                   target:self selector:@selector(crossButtonTapped:)];
      crossMenuItem.position = ccp(880, 60);
      
        CCMenuItem *bullseyeMenuItem = [CCMenuItemImage
                                        itemWithNormalImage:@"bullseye.png" selectedImage:@"plus.png"
                                        target:self selector:@selector(bullseyeButtonTapped:)];
        bullseyeMenuItem.position = ccp(950, 60);
      
      
        CCMenu *superMenu = [CCMenu menuWithItems:plusMenuItem, crossMenuItem, bullseyeMenuItem, nil];
        superMenu.position = CGPointZero;
      
        [self addChild:superMenu];
        [self addChild:label z:1];
        [self addChild:label2 z:1];
        [self addChild:label3 z:1];
      
        [self schedule:@selector(update:)];
    }
    
    self.isTouchEnabled = YES;
    [self schedule:@selector(gameLogic:) interval:1.0];
    
    return self;
}

- (void)plusButtonTapped:(id)sender {
  buttons=1;
  
}

- (void)crossButtonTapped:(id)sender {
  buttons=2;
}

- (void)bullseyeButtonTapped:(id)sender {
  buttons=3;
}



// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    //Dealloc stuff below this line
	[super dealloc];
}

- (void)update:(ccTime)dt
{
    Yuri * yuri = (Yuri*)[self getChildByTag:9];
    if([yuri fire])
    {
        [yuri setFire:NO];
        [yuri animateInDirection:location];
    }
    if([yuri readyToFire])
    {
        [yuri setReadyToFire:NO];
        [self addProjectile:location];
    }
    [[CollisionManager shared] updatePixelPerfectCollisions:dt];
    [[CollisionManager shared] updateWallsAndEnemies:dt];
}


- (void) addProjectile:(CGPoint) alocation
{
    
    CCArray * stimulusPackage = [[CCArray alloc] init];
    [stimulusPackage removeAllObjects];
  if (buttons==1) {
    [stimulusPackage addObject:[[StimulusFactory shared] generateColdStimulusWithValue:2]];
  }else if (buttons==2){
    [stimulusPackage addObject:[[StimulusFactory shared] generateFireStimulusWithValue:2]];
  }else if (buttons==3){
    [stimulusPackage addObject:[[StimulusFactory shared] generatePushBackStimulusWithValue:2]];
  }else {
    [stimulusPackage addObject:[[StimulusFactory shared] generateDamageStimulusWithValue:2]];
  }
    
    Arrow * arrow = [[Arrow alloc] initWithDestination:alocation andStimulusPackage:stimulusPackage];
    
    [stimulusPackage release];
    
    if(arrow != nil)
    {
        [[SimpleAudioEngine sharedEngine] playEffect:@"Swoosh.caf"];
        [self addChild:arrow z:1201];
        
        arrow.tag = 2;
        [[CollisionManager shared] addToProjectiles:arrow];
      
        _arrows--;
    }
    [label setString:[NSString stringWithFormat:@"Number of Arrows Left: %i", _arrows]];
    [arrow release];
    arrow=nil;
    
#warning Forma de alterar o firerate do Yuri
    //float currentDelay = [[[CCAnimationCache sharedAnimationCache] animationByName:@"y_attack_front"] delayPerUnit];
    //[(Yuri*)[self getChildByTag:9] changeFireRate:currentDelay+0.1];
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


- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [(Yuri*)[self getChildByTag:9] setFire: YES];
    
    // Choose one of the touches to work with
    UITouch *touch = [touches anyObject];
    location = [self convertTouchToNodeSpace:touch];
    location = [touch  locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [(Yuri*)[self getChildByTag:9] resetSprite];
    [(Yuri*)[self getChildByTag:9] setFire: NO];
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
