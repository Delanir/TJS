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
        label =[CCLabelTTF labelWithString:[NSString stringWithFormat:@"Number of Arrows Left: %i", maxArrows] fontName:@"Futura" fontSize:20];
        label2 = [CCLabelTTF labelWithString:@"Wall health: 100.00" fontName:@"Futura" fontSize:20];
        label3 = [CCLabelTTF labelWithString:@"Enemies: 0  Money:  0 Accurracy: 100%" fontName:@"Futura" fontSize:20];
        label.position = CGPointMake(label.contentSize.width/2 + 70, 80);
        label2.position = CGPointMake(label2.contentSize.width/2 + 70,50);
        label3.position = CGPointMake(label3.contentSize.width/2 + 70, 20);
        
        //Power Buttons
        CCMenuItemToggle *plusMenuItem = [CCMenuItemImage
                                    itemWithNormalImage:@"IceButton.png" selectedImage:@"IceButton-bw.png"
                                    target:self selector:@selector(plusButtonToggle)];
        plusMenuItem.position = ccp(810, 60);
        
        CCMenuItem *crossMenuItem = [CCMenuItemImage
                                     itemWithNormalImage:@"FireButton.png" selectedImage:@"FireButton-bw.png"
                                     target:self selector:@selector(crossButtonToggle)];
        crossMenuItem.position = ccp(880, 60);
        
        CCMenuItem *bullseyeMenuItem = [CCMenuItemImage
                                        itemWithNormalImage:@"MarksManButton.png" selectedImage:@"MarksManButton-bw.png"
                                        target:self selector:@selector(bullseyeButtonToggle)];
        bullseyeMenuItem.position = ccp(950, 60);
        
        
        CCMenu *superMenu = [CCMenu menuWithItems:plusMenuItem, crossMenuItem, bullseyeMenuItem, nil];
        superMenu.position = CGPointZero;
        
        
        
        [self addChild:superMenu];
        [self addChild:label z:1];
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


- (void) plusButtonToggle
{
    [self toggleButton:kPower1Button];
}

- (void) crossButtonToggle
{
    [self toggleButton:kPower2Button];
}

- (void) bullseyeButtonToggle
{
    [self toggleButton:kPower3Button];
}


- (NSMutableArray *)buttonsPressed
{
    return buttons;
}

- (void)updateArrows
{
   [label setString:[NSString stringWithFormat:@"Number of Arrows Left: %i", [[ResourceManager shared] arrows]]];
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
    if (accuracy < 0)
        [label3 setString:[NSString stringWithFormat:@"Enemies: %i Gold: %i Accuracy: ---%%", enemies, gold]];
    else
        [label3 setString:[NSString stringWithFormat:@"Enemies: %i Gold: %i Accuracy: %i%%", enemies, gold, (int) accuracy]];
}

-(void) dealloc
{
    [buttons release];
    buttons = nil;
    [super dealloc];
}

@end
