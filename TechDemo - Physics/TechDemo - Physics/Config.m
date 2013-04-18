//
//  Config.m
//  TechDemo - Physics
//
//  Created by jp on 02/04/13.
//
//

#import "Config.h"

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
	self = [super init];
	if (self != nil)
    {
        NSString *errorDesc = nil;
        NSPropertyListFormat format;
        NSString *plistPath;
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                  NSUserDomainMask, YES) objectAtIndex:0];
        plistPath = [rootPath stringByAppendingPathComponent:@"Config.plist"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
        {
            plistPath = [[NSBundle mainBundle] pathForResource:@"Config" ofType:@"plist"];
        }
        NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
        data = (NSDictionary *)[NSPropertyListSerialization
                                              propertyListFromData:plistXML
                                              mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                              format:&format
                                              errorDescription:&errorDesc];
        if (!data)
            NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
        else
            [data retain];
	}
    
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

+(BOOL)iPadRetina{
    return ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))?1:0;
}


@end