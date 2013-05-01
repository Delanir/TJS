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

NSString * pathForFile(NSString *filename)
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask,
                                                         YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:filename];
}

id loadData(NSString * filename)
{
    NSString *filePath = pathForFile(filename);
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
       NSData *data = [[[NSData alloc] initWithContentsOfFile:filePath] autorelease];
        
        NSKeyedUnarchiver *unarchiver = [[[NSKeyedUnarchiver alloc] initForReadingWithData:data] autorelease];
        
        id retval = [unarchiver decodeObjectForKey:@"Data"];
        [unarchiver finishDecoding];
        return retval;
    }
    
    return nil;
}

void saveData(id theData, NSString *filename)
{
    NSMutableData *data = [[[NSMutableData alloc] init] autorelease];
    NSKeyedArchiver *archiver = [[[NSKeyedArchiver alloc] initForWritingWithMutableData:data] autorelease];
    
    [archiver encodeObject:theData forKey:@"Data"];
    [archiver finishEncoding];
    [data writeToFile:pathForFile(filename) atomically:YES];
}


+(int)getRandomNumberBetween:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}

@end
