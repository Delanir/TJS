//
//  PauseHUD.h
//  L'Archer
//
//  Created by João Amaral on 20/4/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCBReader.h"

@interface PauseHUD : CCNode{
    CCSprite *_pause;
    CCSprite *_menu;
    CCSprite *_retry;
    CCSprite *_main;
}


-(CCSprite *) getPauseButton;
-(CCSprite *) getMenuButton;
-(CCSprite *) getMainButton;
-(CCSprite *) getRetryButton;

@end
