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
        
        unsigned int maxArrows = [[ResourceManager shared] arrows];
        label1 =[CCLabelTTF labelWithString:[NSString stringWithFormat:@"Number of Arrows Left: %i", maxArrows] fontName:@"Futura" fontSize:20];
        label2 = [CCLabelTTF labelWithString:@"Wall health: 100.00" fontName:@"Futura" fontSize:20];
        label3 = [CCLabelTTF labelWithString:@"Enemies: 0  Money:  0 Accurracy: 100%" fontName:@"Futura" fontSize:20];
        label1.position = CGPointMake(label1.contentSize.width/2 + 70, 80);
        label2.position = CGPointMake(label2.contentSize.width/2 + 70,50);
        label3.position = CGPointMake(label3.contentSize.width/2 + 70, 20);
        
        //Power Buttons
        CCMenuItem *iceOn = [CCMenuItemImage
                             itemWithNormalImage:@"IceButton.png" selectedImage:@"IceButton.png"
                             target:self selector:nil];
        CCMenuItem *iceOff = [CCMenuItemImage
                              itemWithNormalImage:@"IceButton-bw.png" selectedImage:@"IceButton-bw.png"
                              target:self selector:nil];
        
        CCMenuItemToggle *iceToggleButton = [CCMenuItemToggle itemWithTarget:self
                                                                    selector:@selector(iceButtonToggle)
                                                                       items:iceOff, iceOn, nil];
        iceToggleButton.position = ccp(750, 60);
        
        
        
        CCMenuItem *fireOn = [CCMenuItemImage
                              itemWithNormalImage:@"FireButton.png" selectedImage:@"FireButton.png"
                              target:self selector:nil];
        CCMenuItem *fireOff = [CCMenuItemImage
                               itemWithNormalImage:@"FireButton-bw.png" selectedImage:@"FireButton-bw.png"
                               target:self selector:nil];
        
        CCMenuItemToggle *fireToggleButton = [CCMenuItemToggle itemWithTarget:self
                                                                     selector:@selector(fireButtonToggle)
                                                                        items:fireOff, fireOn, nil];
        fireToggleButton.position = ccp(850, 60);
        
        
        
        CCMenuItem *pushBackOn = [CCMenuItemImage
                                  itemWithNormalImage:@"MarksManButton.png" selectedImage:@"MarksManButton.png"
                                  target:self selector:nil];
        CCMenuItem *pushBackOff = [CCMenuItemImage
                                   itemWithNormalImage:@"MarksManButton-bw.png" selectedImage:@"MarksManButton-bw.png"
                                   target:self selector:nil];
        
        CCMenuItemToggle *pushBackToggleButton = [CCMenuItemToggle itemWithTarget:self
                                                                         selector:@selector(pushBackButtonToggle)
                                                                            items:pushBackOff, pushBackOn, nil];
        pushBackToggleButton.position = ccp(950, 60);
        
        
        CCMenu *hudMenu = [CCMenu menuWithItems:iceToggleButton, fireToggleButton, pushBackToggleButton, nil];
        hudMenu.position = CGPointZero;
        
        
        [self addChild:hudMenu];
        [self addChild:label1 z:1];
        [self addChild:label2 z:1];
        [self addChild:label3 z:1];
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


- (NSMutableArray *)buttonsPressed
{
    return buttons;
}

- (void)updateArrows
{
    [label1 setString:[NSString stringWithFormat:@"Number of Arrows Left: %i", [[ResourceManager shared] arrows]]];
}

- (void)updateWallHealth
{
    Wall * wall = [[Registry shared] getEntityByName:@"Wall"];
    double newHealth = [wall health];
    // optimização
    if(newHealth != lastHealth)
    {
        [label2 setString:[NSString stringWithFormat:@"Wall health: %.02f", newHealth]];
        lastHealth = newHealth;
    }
}


- (void)updateMoney:(int)enemyXPosition
{
    [label3 setString:[NSString stringWithFormat:@"Gold: %i", [[ResourceManager shared] gold]]];
}

- (void)updateData
{
    ResourceManager * rm = [ResourceManager shared];
    unsigned int enemies = [rm activeEnemies];
    unsigned int gold = [rm gold];
    double accuracy = [rm determineAccuracy];
    double mana = [rm mana];
    if (accuracy < 0)
        [label3 setString:[NSString stringWithFormat:@"Enemies: %i Gold: %i Accuracy: ---%% Mana: %.0f", enemies, gold, mana]];
    else
        [label3 setString:[NSString stringWithFormat:@"Enemies: %i Gold: %i Accuracy: %i%% Mana: %.0f", enemies, gold, (int) accuracy, mana]];
}

-(void) dealloc
{
    [buttons release];
    buttons = nil;
    [super dealloc];
}

@end
