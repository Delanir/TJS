//
//  HudLayer.m
//  L'Archer
//
//  Created by Ricardo on 4/14/13.
//
//

#import "Hud.h"
#import "SpriteManager.h"
#import "Registry.h"
#import "Constants.h"

@implementation Hud

@synthesize fireToggleButton, iceToggleButton, pushBackToggleButton;

-(id) init
{
    if( self=[super init])
    {
        [[Registry shared] registerEntity:self withName:@"Hud"];
        
        buttons = [[NSMutableArray alloc] init];
        [buttons addObject:[NSNumber numberWithBool:NO]];
        [buttons addObject:[NSNumber numberWithBool:NO]];
        [buttons addObject:[NSNumber numberWithBool:NO]];
        lastHealth = [(Wall*)[[Registry shared] getEntityByName:@"Wall"] maxHealth];
        lastMana = [[ResourceManager shared] maxMana];
        
        CCSprite * hudBackground = [CCSprite spriteWithSpriteFrameName:@"hud-background.png"];
        [hudBackground setPosition:ccp(512,64)];
        
        CCSprite * manaDais = [CCSprite spriteWithSpriteFrameName:@"emptydais.png"];
        [manaDais setPosition:ccp(950, 64)];
        CCSprite * healthDais = [CCSprite spriteWithSpriteFrameName:@"emptydais.png"];
        [healthDais setPosition:ccp(74, 64)];
        
        CCSprite * healthSprite = [CCSprite spriteWithSpriteFrameName:@"healthdais.png"];
        [healthSprite setPosition:ccp(512, 384)];
        [healthSprite setAnchorPoint:ccp(0.5,0.5)];
        healthProgress = [CCProgressTimer progressWithSprite:healthSprite];
        [healthProgress setType: kCCProgressTimerTypeBar];
        [healthProgress setBarChangeRate:ccp(0,1)];
        [healthProgress setMidpoint:ccp(0.5,0)];
        [healthProgress setPercentage:100];
        [healthProgress setPosition:ccp(74, 64)];
        
        CCSprite * manaSprite = [CCSprite spriteWithSpriteFrameName:@"manadais.png"];
        [manaSprite setPosition:ccp(512, 384)];
        [manaSprite setAnchorPoint:ccp(0.5,0.5)];
        manaProgress = [CCProgressTimer progressWithSprite:manaSprite];
        [manaProgress setType: kCCProgressTimerTypeBar];
        [manaProgress setBarChangeRate:ccp(0,1)];
        [manaProgress setMidpoint:ccp(0.5,0)];
        [manaProgress setPercentage:100];
        [manaProgress setPosition:ccp(950, 64)];
        
        CCSprite * currentArrowsSprite = [CCSprite spriteWithSpriteFrameName:@"arrow.png"];
        [currentArrowsSprite setPosition:ccp(173,40)];
        CCSprite * currentMoneySprite = [CCSprite spriteWithSpriteFrameName:@"Coins.png"];
        [currentMoneySprite setPosition:ccp(173,88)];
        
        //Labels Start
        unsigned int nArrows = [[ResourceManager shared] arrows];
        unsigned int nGolds = [[ResourceManager shared] gold];
        label1 = [CCLabelTTF labelWithString: [NSString stringWithFormat:@"%i", nArrows] fontName:@"Futura" fontSize:24];
        label2 = [CCLabelTTF labelWithString: [NSString stringWithFormat:@"%i", nGolds] fontName:@"Futura" fontSize:24];
        [label1 setAnchorPoint:ccp(0,0.5)];
        [label2 setAnchorPoint:ccp(0,0.5)];
        label1.position = CGPointMake(197, 40);
        label2.position = CGPointMake(197, 88);
        //Labels End
        
        
        //Power Buttons Start
        CCMenuItem *iceOn = [CCMenuItemImage
                             itemWithNormalSprite: [CCSprite spriteWithSpriteFrameName:@"IceButton.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"IceButton.png"]
                             target:self selector:nil];
        CCMenuItem *iceOff = [CCMenuItemImage
                              itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"IceButton-bw.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"IceButton-bw.png"]
                              target:self selector:nil];
        
        iceToggleButton = [CCMenuItemToggle itemWithTarget:self
                                                  selector:@selector(iceButtonToggle)
                                                     items:iceOff, iceOn, nil];
        [iceToggleButton setIsEnabled:NO];
        [iceToggleButton setOpacity:80];
        iceToggleButton.position = ccp(680, 64);
        
        CCMenuItem *fireOn = [CCMenuItemImage
                              itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"FireButton.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"FireButton.png"]
                              target:self selector:nil];
        CCMenuItem *fireOff = [CCMenuItemImage
                               itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"FireButton-bw.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"FireButton-bw.png"]
                               target:self selector:nil];
        
        fireToggleButton = [CCMenuItemToggle itemWithTarget:self
                                                   selector:@selector(fireButtonToggle)
                                                      items:fireOff, fireOn, nil];
        [fireToggleButton setIsEnabled:NO];
        [fireToggleButton setOpacity:80];
        fireToggleButton.position = ccp(760, 64);
        
        
        CCMenuItem *pushBackOn = [CCMenuItemImage
                                  itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"MarksManButton.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"MarksManButton.png"]
                                  target:self selector:nil];
        CCMenuItem *pushBackOff = [CCMenuItemImage
                                   itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"MarksManButton-bw.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"MarksManButton-bw.png"]
                                   target:self selector:nil];
        
        pushBackToggleButton = [CCMenuItemToggle itemWithTarget:self
                                                       selector:@selector(pushBackButtonToggle)
                                                          items:pushBackOff, pushBackOn, nil];
        [pushBackToggleButton setIsEnabled:NO];
        [pushBackToggleButton setOpacity:80];
        pushBackToggleButton.position = ccp(840, 64);
        
        CCSprite * buyButtonSprite1 = [CCSprite spriteWithSpriteFrameName:@"buyarrow.png"];
        CCSprite * buyButtonSprite2 = [CCSprite spriteWithSpriteFrameName:@"buyarrowPressed.png"];
        
        CCMenuItem *buyButton = [CCMenuItemImage itemWithNormalSprite:buyButtonSprite1 selectedSprite:buyButtonSprite2 target:self selector:@selector(buyArrows)];
        
        CCSprite * repairButtonSprite1 = [CCSprite spriteWithSpriteFrameName:@"repair.png"];
        CCSprite * repairButtonSprite2 = [CCSprite spriteWithSpriteFrameName:@"repairPressed.png"];
        
        CCMenuItem *repairButton = [CCMenuItemImage itemWithNormalSprite:repairButtonSprite1 selectedSprite:repairButtonSprite2 target:self selector:@selector(repairWall)];
        
        buyButton.position = ccp(332, 64);
        repairButton.position = ccp(432,64);
        
        CCMenu *buttonsMenu = [CCMenu menuWithItems:iceToggleButton, fireToggleButton, pushBackToggleButton, buyButton, repairButton, nil];
        buttonsMenu.position = CGPointZero;
        //Power Buttons End
        
        [self addChild:buttonsMenu];
        [self addChild:currentArrowsSprite z:1];
        [self addChild:currentMoneySprite z:1];
        [self addChild:hudBackground z:-1];
        [self addChild:manaDais z:2];
        [self addChild:manaProgress z:1];
        [self addChild:healthDais z:2];
        [self addChild:healthProgress z:1];
        [self addChild:label1 z:1];
        [self addChild:label2 z:1];
    }
    
    self.isTouchEnabled = YES;
    
    return self;
}

- (void)toggleButton: (powerButton) button
{
    BOOL current = [[buttons objectAtIndex:button] boolValue];
    [buttons replaceObjectAtIndex:button withObject:[NSNumber numberWithBool:!current]];
}

- (void) iceButtonToggle
{
    [self toggleButton:kPower1Button];
}

- (void) fireButtonToggle
{
    [self toggleButton:kPower2Button];
}

- (void) pushBackButtonToggle
{
    [self toggleButton:kPower3Button];
}

-(void) setFireToggleButtonActive
{
    [fireToggleButton setIsEnabled:YES];
    [fireToggleButton setOpacity:255];
}

-(void) setIceToggleButtonActive
{
    [iceToggleButton setIsEnabled:YES];
    [iceToggleButton setOpacity:255];
}

-(void) setPushbackToggleButtonActive
{
    [pushBackToggleButton setIsEnabled:YES];
    [pushBackToggleButton setOpacity:255];
}

- (void) buyArrows
{
    if ([[ResourceManager shared] spendGold:BUYARROWSCOST])
    {
        [[ResourceManager shared] addArrows:BUYARROWGAIN];
        [self updateArrows];
        [self updateMoney];
        
        int numArrows = [[[GameState shared] buyArrowsState] intValue] + BUYARROWGAIN;
        [[GameState shared] setBuyArrowsState:[NSNumber numberWithInt:numArrows]];
    }
}

- (void) repairWall
{
    if ([[ResourceManager shared] spendGold:WALLREPAIRCOST])
    {
        Wall *w =[[Registry shared] getEntityByName:@"Wall"];
        
         [w regenerateHealth:WALLREPAIRPERCENTAGE*[w maxHealth]];
        
        
        [self updateWallHealth];
        [self updateMoney];
        
        int wallRepairCount = [[[GameState shared] wallRepairState] intValue] + 1;
        [[GameState shared] setWallRepairState:[NSNumber numberWithInt:wallRepairCount]];
    }
}


- (NSMutableArray *)buttonsPressed
{
    return buttons;
}

- (void)updateArrows
{
    [label1 setString:[NSString stringWithFormat:@"%i", [[ResourceManager shared] arrows]]];
}

- (void)updateMoney
{
    [label2 setString:[NSString stringWithFormat:@"%i", [[ResourceManager shared] gold]]];
}

- (void)updateWallHealth
{
    Wall * wall = [[Registry shared] getEntityByName:@"Wall"];
    double newHealth = [wall health];
    // optimização
    if(newHealth != lastHealth)
    {
        double maxHealth = [wall maxHealth];
        lastHealth = newHealth;
        [healthProgress setPercentage: 100 * newHealth/maxHealth];
    }
}

- (void)updateMana
{
    ResourceManager * rm = [ResourceManager shared];
    double newMana= [rm mana];
    // optimização
    if(newMana != lastMana)
    {
        double maxMana = [rm maxMana];
        lastMana = newMana;
        [manaProgress setPercentage: 100 * newMana/maxMana];
    }
}

-(void) dealloc
{
    [buttons release];
    buttons = nil;
    [super dealloc];
}

@end
