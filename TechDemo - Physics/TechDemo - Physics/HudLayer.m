//
//  HudLayer.m
//  L'Archer
//
//  Created by Ricardo on 4/14/13.
//
//

#import "HudLayer.h"

@implementation HudLayer

-(id) init
{
    if( (self=[super init]))
    {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        buttons = 0;
        _arrows = 50;

        
        label = [CCLabelTTF labelWithString:@"Number of Arrows Left: 50" fontName:@"Futura" fontSize:20];
        label2 = [CCLabelTTF labelWithString:@"Wall health: 100" fontName:@"Futura" fontSize:20];
        label3 = [CCLabelTTF labelWithString:@"Money: 0" fontName:@"Futura" fontSize:20];
        label.position = CGPointMake(label.contentSize.width/2 + 70, 80);
        label2.position = CGPointMake(label2.contentSize.width/2 + 70,50);
        label3.position = CGPointMake(label3.contentSize.width/2 + 70, 20);
        
              //Power Buttons
              CCMenuItem *plusMenuItem = [CCMenuItemImage
                                         itemFromNormalImage:@"plus.png" selectedImage:@"cross.png"
                                         target:self selector:@selector(plusButtonTapped:)];
              plusMenuItem.position = ccp(810, 60);
        
              CCMenuItem *crossMenuItem = [CCMenuItemImage
                                           itemFromNormalImage:@"cross.png" selectedImage:@"plus.png"
                                           target:self selector:@selector(crossButtonTapped:)];
              crossMenuItem.position = ccp(880, 60);
        
                CCMenuItem *bullseyeMenuItem = [CCMenuItemImage
                                                itemFromNormalImage:@"bullseye.png" selectedImage:@"plus.png"
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
  //CCLOG(@"PLUS BUTTON PRESSED");
  buttons=1;
}

- (void)crossButtonTapped:(id)sender {
  //CCLOG(@"CROSS BUTTON PRESSED");
  buttons=2;
}

- (void)bullseyeButtonTapped:(id)sender {
  //CCLOG(@"BULLSEYE BUTTON PRESSED");
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

@end
