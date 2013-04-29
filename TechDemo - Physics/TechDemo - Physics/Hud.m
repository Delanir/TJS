//
//  HudLayer.m
//  L'Archer
//
//  Created by Ricardo on 4/14/13.
//
//

#import "Hud.h"

@implementation Hud

-(id) init
{
    if( (self=[super init]))
    {
        buttons = [[NSMutableArray alloc] init];
        [buttons addObject:[NSNumber numberWithBool:NO]];
        [buttons addObject:[NSNumber numberWithBool:NO]];
        [buttons addObject:[NSNumber numberWithBool:NO]];
        lastHealth = 100.00;
        
        CCSprite * hudBackground = [CCSprite spriteWithFile:@"hud-background.png"];
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
        //[healthProgress setOpacity:180];
        [healthProgress setPosition:ccp(74, 64)];
        
        CCSprite * manaSprite = [CCSprite spriteWithSpriteFrameName:@"manadais.png"];
        [manaSprite setPosition:ccp(512, 384)];
        [manaSprite setAnchorPoint:ccp(0.5,0.5)];
        manaProgress = [CCProgressTimer progressWithSprite:manaSprite];
        [manaProgress setType: kCCProgressTimerTypeBar];
        [manaProgress setBarChangeRate:ccp(0,1)];
        [manaProgress setMidpoint:ccp(0.5,0)];
        [manaProgress setPercentage:70];
        //[manaProgress setOpacity:180];
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
                             itemWithNormalImage:@"IceButton.png" selectedImage:@"IceButton.png"
                             target:self selector:nil];
        CCMenuItem *iceOff = [CCMenuItemImage
                              itemWithNormalImage:@"IceButton-bw.png" selectedImage:@"IceButton-bw.png"
                              target:self selector:nil];
        
        CCMenuItemToggle *iceToggleButton = [CCMenuItemToggle itemWithTarget:self
                                                                    selector:@selector(iceButtonToggle)
                                                                       items:iceOff, iceOn, nil];
        iceToggleButton.position = ccp(680, 64);
        
        CCMenuItem *fireOn = [CCMenuItemImage
                              itemWithNormalImage:@"FireButton.png" selectedImage:@"FireButton.png"
                              target:self selector:nil];
        CCMenuItem *fireOff = [CCMenuItemImage
                               itemWithNormalImage:@"FireButton-bw.png" selectedImage:@"FireButton-bw.png"
                               target:self selector:nil];
        
        CCMenuItemToggle *fireToggleButton = [CCMenuItemToggle itemWithTarget:self
                                                                     selector:@selector(fireButtonToggle)
                                                                    items:fireOff, fireOn, nil];
        fireToggleButton.position = ccp(760, 64);

        
        CCMenuItem *pushBackOn = [CCMenuItemImage
                                  itemWithNormalImage:@"MarksManButton.png" selectedImage:@"MarksManButton.png"
                                  target:self selector:nil];
        CCMenuItem *pushBackOff = [CCMenuItemImage
                                   itemWithNormalImage:@"MarksManButton-bw.png" selectedImage:@"MarksManButton-bw.png"
                                   target:self selector:nil];
        
        CCMenuItemToggle *pushBackToggleButton = [CCMenuItemToggle itemWithTarget:self
                                                                         selector:@selector(pushBackButtonToggle)
                                                                            items:pushBackOff, pushBackOn, nil];
        pushBackToggleButton.position = ccp(840, 64);
        
        CCSprite * buyButtonSprite1 = [CCSprite spriteWithFile:@"buyarrow.png"];
        CCSprite * buyButtonSprite2 = [CCSprite spriteWithFile:@"buyarrowPressed.png"];
        
        CCMenuItem *buyButton = [CCMenuItemImage itemWithNormalSprite:buyButtonSprite1 selectedSprite:buyButtonSprite2 target:self selector:@selector(buyArrows)];
        
        buyButton.position = ccp(332, 64);
        
        CCMenu *buttonsMenu = [CCMenu menuWithItems:iceToggleButton, fireToggleButton, pushBackToggleButton, buyButton, nil];
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

- (void) buyArrows
{
    if ([[ResourceManager shared] gold] > 4)
    {
        [[ResourceManager shared] addArrows:10];
        [[ResourceManager shared] spendGold:5];
        [self updateArrows];
        [self updateMoney];
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
        //[label2 setString:[NSString stringWithFormat:@"Wall health: %.02f", newHealth]];
        lastHealth = newHealth;
        [healthProgress setPercentage: 100 * newHealth/maxHealth];
    }
}


-(void) dealloc
{
    [buttons release];
    buttons = nil;
    [super dealloc];
}

@end
