//
//  Themes.m
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 23/03/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

#import "Themes.h"

@interface Themes ()

@end

@implementation Themes

@synthesize theme1 = _theme1;
@synthesize theme2 = _theme2;
@synthesize theme3 = _theme3;


- (id)initWithColors:(UIColor *)color1 color2:(UIColor *)color2 color3:(UIColor *)color3 {
    if ( self = [super init] ) {
        [self setTheme1:color1 ];
        [self setTheme2:color2 ];
        [self setTheme3:color3 ];

        return self;
    }
    return nil;
}

- (UIColor* )theme1 {
    return _theme1;
}

- (UIColor* )theme2 {
    return _theme2;
}

- (UIColor* )theme3 {
    return _theme3;
}

- (void) setTheme1: (UIColor *) theme {
    _theme1 = theme;
}

- (void) setTheme2: (UIColor *) theme {
    _theme2 = theme;
}

- (void) setTheme3: (UIColor *) theme {
    _theme3 = theme;
}

@end
