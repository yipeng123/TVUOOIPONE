//
//  Press.h
//  ParseJSON
//
//  Created by xubo on 5/30 星期五.
//  Copyright (c) 2014年 xubo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyBean : NSObject

{
    NSNumber *left_x;
    NSString *bar_style;
    NSString *key_id;
    NSString *key_sound;
    NSNumber *key_type;
    NSNumber *keys;
    NSString *name;
    NSNumber *show_bar;
    NSString *style;
    NSString *tv_x;
    NSString *tv_y;
    NSNumber *x;
    NSNumber *y;
    NSString *text;
}
@property (retain, nonatomic)  NSNumber *left_x;
@property (retain, nonatomic)  NSString *bar_style;
@property (retain, nonatomic)  NSString *key_id;
@property (retain, nonatomic)  NSString *key_sound;
@property (retain, nonatomic)  NSNumber *key_type;
@property (retain, nonatomic)  NSNumber *keys;
@property (retain, nonatomic)  NSString *name;
@property (retain, nonatomic)  NSNumber *show_bar;
@property (retain, nonatomic)  NSString *style;
@property (retain, nonatomic)  NSString *tv_x;
@property (retain, nonatomic)  NSString *tv_y;
@property (retain, nonatomic)  NSNumber *x;
@property (retain, nonatomic)  NSNumber *y;
@property (retain, nonatomic)  NSString *text;
- (KeyBean*) init;

@end
