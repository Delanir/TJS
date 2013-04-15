//
//  HudLayer.m
//  L'Archer
//
//  Created by Ricardo on 4/14/13.
//
//

#import "HudLayer.h"
#import "Wall.h"

@implementation HudLayer

-(id) init
{
    if( (self=[super init]))
    {
        buttons = 0;
        _arrows = 50;
        lastHealth = 100.00;

        label = [CCLabelTTF labelWithString:@"Number of Arrows Left: 50" fontName:@"Futura" fontSize:20];
        label2 = [CCLabelTTF labelWithString:@"Wall health: 100.00" fontName:@"Futura" fontSize:20];
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
    }
    
    self.isTouchEnabled = YES;
    
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

- (int)buttonPressed
{
    return buttons;
}

- (void)updateArrows
{
    _arrows--;
    [label setString:[NSString stringWithFormat:@"Number of Arrows Left: %i", _arrows]];
}

- (void)updateWallHealth
{
    double newHealth = [Wall getMajor].health;
    if(newHealth != lastHealth) {
        [label2 setString:[NSString stringWithFormat:@"Wall health: %.02f", newHealth]];
        lastHealth = newHealth;
    }
}

- (void)updateMoney:(int)enemyXPosition
{
    if (enemyXPosition < 500) {
        money++;
    } else if (enemyXPosition < 1000 && enemyXPosition > 500) {
        money = money + 2;
    } else money = money + 5;
    
    [label3 setString:[NSString stringWithFormat:@"Money: %i", money]];
}

@end
