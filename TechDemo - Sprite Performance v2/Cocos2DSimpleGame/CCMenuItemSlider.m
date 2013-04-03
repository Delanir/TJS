//
//  CCMenuItemSlider.m
//  TechDemo - Sprites
//
//  Created by MiniclipMacBook on 4/2/13.
//  Copyright 2013 TJS. All rights reserved.
//

#import "CCMenuItemSlider.h"


//
// MenuItemSlider
//
@implementation CCMenuItemSlider

@synthesize minValue=minValue_, maxValue=maxValue_, value=value_;
@synthesize trackImage=trackImage_, knobImage=knobImage_;

+(id) itemFromTrackImage: (NSString*)value knobImage:(NSString*) value2
{
	return [[[self alloc] initFromTrackImage:value knobImage:value2 target:nil selector:nil] autorelease];
}

+(id) itemFromTrackImage: (NSString*)value knobImage:(NSString*) value2 target:(id) t selector:(SEL) s
{
	return [[[self alloc] initFromTrackImage:value knobImage:value2 target: t selector: s] autorelease];
}

-(id) initFromTrackImage: (NSString *)trkImage
			   knobImage: (NSString *)knbImage
				  target: (id)target
				selector: (SEL)selector
{
	if( (self=[super initWithTarget:target selector:selector]) ) {
		self.trackImage		= [CCSprite spriteWithFile: trkImage];
		self.knobImage		= [CCSprite spriteWithFile: knbImage];
        
		// Content size of the track is our reference
		// Knob must lie within
		[self setContentSize: trackImage_.contentSize];
		[self addChild: knobImage_ z:2];
        
		isVertical	= (self.contentSize.height > self.contentSize.width);
		self.minValue	= 0.0f;
		self.maxValue	= 100.0f;
		self.value	= 50.0f;
	}
	return self;
}

- (void)setValue: (float)aValue
{
	float	valueRatio;
    
	if (isVertical)
		valueRatio	= (self.contentSize.height - knobImage_.contentSize.height) / (maxValue_ - minValue_);
	else
		valueRatio	= (self.contentSize.width - knobImage_.contentSize.width) / (maxValue_ - minValue_);
    
	if (aValue < minValue_)
		value_	= minValue_;
	else if (aValue > maxValue_)
		value_	= maxValue_;
	else
		value_	= aValue;
    
	if (isVertical)
		knobImage_.position	= CGPointMake(self.contentSize.width / 2,
                                          (value_ - minValue_) * valueRatio + knobImage_.contentSize.height / 2);
	else
		knobImage_.position	= CGPointMake((value_ - minValue_) * valueRatio + knobImage_.contentSize.width / 2,
                                          self.contentSize.height / 2);
}

- (void)draw
{
	[trackImage_ draw];
}

-(void) dragToPoint: (CGPoint)aPoint
{
	float	valueRatio;
	float	absValue;
    
	if (isVertical) {
		valueRatio	= (maxValue_ - minValue_) / (self.contentSize.height - knobImage_.contentSize.height);
		absValue	= aPoint.y - knobImage_.contentSize.height / 2;
	} else {
		valueRatio	= (maxValue_ - minValue_) / (self.contentSize.width - knobImage_.contentSize.width);
		absValue	= aPoint.x - knobImage_.contentSize.width / 2;
	}
    
	self.value	= minValue_ + absValue * valueRatio;
    
	[self activate];
}

#pragma mark CCMenuItemSlider - CCRGBAProtocol protocol
- (void) setOpacity: (GLubyte)opacity
{
	[trackImage_ setOpacity:opacity];
	[knobImage_ setOpacity:opacity];
}

-(void) setColor:(ccColor3B)color
{
	[trackImage_ setColor:color];
	[knobImage_ setColor:color];
}

-(GLubyte) opacity
{
	return [trackImage_ opacity];
}

-(ccColor3B) color
{
	return [trackImage_ color];
}

@end
