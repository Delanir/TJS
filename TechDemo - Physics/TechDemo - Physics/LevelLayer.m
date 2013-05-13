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
@synthesize hud, level, manaRegenerationBonus, healthRegenerationRate, gameStarted;

static int current_level = -1;

/**
 *
 * Class methods
 *
 */

// Helper class method that creates a Scene
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
	// 'layer' is an autorelease object.
	LevelLayer *level = [LevelLayer node];
	
	// add layer as a child to scene
	[scene addChild: level z:0];
    
    
	// return the scene
	return scene;
}

+(void)setCurrentLevel:(int) newLevel
{
    current_level = newLevel;
}

/******
 *****
 ***** Instance methods
 *****
 *****/

/**
 *
 * Initialization logic
 *
 */


// on "init" you need to initialize your instance
-(id) init
{
    if(self = [super init])
    {
        [self setIsTouchEnabled: YES];
    }
    
    //    [self schedule:@selector(gameLogic:) interval:1.0];
    
    return self;
}

// Initialization done on onEnter. It happens after onExitDidTransitionStart
- (void) onEnter
{
    [super onEnter];
    [ResourceManager loadLevelSprites];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    Hud *levelHud = [Hud node];
    [self setHud:levelHud];
    [self addChild:levelHud z:2000];
    
    _pauseButton= [CCSprite spriteWithSpriteFrameName:@"pause.png"];
    [_pauseButton setPosition:CGPointMake(_pauseButton.contentSize.width/2.0, winSize.height - _pauseButton.contentSize.height/2.0)];
    
    [_pauseButton setZOrder:2000];
    
    [self addChild:_pauseButton];
    [[WaveManager shared] removeFromParentAndCleanup:NO];
    [self addChild:[WaveManager shared]]; // Esta linha é imensos de feia. Mas tem de ser para haver update
    
    _pause= (PauseHUD *)[CCBReader nodeGraphFromFile:@"PauseMenu.ccbi"];
    [self addChild:_pause];
    
    [_pause setZOrder:1535];
    [_pause setVisible:NO];
    
    [[Registry shared] registerEntity:self withName:@"LevelLayer"];
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic:[[Config shared] getStringProperty:@"IngameMusic"] loop:YES];
    
    timeElapsedSinceBeginning = 1.0f;
    manaRegenerationBonus = 1.0f;
    healthRegenerationRate = 0.0f;
    fire = NO;
    gameStarted = NO;
    
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
    
    // This dummy method initializes the collision manager
    [[CollisionManager shared] dummyMethod];
    
    // Prepare the changes due to the Skill Tree
    [self prepSkillTreeChanges];
    
    // inicializar recursos
    [self initializeResources];
    
    [self schedule:@selector(updatePreGame:)];
#warning temp
    [[WaveManager shared] sendWave:@"WraithTaunt" taunt:YES];

}


- (void) initializeResources
{
    Yuri * yuri = [[Registry shared] getEntityByName:@"Yuri"];
    ResourceManager * rm = [ResourceManager shared];
    Config * conf = [Config shared];
    [rm setArrows:([conf getIntProperty:@"InitialArrows"]/2) * ([yuri level]+1)];
    [rm setMana: ([[conf getNumberProperty:@"InitialMana"] doubleValue]/2) * ([yuri level]+1)];
    [rm setMaxMana: ([[conf getNumberProperty:@"InitialMana"] doubleValue]/2) * ([yuri level]+1)];
    [rm reset];
    [hud updateHUD];
}

- (void) prepSkillTreeChanges
{
    NSMutableArray *skill = [[GameState shared] skillStates];
    Hud * headsUpDisplay = [[Registry shared] getEntityByName:@"Hud"];
    Yuri * yuri = [[Registry shared] getEntityByName:@"Yuri"];
    /**
     *
     * MAIN BRANCHES
     *
     */
    
    if ([[skill objectAtIndex:kIceMainBranch] intValue] != 0)
    {
        [headsUpDisplay setIceToggleButtonActive];
    }
    if ([[skill objectAtIndex:kFireMainBranch] intValue] != 0)
    {
        [headsUpDisplay setFireToggleButtonActive];
    }
    if ([[skill objectAtIndex:kMarksmanMainBranch] intValue] != 0)
    {
        [headsUpDisplay setPushbackToggleButtonActive];
    }
    if ([[skill objectAtIndex:kCityMainBranch] intValue] != 0)
    {
        Wall * wall = [[Registry shared] getEntityByName:@"Wall"];
        [wall increaseHealth:1.5];
    }
    
    /**
     *
     * GELO
     *
     */
    if ([[skill objectAtIndex:kIceBranch1] intValue] != 0)
    {
        [yuri setSlowPercentageBonus:kYuriSlowDownDurationBaseBonus];
    }
    if ([[skill objectAtIndex:kIceBranch2] intValue] != 0)
    {
        [yuri setFreezePercentage:kYuriBaseFreezePercentage];
    }
    if ([[skill objectAtIndex:kIceBranch3] intValue] != 0)
    {
        [yuri setIceAreaOfEffect:kYuriBaseAreaOfEffect];
    }
    if ([[skill objectAtIndex:kIceElement1] intValue] != 0)
    {
        [yuri setSlowPercentageBonus:kYuriSlowDownDurationExtraBonus];
    }
    if ([[skill objectAtIndex:kIceElement2] intValue] != 0)
    {
        [yuri setFreezePercentage:kYuriExtraFreezePercentage];
    }
    if ([[skill objectAtIndex:kIceElement3] intValue] != 0)
    {
        [yuri setIceAreaOfEffect:kYuriExtraAreaOfEffect];
    }
    
    /**
     *
     * FOGO
     *
     */
    if ([[skill objectAtIndex:kFireBranch1] intValue] != 0)
    {
        [yuri setFireDamageBonus:kYuriDamageOverTimeDamageBaseBonus];
    }
    if ([[skill objectAtIndex:kFireBranch2] intValue] != 0)
    {
        [yuri setFireDurationBonus:kYuriDamageOverTimeDurationBaseBonus];
    }
    if ([[skill objectAtIndex:kFireBranch3] intValue] != 0)
    {
        [yuri setFireAreaOfEffect:kYuriBaseAreaOfEffect];
    }
    if ([[skill objectAtIndex:kFireElement1] intValue] != 0)
    {
        [yuri setFireDamageBonus:kYuriDamageOverTimeDamageExtraBonus];
    }
    if ([[skill objectAtIndex:kFireElement2] intValue] != 0)
    {
        [yuri setFireDurationBonus:kYuriDamageOverTimeDurationExtraBonus];
    }
    if ([[skill objectAtIndex:kFireElement3] intValue] != 0)
    {
        [yuri setFireAreaOfEffect:kYuriExtraAreaOfEffect];
    }
    
    /**
     *
     * MARKSMAN
     *
     */
    if ([[skill objectAtIndex:kMarksmanBranch1] intValue] != 0)
    {
        [yuri setStrengthBonus:kYuriBaseStrengthBonus];
    }
    if ([[skill objectAtIndex:kMarksmanBranch2] intValue] != 0)
    {
        [yuri setSpeedBonus:kYuriBaseSpeedBonus];
    }
    if ([[skill objectAtIndex:kMarksmanBranch3] intValue] != 0)
    {
        [yuri setCriticalBonus:kYuriBaseCriticalBonus];
    }
    if ([[skill objectAtIndex:kMarksmanElement1] intValue] != 0)
    {
        [yuri setStrengthBonus:kYuriExtraStrengthBonus];
    }
    if ([[skill objectAtIndex:kMarksmanElement2] intValue] != 0)
    {
        [yuri setSpeedBonus:kYuriExtraSpeedBonus];
    }
    if ([[skill objectAtIndex:kMarksmanElement3] intValue] != 0)
    {
        [yuri setCriticalBonus:kYuriExtraCriticalBonus];
    }
    
    /**
     *
     * CITYYYY
     *
     */
    if ([[skill objectAtIndex:kCityBranch1] intValue] != 0)
    {
        [self setManaRegenerationBonus:kManaBaseRegenerationBonus];
        Wall * wall = [[Registry shared] getEntityByName:@"Wall"];
        [wall addMagesTower];
    }
    if ([[skill objectAtIndex:kCityBranch2] intValue] != 0)
    {
        [self setHealthRegenerationRate:kHealthBaseRegenerationBonus];
        Wall * wall = [[Registry shared] getEntityByName:@"Wall"];
        [wall addMasonry];
    }
    if ([[skill objectAtIndex:kCityBranch3] intValue] != 0)
    {
        Wall * wall = [[Registry shared] getEntityByName:@"Wall"];
        [wall setMoatLevel:kMoatOneTimeDamage];
        [wall addMoat];
    }
    if ([[skill objectAtIndex:kCityElement1] intValue] != 0)
    {
        [self setManaRegenerationBonus:kManaExtraRegenerationBonus];
    }
    if ([[skill objectAtIndex:kCityElement2] intValue] != 0)
    {
        [self setHealthRegenerationRate:kHealthExtraRegenerationBonus];
    }
    if ([[skill objectAtIndex:kCityElement3] intValue] != 0)
    {
        Wall * wall = [[Registry shared] getEntityByName:@"Wall"];
        [wall setMoatLevel:kMoatOneTimeDamageInstaKillChance];
    }
    
    [yuri initBasicStats];
}


/**
 *
 * Update logic
 *
 */


- (void)updatePreGame:(ccTime)dt
{
    if (gameStarted)
    {
        [[WaveManager shared] beginWaves];
        [self unscheduleAllSelectors];
        [self schedule:@selector(update:)];
    } 
}

- (void)update:(ccTime)dt
{
    if([self haveToShoot])
        [self addProjectile:location];
    
    [self regenerateHealthAndMana];
    
    [[CollisionManager shared] updateCollisions:dt];
    [hud updateWallHealth];
    [hud updateMoney];
    [hud updateMana];
    [hud updateButtons];
    
    if ([self tryLose])
        [self gameOver];
    else if ([self tryWin])
        [self gameWin];
}



- (void) regenerateHealthAndMana
{
    [[ResourceManager shared] addMana:kManaRegenerationRate * manaRegenerationBonus];
    Wall * wall = [[Registry shared] getEntityByName:@"Wall"];
    [wall regenerateHealth:healthRegenerationRate];
}


- (void) addProjectile:(CGPoint) alocation
{
    CCArray * stimulusPackage = [[CCArray alloc] init];
    [stimulusPackage removeAllObjects];
    NSMutableArray * buttons = [hud buttonsPressed];
    Yuri * yuri = [[Registry shared] getEntityByName:@"Yuri"];
    
    unsigned int damage = [yuri strength] * [yuri isCritical];
    
    // Damage Stimulus
    [stimulusPackage addObject:[[StimulusFactory shared] generateDamageStimulusWithValue:damage]];
    // Cold Stimulus
    if ([[buttons objectAtIndex:kPower1Button] boolValue] && [[ResourceManager shared] spendMana:3.5])
        [stimulusPackage addObject:[[StimulusFactory shared] generateColdStimulusWithValue:[yuri slowPercentage]
                                                                               andDuration:[yuri slowTime]]];
    // Fire Stimulus
    if ([[buttons objectAtIndex:kPower2Button] boolValue] && [[ResourceManager shared] spendMana:3.5])
        [stimulusPackage addObject:[[StimulusFactory shared] generateFireStimulusWithValue: [yuri fireDamage]
                                                                               andDuration:[yuri fireDuration]]];
    // PushBack Stimulus
    if ([[buttons objectAtIndex:kPower3Button] boolValue] && [[ResourceManager shared] spendMana:2.0])
        [stimulusPackage addObject:[[StimulusFactory shared] generatePushBackStimulusWithValue:kYuriBasePushbackDistance]];
    
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


- (BOOL) haveToShoot
{
    return fire &&
    [[ResourceManager shared] arrows] > 0 &&
    location.x > 140 &&
    location.y > 128 &&
    [(Yuri*)[self getChildByTag:9]fireIfAble: location];
}

-(BOOL) tryWin
{
    return ![[WaveManager shared] anymoreWaves] && [[ResourceManager shared] activeEnemies] == 0;
}

-(BOOL) tryLose
{
    return [(Wall *)[[Registry shared]getEntityByName:@"Wall"] health] <=0 && _gameOver == nil;
}

-(void) addEnemy:(Enemy *) newEnemy
{
    NSInteger zOrder = [[CCDirector sharedDirector] winSize].height - [newEnemy sprite].position.y;
    
    [self addChild:newEnemy z:zOrder];
    
    [[CollisionManager shared] addToTargets:newEnemy];
    [[ResourceManager shared] increaseEnemyCount];
}

/**
 *
 * Unused methods (ghost code)
 *
 */


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


/**
 *
 * Touch Management
 *
 */

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



/**
 *
 * Tests and evaluations
 *
 */


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

-(void)makeEnemiesKilledPersistent
{
    int enemies = [[[GameState shared] enemiesKilledState] intValue] + [[ResourceManager shared] enemyKillCount];
    [[GameState shared] setEnemiesKilledState:[NSNumber numberWithUnsignedInt:enemies]];
}

// Happens before next onEnter
-(void)onExitTransitionDidStart
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFrames];
    [[CCTextureCache sharedTextureCache] removeAllTextures];
    [[GameState shared] saveApplicationData];
    [[Registry shared] clearRegistry];
    [[CollisionManager shared] clearAllEntities];
    [self removeAllChildrenWithCleanup:YES];
}

-(void)dealloc
{
    [super dealloc];
}

-(void) pauseCheck:(UITouch *)touchLocation
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CGPoint locationT=[touchLocation locationInView:[touchLocation view]];
    locationT.y=winSize.height-locationT.y;
    CGPoint pausePosition = _pauseButton.position;
    float pauseRadius = _pauseButton.contentSize.width/2;
    
    
    if (ccpDistance(pausePosition, locationT)<=pauseRadius ||
        (_pause.visible&&
         [self checkRectangularButtonPressed:[_pause getPauseButton] givenTouchPoint:locationT])){
            [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
            [self togglePause];
            
        }else if (_pause.visible&&
                  [self checkRectangularButtonPressed:[_pause getMenuButton] givenTouchPoint:locationT]){
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
            [self setIsTouchEnabled:NO];
            [[CCDirector sharedDirector] resume];
            [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
            [[GameManager shared] runSceneWithID:kMainMenuScene];
        }
}

- (BOOL) checkRectangularButtonPressed:(CCSprite *)button givenTouchPoint:(CGPoint) locationT{
    
    CGPoint position= [button position];
    CGSize size = [button contentSize];
    
    
    return (fabs(locationT.x-position.x)<=size.width/2.0 &&
            fabs(locationT.y-position.y)<=size.height/2.0);
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
            
            [[GameManager shared] runSceneWithID:kSelectLevel];
            
        }
    }else
        return;
    
}

-(void) gameWinReturnToMainMenuCheck:(UITouch *)touchLocation
{
    if (_gameWin!=nil)
    {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CGPoint locationT = [touchLocation locationInView:[touchLocation view]];
        locationT.y = winSize.height-locationT.y;
        CGPoint btnPosition = _gameWin.mainMenuButtonPosition;
        float btnRadius = _gameWin.mainMenuButtonRadius/2;
        
        if ( ccpDistance(btnPosition, locationT)<=btnRadius)
        {
            [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
            [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
            [self setIsTouchEnabled:NO];
            [[CCDirector sharedDirector] resume];
            
            [[GameManager shared] runSceneWithID:kSelectLevel];
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

-(void) gameOver
{
    _gameOver= (GameOver *)[CCBReader nodeGraphFromFile:@"GameOver.ccbi"];
    [self addChild:_gameOver];
    [_gameOver setZOrder:1535];
    [[CCDirector sharedDirector] pause];
    [self makeEnemiesKilledPersistent];
    
    [self checkAchievements];
}

-(void) gameWin
{
    _gameWin = (GameWin *)[CCBReader nodeGraphFromFile:@"GameWin.ccbi"];
    [self addChild:_gameWin];
    [_gameWin setZOrder:1535];
    [[CCDirector sharedDirector] pause];
    
    [self calculateAndUpdateNumberOfStars];
    [self makeMoneyPersistent];
    [self makeEnemiesKilledPersistent];
    
    [self checkAchievements];
}

#pragma Update Achievements

-(void) checkAchievements
{
    [self checkAchievement1];
    [self checkAchievement2];
    [self checkAchievement3];
    [self checkAchievement4];
    [self checkAchievement5];
    [self checkAchievement6];
    [self checkAchievement7];
    [self checkAchievement8];
    [self checkAchievement9];
    [self checkAchievement10];
    [self checkAchievement11];
    [self checkAchievement12];
    [self checkAchievement13];
    [self checkAchievement14];
    [self checkAchievement15];
}

-(void) checkAchievement1
{
    NSMutableArray * achievement = [[GameState shared] achievementStates];
    if ([[achievement objectAtIndex:0] intValue] == 0 && [[[GameState shared] enemiesKilledState] intValue] >= 25) { // 50
        [achievement replaceObjectAtIndex:0 withObject:[NSNumber numberWithInt:1]];
    }
}

-(void) checkAchievement2
{
    NSMutableArray * achievement = [[GameState shared] achievementStates];
    if ([[achievement objectAtIndex:1] intValue] == 0 && [[[GameState shared] dragonsKilledState] intValue] >= 1) { // 10
        [achievement replaceObjectAtIndex:1 withObject:[NSNumber numberWithInt:1]];
    }
}

-(void) checkAchievement3
{
    NSMutableArray * achievement = [[GameState shared] achievementStates];
    //NSLog(@"Buy Arrows %d",[[[GameState shared] buyArrowsState] intValue]);
    if ([[achievement objectAtIndex:2] intValue] == 0 && [[[GameState shared] buyArrowsState] intValue] >= 2500) {
        [achievement replaceObjectAtIndex:2 withObject:[NSNumber numberWithInt:1]];
    }
}

-(void) checkAchievement4
{
    NSMutableArray * achievement = [[GameState shared] achievementStates];
    if ([[achievement objectAtIndex:3] intValue] == 0 && [[ResourceManager shared] determineAccuracy] == 100.0f) { // done ;)
        [achievement replaceObjectAtIndex:3 withObject:[NSNumber numberWithInt:1]];
    }
}

-(void) checkAchievement5
{
    NSMutableArray * achievement = [[GameState shared] achievementStates];
    Wall * wall = [[Registry shared] getEntityByName:@"Wall"];
    if ([[achievement objectAtIndex:4] intValue] == 0 && [wall health] == [wall maxHealth]) { // a testar
        [achievement replaceObjectAtIndex:4 withObject:[NSNumber numberWithInt:1]];
    }
}

-(void) checkAchievement6
{
    NSMutableArray * achievement = [[GameState shared] achievementStates];
    
    NSMutableArray * stars = [[GameState shared] starStates];
    NSNumber * currentStars = [[stars objectAtIndex:9] intValue];
    
    if ([[achievement objectAtIndex:5] intValue] == 0 && currentStars > 0) {
        [achievement replaceObjectAtIndex:5 withObject:[NSNumber numberWithInt:1]];
    }
}

-(void) checkAchievement7
{
    NSMutableArray * achievement = [[GameState shared] achievementStates];
    
    NSMutableArray * stars = [[GameState shared] starStates];
    NSNumber * currentStars = [stars objectAtIndex:current_level-1];
    
    if ([[achievement objectAtIndex:6] intValue] == 0 && [currentStars intValue] == 3) {
        [achievement replaceObjectAtIndex:6 withObject:[NSNumber numberWithInt:1]];
    }
}

-(void) checkAchievement8
{
    NSMutableArray * stars = [[GameState shared] starStates];
    if ([[stars objectAtIndex:9] intValue] == 3) {
        NSMutableArray * achievement = [[GameState shared] achievementStates];
        BOOL allLevelsCompleted = YES;
        for (int i = 0; i < 9; i++) {
            if ([[stars objectAtIndex:i] intValue] != 3) {
                allLevelsCompleted = NO;
            }
        }
        
        if ([[achievement objectAtIndex:7] intValue] == 0 && allLevelsCompleted) {
            [achievement replaceObjectAtIndex:7 withObject:[NSNumber numberWithInt:1]];
        }
    }
}

-(void) checkAchievement9
{
    NSMutableArray * achievement = [[GameState shared] achievementStates];
    if ([[achievement objectAtIndex:8] intValue] == 0 && ([self checkSkillTreeBranch:0] || [self checkSkillTreeBranch:7] || [self checkSkillTreeBranch:14] || [self checkSkillTreeBranch:21])) {
        [achievement replaceObjectAtIndex:8 withObject:[NSNumber numberWithInt:1]];
    }
}

-(BOOL) checkSkillTreeBranch:(int)begin
{
    NSMutableArray *skill = [[GameState shared] skillStates];
    BOOL branchCompleted = YES;
    for (int i = begin; i < begin+7; i++) {
        if ([[skill objectAtIndex:i] intValue] == 0) {
            branchCompleted = NO;
        }
    }
    return branchCompleted;
}

-(void) checkAchievement10
{
    if (current_level == 5) {
        NSMutableArray * achievement = [[GameState shared] achievementStates];
        Wall * wall = [[Registry shared] getEntityByName:@"Wall"];
        
        if ([[achievement objectAtIndex:9] intValue] == 0 && [[ResourceManager shared] determineAccuracy] == 100 && [wall health] == 100) {
            [achievement replaceObjectAtIndex:9 withObject:[NSNumber numberWithInt:1]];
        }
        
    }
}

-(void) checkAchievement11
{
    NSMutableArray * achievement = [[GameState shared] achievementStates];
    if ([[achievement objectAtIndex:10]intValue] == 0 && [[[GameState shared] enemiesKilledState]intValue] > 9000) {
        [achievement replaceObjectAtIndex:10 withObject:[NSNumber numberWithInt:1]];
    }
}

-(void) checkAchievement12
{
    NSMutableArray * achievement = [[GameState shared] achievementStates];
    if ([[achievement objectAtIndex:11] intValue] == 0 && [[[GameState shared] fireElementalKilledState] intValue] > 100) {
        [achievement replaceObjectAtIndex:11 withObject:[NSNumber numberWithInt:1]];
    }
}

-(void) checkAchievement13
{
    if (current_level == 10) {
        NSMutableArray * achievement = [[GameState shared] achievementStates];
        Wall * wall = [[Registry shared] getEntityByName:@"Wall"];
        
        if ([[achievement objectAtIndex:12] intValue] == 0 && [[ResourceManager shared] determineAccuracy] > 100 && [wall health]) {
            [achievement replaceObjectAtIndex:12 withObject:[NSNumber numberWithInt:1]];
        }
    }
}

-(void) checkAchievement14
{
    NSMutableArray * achievement = [[GameState shared] achievementStates];
    if ([[achievement objectAtIndex:13] intValue] == 0 && [[[GameState shared] wallRepairState] intValue] > 100) {
        [achievement replaceObjectAtIndex:13 withObject:[NSNumber numberWithInt:1]];
    }
}

-(void) checkAchievement15
{
    NSMutableArray * achievement = [[GameState shared] achievementStates];
    BOOL allAchievementsUnlocked = YES;
    if ([[achievement objectAtIndex:14] intValue] == 0) {
        for (int i = 0; i < 14; i++) {
            NSNumber *value = [[achievement objectAtIndex:i] intValue];
            if (value == 0) {
                allAchievementsUnlocked = NO;
            }
        }
        if (allAchievementsUnlocked) {
            [achievement replaceObjectAtIndex:14 withObject:[NSNumber numberWithInt:1]];
        }
    }
}



@end
