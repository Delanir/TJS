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
	
    [ResourceManager loadLevelSprites];
    
	// 'layer' is an autorelease object.
    Hud *levelHud = [Hud node];
	LevelLayer *level = [LevelLayer node];
	
	// add layer as a child to scene
	[scene addChild: levelHud z:1];
	[scene addChild: level z:0];
    
    level.hud = levelHud;
    
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
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        _pauseButton= [CCSprite spriteWithSpriteFrameName:@"pause.png"];
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
        
        // Prepare the changes due to the Skill Tree
        [self prepSkillTreeChanges];

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
    
/*
 Vamos fazer assim:
Done1 - As definiçoes estao guardadas no gamestate
 
    2 - Vamos buscá-las e inicializamos as funções básicas
Done    2.1 - Criamos as variáveis no enemy
        2.2 - Criamos os comportamentos associados no tratamento de estimulo
        2.3 - Criamos o tratamento de updates destes
        2.4 - Importante não nos esquecermos de finalizar e restaurar o estado.
            2.4.1 - Uma ideia interessante era usar heaps para fazer o estado temporário
 
    3 - Para os comportamentos secundários queremos alterar variáveis de bónus
        3.1 - As variáveis säo utilizadas nos métodos de inicializaçao das classes, 
                por isso dá jeito aqui actualizar um repositório de dados, como o GameState
                onde as instancias podem ir buscar os dados
        3.2 - Dá jeito ter um método que encontra as instancias que estão num determinado
                raio de um inimigo nos casos de area of effect
        3.3 - Dá jeito ter um método que encontra a instancia mais próxima de um determinado
                inimigo para o caso de passar um estimulo
        3.4 - Fazer a cidade é simples, mas ainda falta as sprites para o efeito
            3.4.1 - O fletcher é o pior, em termos de lógica. Mas não é assim tanto.
                3.4.1.1 - Era giro se as flechas do fletcher também usassem a lógica dos estimulos
                            caso os poderes estivessem activos
 */
    
    
    if ([[skill objectAtIndex:kIceMainBranch] intValue] != 0)
    {
#warning TODO - Aqui não é preciso fazer mais nada. É o tratamento básico do estimulo no enemy
        [headsUpDisplay setIceToggleButtonActive];
    }
    if ([[skill objectAtIndex:kFireMainBranch] intValue] != 0)
    {
        [headsUpDisplay setFireToggleButtonActive];
    }
    if ([[skill objectAtIndex:kMarksmanMainBranch] intValue] != 0)
    {
#warning TODO - Aqui não é preciso fazer mais nada. É o tratamento básico do estimulo no enemy
        [headsUpDisplay setPushbackToggleButtonActive];
    }
    if ([[skill objectAtIndex:kCityMainBranch] intValue] != 0)
    {
        Wall * wall = [[Registry shared] getEntityByName:@"Wall"];
        [wall increaseHealth:1.5];
    }
    
    /**
     *
     * GELOOOOO
     *
     */
    if ([[skill objectAtIndex:kIceBranch1] intValue] != 0)
    {
        [yuri setSlowPercentageBonus:kYuriSlowDownDurationBaseBonus];
    }
    if ([[skill objectAtIndex:kIceBranch2] intValue] != 0)
    {
#warning TODO
        NSLog(@"Ha uma % de fazer freeze (slowdown de 100%)");
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
#warning TODO
        NSLog(@"Ha uma % ainda maior de fazer freeze (slowdown de 100%)");
    }
    if ([[skill objectAtIndex:kIceElement3] intValue] != 0)
    {
        [yuri setIceAreaOfEffect:kYuriExtraAreaOfEffect];
    }
    
    /**
     *
     * FOGOOOOO
     *
     */
    if ([[skill objectAtIndex:kFireBranch1] intValue] != 0)
    {
        [yuri setFireDamageBonus:kYuriDamageOverTimeDamageBaseBonus];
        [yuri setFireDurationBonus:kYuriDamageOverTimeDurationBaseBonus];
    }
    if ([[skill objectAtIndex:kFireBranch2] intValue] != 0)
    {
#warning TODO
        NSLog(@"Fogo passa para o proximo inimigo");
    }
    if ([[skill objectAtIndex:kFireBranch3] intValue] != 0)
    {
        [yuri setFireAreaOfEffect:kYuriBaseAreaOfEffect];
    }
    if ([[skill objectAtIndex:kFireElement1] intValue] != 0)
    {
        [yuri setFireDamageBonus:kYuriDamageOverTimeDamageExtraBonus];
        [yuri setFireDurationBonus:kYuriDamageOverTimeDurationExtraBonus];
    }
    if ([[skill objectAtIndex:kFireElement2] intValue] != 0)
    {
#warning TODO
        NSLog(@"Fogo passa para os 2 inimigos mais proximos");
    }
    if ([[skill objectAtIndex:kFireElement3] intValue] != 0)
    {
        [yuri setFireAreaOfEffect:kYuriExtraAreaOfEffect];
    }
    
    /**
     *
     * MARKSMAAAN
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
        [yuri setCriticalBonus:kYuriExtraCriticalBonus];
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
#warning TODO
        NSLog(@"Mage's tower recovers mana");
        NSLog(@"Draws Mage's tower");
    }
    if ([[skill objectAtIndex:kCityBranch2] intValue] != 0)
    {
#warning TODO
        NSLog(@"Wall health recovers over time");
        NSLog(@"Draws Masonry");
    }
    if ([[skill objectAtIndex:kCityBranch3] intValue] != 0)
    {
#warning TODO
        NSLog(@"Fletcher fires arrows against the enemies");
        NSLog(@"Draws Fletcher");
    }
    if ([[skill objectAtIndex:kCityElement1] intValue] != 0)
    {
#warning TODO
        NSLog(@"Mage's tower recovers even more mana");
        NSLog(@"Draws Mage's tower");
    }
    if ([[skill objectAtIndex:kCityElement2] intValue] != 0)
    {
#warning TODO
        NSLog(@"Wall health recovers faster over time");
        NSLog(@"Draws Masonry");
    }
    if ([[skill objectAtIndex:kCityElement3] intValue] != 0)
    {
#warning TODO
        NSLog(@"Fletcher arrows are faster and stronger over time");
        NSLog(@"Draws Fletcher");
    }
    
    [yuri initBasicStats];
}


/**
 *
 * Update logic
 *
 */

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

-(void)onExit
{
    [[GameState shared] saveApplicationData];
    [[Registry shared] clearRegistry];
    [[CollisionManager shared] clearAllEntities];
    [self removeAllChildrenWithCleanup:YES];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFrames];
    [[CCTextureCache sharedTextureCache] removeAllTextures];
    [super onExit];
    
}

-(void)dealloc
{
    [super dealloc];
    CCLOG(@"DEALOQUEI");
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




@end
