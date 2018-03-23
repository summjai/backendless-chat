//
//  ThemesViewController.m
//  TinkoffChat
//
//  Created by Anastasia Chuikina on 23/03/2018.
//  Copyright © 2018 Anastasia Chuikina. All rights reserved.
//

#import "ThemesViewController.h"

@interface ThemesViewController ()

@end

@implementation ThemesViewController

- (IBAction)chooseThemeOne:(UIButton *)sender {
    self.view.backgroundColor = _model.theme1;
    [_delegate themesViewController:self didSelectTheme:_model.theme1];
}
- (IBAction)chooseThemeTwo:(UIButton *)sender {
    self.view.backgroundColor = _model.theme2;
    [_delegate themesViewController:self didSelectTheme:_model.theme2];
}
- (IBAction)chooseThemeThree:(UIButton *)sender {
    self.view.backgroundColor = _model.theme3;
    [_delegate themesViewController:self didSelectTheme:_model.theme3];
}
- (IBAction)dismiss:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc
{
    [_delegate release];
    [_model release];
    [super dealloc];
}

@end
