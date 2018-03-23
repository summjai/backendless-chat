//
//  ThemesViewController.h
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 23/03/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Themes.h"

@class ThemesViewController;

@protocol ThemesViewControllerDelegate<NSObject>
 - (void)themesViewController:(ThemesViewController*)controller didSelectTheme:(UIColor*)selectedTheme;
@end

@interface ThemesViewController : UIViewController

@property (retain) id<ThemesViewControllerDelegate> delegate;
@property (retain) Themes* model;

@end
