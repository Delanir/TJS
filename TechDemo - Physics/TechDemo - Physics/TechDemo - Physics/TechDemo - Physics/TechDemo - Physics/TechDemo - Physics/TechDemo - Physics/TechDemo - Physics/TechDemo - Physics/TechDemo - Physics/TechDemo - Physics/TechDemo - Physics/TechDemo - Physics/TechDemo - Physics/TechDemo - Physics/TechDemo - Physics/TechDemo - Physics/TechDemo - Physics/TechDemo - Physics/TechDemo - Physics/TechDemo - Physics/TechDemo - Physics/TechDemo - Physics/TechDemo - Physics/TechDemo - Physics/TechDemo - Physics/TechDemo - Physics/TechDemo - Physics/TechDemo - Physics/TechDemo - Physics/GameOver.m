//
//  GameOver.m
//  L'Archer
//
//  Created by MiniclipMacBook on 4/18/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameOver.h"


@implementation GameOver

-(CGPoint) mainMenuButtonPosition{
    return _mainMenuButton.position;
};
-(float) mainMenuButtonRadius{
    return max(_mainMenuButton.contentSize.width*self.scaleX, _mainMenuButton.contentSize.height*self.scaleY);
};

@end
