//
//  LoadingBar.h
//  L'Archer
//
//  Created by jp on 26/04/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LoadingBar : CCNode
{
    CCProgressTimer * loadingTimer;
}

@property (nonatomic, retain) CCProgressTimer * loadingTimer;

-(void) addProgress:(float) variation;

@end
