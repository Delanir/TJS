//
//  CCMenu_CCMenu_Slider.m
//  TechDemo - Sprites
//
//  Created by MiniclipMacBook on 4/2/13.
//  Copyright (c) 2013 TJS. All rights reserved.
//

#import "CCMenu_CCMenu_Slider.h"

@implementation CCMenu(CCMenu_CCMenu_Slider)
-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
	NSAssert(state_ == kCCMenuStateTrackingTouch, @"[Menu ccTouchMoved] -- invalid state");
    
	CCMenuItem *currentItem = [self itemForTouch:touch];
    
	if (currentItem != selectedItem_) {
		[selectedItem_ unselected];
		selectedItem_ = currentItem;
		[selectedItem_ selected];
	} else {
		if ([selectedItem_ respondsToSelector: @selector(dragToPoint:)]) {
			CGPoint touchLocation = [selectedItem_ convertTouchToNodeSpace: touch];
            
			[selectedItem_ dragToPoint: touchLocation];
		}
	}
}
@end
