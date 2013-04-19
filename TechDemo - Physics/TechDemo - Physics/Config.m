//
//  Config.m
//  TechDemo - Physics
//
//  Created by jp on 02/04/13.
//
//

#import "Config.h"
#import "Utils.h"

@implementation Config

static Config* _sharedSingleton = nil;

+(Config*)shared
{
	@synchronized([Config class])
	{
		if (!_sharedSingleton)
			[[self alloc] init];
    
		return _sharedSingleton;
	}
    
	return nil;
}

+(id)alloc
{
	@synchronized([Config class])
	{
		NSAssert(_sharedSingleton == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedSingleton = [super alloc];
		return _sharedSingleton;
	}
    
	return nil;
}

-(void)dealloc
{
    //Dealloc stuff above this line
    [_sharedSingleton release];
    [data release];
    [super dealloc];
}


-(void)dummyMethod
{
    return;
}

-(id)init
{
	if(self = [super init]);
        data = [[Utils openPlist:@"Config"] retain];
    
	return self;
}

-(NSString*)getStringProperty:(NSString*) key;
{
    return [data objectForKey:key];
}

-(int)getIntProperty:(NSString*) key;
{
    NSNumber* temp = [data objectForKey:key];
    return [temp intValue];
}

-(NSNumber*) getNumberProperty:(NSString *)key
{
    return [data objectForKey:key];
}

-(NSArray*) getArrayProperty:(NSString *)key
{
    return [data objectForKey:key];
}



@end