//
//  Level.h
//  TechDemo - Physics
//
//  Created by jp on 30/03/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//



// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Hud.h"


// HelloWorldLayer
@interface LevelLayer : LevelLayerAbstract
{
    BOOL fire;
    Hud *hud;
    double timeElapsedSinceBeginning;
    CGPoint location;

}
@property (nonatomic,retain) Hud *hud;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;


@end
