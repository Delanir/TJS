    //
//  Level.m
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

// Import the interfaces
#import "LevelLayer.h"
#import "GameState.h"

#pragma mark - Level

// HelloWorldLayer implementation
@implementation LevelLayer
@synthesize hud, level;

static int current_level = -1;

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

+(void)setCurrentLevel:(int) newLevel
{
    current_level = newLevel;
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
        
        //////
        
        [[Registry shared] registerEntity:self withName:@"LevelLayer"];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:[[Config shared] getStringProperty:@"IngameMusic"] loop:YES];
        
        [[SpriteManager shared] addSpritesToSpriteFrameCacheWithFile:@"lvl1spritesheet.plist" andBatchSpriteSheet:@"lvl1spritesheet.png"];
        [[SpriteManager shared] addAnimationFromFile:@"peasant_anim.plist"];
        [[SpriteManager shared] addAnimationFromFile:@"fairiedragon_anim.plist"];
        [[SpriteManager shared] addAnimationFromFile:@"zealot_anim.plist"];
        [[SpriteManager shared] addAnimationFromFile:@"yurie_anim.plist"];
        
       
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
        [self setLevel:current_level];
        [[WaveManager shared] initializeLevelLogic:[NSString stringWithFormat:@"Level%d",level]];
        [[WaveManager shared] beginWaves];
        
        // This dummy method initializes the collision manager
        [[CollisionManager shared] dummyMethod];
        
        [self schedule:@selector(update:)];
    }
    
    self.isTouchEnabled = YES;
//    [self schedule:@selector(gameLogic:) interval:1.0];
    
    
    return self;
}


- (void) initializeResources
{
    ResourceManager * rm = [ResourceManager shared];
    Config * conf = [Config shared];
    [rm setArrows:[conf getIntProperty:@"InitialArrows"]];
    [rm setMana: [[conf getNumberProperty:@"InitialMana"] doubleValue]];
    [rm setMaxMana: [[conf getNumberProperty:@"InitialMana"] doubleValue]];
    [rm reset];
}

- (void)update:(ccTime)dt
{
    // Do I have to shoot?
    if(fire &&
       [[ResourceManager shared] arrows] > 0 &&
       location.y > 128 &&
       [(Yuri*)[self getChildByTag:9]fireIfAble: location] )
        [self addProjectile:location];
    
    [self regenerateMana];
    
    [[CollisionManager shared] updatePixelPerfectCollisions:dt];
    [[CollisionManager shared] updateWallsAndEnemies:dt];
    [hud updateWallHealth];
    [hud updateMoney];
    [hud updateMana];
    
    if ([self tryLose])
        [self gameOver];
    else if ([self tryWin])
        [self gameWin];
}

- (void) regenerateMana
{
    [[ResourceManager shared] addMana:kManaRegenerationRate];
}


- (void) addProjectile:(CGPoint) alocation
{
    
    CCArray * stimulusPackage = [[CCArray alloc] init];
    [stimulusPackage removeAllObjects];
    NSMutableArray * buttons = [hud buttonsPressed];
    
#warning depois de fazer o gamestate, podemos testá-lo para linkar com os valores dos estimulos
#warning calculate stimulus value method or something
    // Damage Stimulus
    [stimulusPackage addObject:[[StimulusFactory shared] generateDamageStimulusWithValue:50]];
    // Cold Stimulus
    if ([[buttons objectAtIndex:kPower1Button] boolValue] && [[ResourceManager shared] spendMana:3.5])
        [stimulusPackage addObject:[[StimulusFactory shared] generateColdStimulusWithValue:50]];
    // Fire Stimulus
    if ([[buttons objectAtIndex:kPower2Button] boolValue] && [[ResourceManager shared] spendMana:3.5])
        [stimulusPackage addObject:[[StimulusFactory shared] generateFireStimulusWithValue:50]];
    // PushBack Stimulus
    if ([[buttons objectAtIndex:kPower3Button] boolValue] && [[ResourceManager shared] spendMana:2.0])
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
    UITouch *touch = [touches anyObject];
    [self pauseCheck:touch];
    [self gameOverReturnToMainMenuCheck:touch];
    [self gameWinReturnToMainMenuCheck:touch];
    if ([[CCDirector sharedDirector] isPaused])
        return;
    
    fire = YES;
    // Choose one of the touches to work with
    
    location = [self convertTouchToNodeSpace:touch];
    location = [touch  locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    fire = NO;
}

-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([[CCDirector sharedDirector] isPaused])
        return;
    // Update touch position
    
    // Choose one of the touches to work with
    UITouch *touch = [touches anyObject];
    location = [self convertTouchToNodeSpace:touch];
    location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
}

-(BOOL) tryWin
{
    return ![[WaveManager shared] anymoreWaves] && [[ResourceManager shared] activeEnemies] == 0;
}

-(BOOL) tryLose
{
    return [(Wall *)[[Registry shared]getEntityByName:@"Wall"] health] <=0 && _gameOver == nil;
}

-(void) calculateAndUpdateNumberOfStars
{
    // Pontuacao:
    // 1/4 accuracy
    // 3/4 wall health
    Wall* wall = [[Registry shared] getEntityByName:@"Wall"];
    
    float cont1 = 0.75 * [wall health] / [wall maxHealth];
    float cont2 = 0.25 * [[ResourceManager shared] determineAccuracy] * 0.01;
    
    unsigned int numberStars = (unsigned int) ceil((cont1+cont2)*3);
    
    NSMutableArray * stars = [[GameState shared] starStates];
    
    NSNumber * currentStars = [stars objectAtIndex:current_level-1];
    
    if (numberStars > [currentStars intValue])
        [stars replaceObjectAtIndex:current_level-1 withObject: [NSNumber numberWithInt:numberStars]];
    
}

-(void)makeMoneyPersistent
{
    [[GameState shared] setGoldState: [NSNumber numberWithUnsignedInt:[[ResourceManager shared] gold]]];
}

-(void)onExit
{
    [[GameState shared] saveApplicationData];
    [[Registry shared] clearRegistry];
    [[CollisionManager shared] clearAllEntities];
    [self removeAllChildrenWithCleanup:YES];
}

-(void)dealloc
{
    [super dealloc];
    CCLOG(@"DEALOQUEI");
}

///








-(void) pauseCheck:(UITouch *)touchLocation
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CGPoint locationT=[touchLocation locationInView:[touchLocation view]];
    locationT.y=winSize.height-locationT.y;
    CGPoint pausePosition = _pauseButton.position;
    float pauseRadius = _pauseButton.contentSize.width/2;
    
    CGPoint pausePosition2 = [[_pause getPauseButton] position];
    float pauseRadius2 = [[_pause getPauseButton] contentSize].width/2;
    
    if (ccpDistance(pausePosition, locationT)<=pauseRadius ||
        (_pause.visible&&ccpDistance(pausePosition2, location)<=pauseRadius2)){
        [self togglePause];
    }
}

-(void) gameOverReturnToMainMenuCheck:(UITouch *)touchLocation
{
    if (_gameOver!=nil)
    {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CGPoint locationT=[touchLocation locationInView:[touchLocation view]];
        locationT.y=winSize.height-locationT.y;
        CGPoint btnPosition = _gameOver.mainMenuButtonPosition;
        float btnRadius = _gameOver.mainMenuButtonRadius/2;
        
        if ( ccpDistance(btnPosition, locationT)<=btnRadius)
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
    if (_gameWin!=nil)
    {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CGPoint locationT=[touchLocation locationInView:[touchLocation view]];
        locationT.y=winSize.height-locationT.y;
        CGPoint btnPosition = _gameWin.mainMenuButtonPosition;
        float btnRadius = _gameWin.mainMenuButtonRadius/2;
        
        if ( ccpDistance(btnPosition, locationT)<=btnRadius)
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
        
    }
    else if(_gameOver==nil&&(![[CCDirector sharedDirector] isPaused]))
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
    [self makeMoneyPersistent];
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
