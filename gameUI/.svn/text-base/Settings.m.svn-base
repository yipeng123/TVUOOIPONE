//
//  Settings.m
//  gameUI
//
//  Created by xubo on 6/25 星期三.
//  Copyright (c) 2014年 yibin chen. All rights reserved.
//

#import "Settings.h"

@implementation Settings

@synthesize fileName;
- (Settings*) init
{
    if(self = [super init])
    {
        return self;
    }
    return nil;
}


- (NSArray*) readFromLocalFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSMutableString *documentDirectory = [paths objectAtIndex:0];

    
    NSArray *array2 = [documentDirectory componentsSeparatedByString:@"/" ];
    NSMutableString *str = [[[NSMutableString alloc] initWithCapacity:10 ] autorelease];
    for(int i=0; i<[array2 count]-1; ++i)
    {
        [str appendString:@"/"];
        [str appendString:[array2 objectAtIndex:i]];
    }

    NSString *filePath = [str stringByAppendingPathComponent:@"settings.plist"];
    
    

    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSArray *array = [[[NSArray alloc] initWithContentsOfFile:filePath] autorelease];
        return array;
    }
    else
    {
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                      message:@"选项文件加载失败！"
                                                     delegate:nil
                                            cancelButtonTitle:@"确定"
                                            otherButtonTitles:nil];
        [alert show];
        [alert release];
        return nil;
    }    
                                        
}


- (void) writeToLocalFile
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSMutableString *documentDirectory = [paths objectAtIndex:0];
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:3];
    [array addObject:[NSNumber numberWithBool:[Singleton getInstance].sound_flag]];
    [array addObject:[NSNumber numberWithBool:[Singleton getInstance].vibrate_flag]];
    [array addObject:[NSNumber numberWithBool:[Singleton getInstance].frame_flag]];
    
    NSArray *array2 = [documentDirectory componentsSeparatedByString:@"/" ];
    NSMutableString *str = [[[NSMutableString alloc] initWithCapacity:10 ] autorelease];
    for(int i=0; i<[array2 count]-1; ++i)
    {
        [str appendString:@"/"];
        [str appendString:[array2 objectAtIndex:i]];
    }
    NSString *file = [str stringByAppendingPathComponent:@"settings.plist"];
    [array writeToFile:file atomically:YES];
}



- (void) writeToLocalFile2
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSMutableString *documentDirectory = [paths objectAtIndex:0];

    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:2];
    [array addObject:[NSNumber numberWithBool:[Singleton getInstance].sound_flag2]];
    [array addObject:[NSNumber numberWithBool:[Singleton getInstance].vibrate_flag2]];
    
    
    NSArray *array2 = [documentDirectory componentsSeparatedByString:@"/" ];
    NSMutableString *str = [[[NSMutableString alloc] initWithCapacity:10 ] autorelease];
    for(int i=0; i<[array2 count]-1; ++i)
    {
        [str appendString:@"/"];
        [str appendString:[array2 objectAtIndex:i]];
    }
    NSString *file = [str stringByAppendingPathComponent:@"settings2.plist"];
    [array writeToFile:file atomically:YES];  
}


- (NSArray*) readFromLocalFile2
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSMutableString *documentDirectory = [paths objectAtIndex:0];
    
    
    NSArray *array2 = [documentDirectory componentsSeparatedByString:@"/" ];
    NSMutableString *str = [[[NSMutableString alloc] initWithCapacity:10 ] autorelease];
    for(int i=0; i<[array2 count]-1; ++i)
    {
        [str appendString:@"/"];
        [str appendString:[array2 objectAtIndex:i]];
    }
    
    NSString *filePath = [str stringByAppendingPathComponent:@"settings2.plist"];
    
    
    
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
        return array;
    }
    else
    {
        UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                      message:@"选项文件加载失败！"
                                                     delegate:nil
                                            cancelButtonTitle:@"确定"
                                            otherButtonTitles:nil];
        [alert show];
        [alert release];
        return nil;
    }
}

@end
