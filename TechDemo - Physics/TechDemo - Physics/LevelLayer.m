    //
//  Level.m
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

// Import the interfaces
#import "LevelLayer.h"

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
    
    if((int)floor(timeElapsedSinceBeginning) % 5 == 1)
        [self addPeasant];
    if((int)floor(timeElapsedSinceBeginning) % 15 == 1)
        [self addFaerieDragon];
    if((int)floor(timeElapsedSinceBeginning) % 10 == 1)
        [self addZealot];
    
}

// on "init" you need to initialize your instance
-(id) init
{
    if( (self=[super init]))
    {
        [[Registry shared] registerEntity:self withName:@"LevelLayer"];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:[[Config shared] getStringProperty:@"IngameMusic"] loop:YES];
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        timeElapsedSinceBeginning = 1.0f;
        fire = NO;
        
        // inicializar recursos
        [self initializeResources];
        
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
        
        // inicializar nível
        [[WaveManager shared] initializeLevelLogic:@"Level1"];                  // Hardcoded
        [[WaveManager shared] beginWaves];
        
        // This dummy method initializes the collision manager
        [[CollisionManager shared] dummyMethod];
        
        [self schedule:@selector(update:)];
        
//        [[CCDirector sharedDirector] purgeCachedData];
    }
    
    self.isTouchEnabled = YES;
    [self schedule:@selector(gameLogic:) interval:1.0];
    
    
    return self;
}


- (void) initializeResources
{
    ResourceManager * rm = [ResourceManager shared];
    Config * conf = [Config shared];
    [rm setArrows:[conf getIntProperty:@"InitialArrows"]];
    [rm setGold: [conf getIntProperty:@"InitialGold"]];
    [rm setSkillPoints: [conf getIntProperty:@"InitialSkillPoints"]];
    [rm setMana: [[conf getNumberProperty:@"InitialMana"] doubleValue]];
    
#warning isto faz alguma coisa?
    [rm reset];
}

- (void)update:(ccTime)dt
{
    if(fire && [[ResourceManager shared] arrows] > 0 && [(Yuri*)[self getChildByTag:9]fireIfAble: location] )
        [self addProjectile:location];
    
    [[CollisionManager shared] updatePixelPerfectCollisions:dt];
    [[CollisionManager shared] updateWallsAndEnemies:dt];
    [hud updateWallHealth];
    [hud updateData];
    
    if (((Wall *)[[Registry shared]getEntityByName:@"Wall"]).health<=0 && (_gameOver==nil))
        [self gameOver];    
}


- (void) addProjectile:(CGPoint) alocation
{
    
    CCArray * stimulusPackage = [[CCArray alloc] init];
    [stimulusPackage removeAllObjects];
    NSMutableArray * buttons = [hud buttonsPressed];
    
#warning depois de fazer o gamestate, podemos testá-lo para linkar com os valores dos estimulos
#warning calculate stimulus value method or something
    [stimulusPackage addObject:[[StimulusFactory shared] generateDamageStimulusWithValue:50]];
    if ([[buttons objectAtIndex:kPower1Button] boolValue])
        [stimulusPackage addObject:[[StimulusFactory shared] generateColdStimulusWithValue:50]];
    if ([[buttons objectAtIndex:kPower2Button] boolValue])
        [stimulusPackage addObject:[[StimulusFactory shared] generateFireStimulusWithValue:50]];
    if ([[buttons objectAtIndex:kPower3Button] boolValue])
        [stimulusPackage addObject:[[StimulusFactory shared] generatePushBackStimulusWithValue:50]];
    
    Arrow * arrow = [[Arrow alloc] initWithDestination:alocation andStimulusPackage:stimulusPackage];
    
    [stimulusPackage release];
    
    if(arrow != nil)
    {
        [[ResourceManager shared] increaseArrowsUsedCount];
        [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"ShootArrowSound"]];
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

-(void)onExit
{
    [[Registry shared] clearRegistry];
}

-(void)dealloc{
    [self unscheduleAllSelectors];
    [[CollisionManager shared] clearAllEntities];
    [super dealloc];
    //CCLOG(@"DEALOQUEI");
}


@end
