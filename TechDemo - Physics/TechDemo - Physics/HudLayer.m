//
//  HudLayer.m
//  L'Archer
//
//  Created by Ricardo on 4/14/13.
//
//

#import "HudLayer.h"
#import "Wall.h"

#define MAX_NUM_ARROWS 100

@implementation HudLayer
@synthesize numberOfEnemiesFromStart, numberOfEnemiesKilled, numberOfArrowsUsed;

-(id) init
{
    if( (self=[super init]))
    {
        buttons = [[NSMutableArray alloc] init];
        [buttons addObject:[NSNumber numberWithBool:NO]];
        [buttons addObject:[NSNumber numberWithBool:NO]];
        [buttons addObject:[NSNumber numberWithBool:NO]];
        
        _arrows = MAX_NUM_ARROWS;
        numberOfArrowsUsed =0;
        lastHealth = 100.00;
        
        label =[CCLabelTTF labelWithString:[NSString stringWithFormat:@"Number of Arrows Left: %i", MAX_NUM_ARROWS] fontName:@"Futura" fontSize:20];
        label2 = [CCLabelTTF labelWithString:@"Wall health: 100.00" fontName:@"Futura" fontSize:20];
        label3 = [CCLabelTTF labelWithString:@"Enemies: 0  Money:  0 Accurracy: 100%" fontName:@"Futura" fontSize:20];
        label.position = CGPointMake(label.contentSize.width/2 + 70, 80);
        label2.position = CGPointMake(label2.contentSize.width/2 + 70,50);
        label3.position = CGPointMake(label3.contentSize.width/2 + 70, 20);
        
        //Power Buttons
        CCMenuItem *plusMenuItem = [CCMenuItemImage
                                    itemWithNormalImage:@"plus.png" selectedImage:@"cross.png"
                                    target:self selector:@selector(plusButtonToggle)];
        plusMenuItem.position = ccp(810, 60);
        
        CCMenuItem *crossMenuItem = [CCMenuItemImage
                                     itemWithNormalImage:@"cross.png" selectedImage:@"bullseye.png"
                                     target:self selector:@selector(crossButtonToggle)];
        crossMenuItem.position = ccp(880, 60);
        
        CCMenuItem *bullseyeMenuItem = [CCMenuItemImage
                                        itemWithNormalImage:@"bullseye.png" selectedImage:@"plus.png"
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
    [self toggleButton:power1button];
}

- (void) crossButtonToggle
{
    [self toggleButton:power2button];
}

- (void) bullseyeButtonToggle
{
    [self toggleButton:power3button];
}


- (NSMutableArray *)buttonsPressed
{
    return buttons;
}

- (void)updateArrows
{
#warning arrow numbers
    if (_arrows>0)
    {
        numberOfArrowsUsed++;
        _arrows--;
        [label setString:[NSString stringWithFormat:@"Number of Arrows Left: %i", _arrows]];
    }
    
}

- (void)updateWallHealth
{
    double newHealth = [Wall getMajor].health;
    if(newHealth != lastHealth)
    {
        [label2 setString:[NSString stringWithFormat:@"Wall health: %.02f", newHealth]];
        lastHealth = newHealth;
    }
}


- (void)updateMoney:(int)enemyXPosition
{
    //    if (enemyXPosition < 500) {
    //        money++;
    //    } else if (enemyXPosition < 1000 && enemyXPosition > 500) {
    //        money = money + 2;
    //    } else money = money + 5;
    
    [label3 setString:[NSString stringWithFormat:@"Money: %i", money]];
}

- (void)increaseEnemyCount
{
    numberOfEnemiesFromStart++;
}

- (void)updateNumberOfEnemiesKilled:(int) killed
{
    
    [label3 setString:[NSString stringWithFormat:@"Enemies: %i Money: %i Accurracy: %d%%", numberOfEnemiesFromStart, killed, ((100*(killed+1))/(numberOfArrowsUsed+1))]];
}

-(int) hasArrows
{
    return _arrows;
}

-(void) dealloc
{
    [buttons dealloc];
    [super dealloc];
}

@end
