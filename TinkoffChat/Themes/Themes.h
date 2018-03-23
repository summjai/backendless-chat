//
//  Themes.h
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 23/03/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Themes : NSObject
@property (retain) UIColor* theme1;
@property (retain) UIColor* theme2;
@property (retain) UIColor* theme3;
- (id)initWithColors:(UIColor *)color1 color2:(UIColor *)color2 color3:(UIColor *)color3;
@end
