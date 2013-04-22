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
  LevelThumbnail *_level1;
  LevelThumbnail *_level2;
}



- (void) pressedGoToMainMenu:(id)sender;
@end
