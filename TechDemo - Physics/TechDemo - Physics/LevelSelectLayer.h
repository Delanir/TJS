//
//  LevelSelectLayer.h
//  L'Archer
//
//  Created by João Amaral on 20/4/13.
//
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCBReader.h"
#import "CCLayer.h"
#import "LevelThumbnail.h"

@interface LevelSelectLayer : CCLayer
{
    CCArray * levelButtons;
    LevelThumbnail *_level1;
    LevelThumbnail *_level2;
    LevelThumbnail *_level3;
    LevelThumbnail *_level4;
    LevelThumbnail *_level5;
    LevelThumbnail *_level6;
    LevelThumbnail *_level7;
    LevelThumbnail *_level8;
    LevelThumbnail *_level9;
    LevelThumbnail *_level10;
}



- (void) pressedGoToMainMenu:(id)sender;
@end
