//
//  Utils.m
//  L'Archer
//
//  Created by jp on 19/04/13.
//
//

#import "Utils.h"

@implementation Utils


+(BOOL)iPadRetina{
    return ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))?1:0;
}


+(NSDictionary *) openPlist: (NSString *) plist
{
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
    plistPath = [[NSBundle mainBundle] pathForResource:plist ofType:@"plist"];
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary * dict = (NSDictionary *)[NSPropertyListSerialization
                                           propertyListFromData:plistXML
                                           mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                           format:&format
                                           errorDescription:&errorDesc];
    if (!dict)
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    return dict;
    
}

@end
