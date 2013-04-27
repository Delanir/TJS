//
//  GameWin.m
//  L'Archer
//
//  Created by Ricardo on 4/25/13.
//
//

#import "GameWin.h"

@implementation GameWin

-(CGPoint) mainMenuButtonPosition{
    return _mainMenuButton.position;
};
-(float) mainMenuButtonRadius{
    return max(_mainMenuButton.contentSize.width*self.scaleX, _mainMenuButton.contentSize.height*self.scaleY);
};

@end
