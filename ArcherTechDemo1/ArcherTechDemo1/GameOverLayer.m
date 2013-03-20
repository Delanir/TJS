//
//  GameOverLayer.m
//  L'Archer D'Amiens Tech Demo Particle System Testing (LADA)
//
//  Created by Joao Amaral on 17/03/2013.
//  Copyright NightOwl Studios 2013. All rights reserved.
//

#import "GameOverLayer.h"
#import "HelloWorldLayer.h"

@implementation GameOverLayer

+(CCScene *) sceneWithWon:(BOOL)won {
    CCScene *scene = [CCScene node];
    GameOverLayer *layer = [[[GameOverLayer alloc] initWithWon:won] autorelease];
    [scene addChild: layer];
    return scene;
}

- (id)initWithWon:(BOOL)won {
    if ((self = [super initWithColor:ccc4(0, 0, 0, 255)])) {
        
        NSString * message;
        if (won) {
            message = @"Yurie has saved the village!";
        } else {
            message = @"Yurie has lost a life!";
        }

        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCLabelTTF * label = [CCLabelTTF labelWithString:message fontName:@"Futura" fontSize:40];
        label.color = ccc3(255,255,255);
        label.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:label];
        
        [self runAction:
         [CCSequence actions:
          [CCDelayTime actionWithDuration:3],
          [CCCallBlockN actionWithBlock:^(CCNode *node) {
             [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer scene]];
        }],
          nil]];
    }
    return self;
}

@end
