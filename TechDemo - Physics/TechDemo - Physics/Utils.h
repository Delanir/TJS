//
//  Utils.h
//  L'Archer
//
//  Created by jp on 19/04/13.
//
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+(BOOL)iPadRetina;
+(NSDictionary *) openPlist: (NSString *) plist;
id loadData(NSString * filename);
void saveData(id theData, NSString *filename);

@end
