//
//  MainViewController.m
//  SpaceBabble
//
//  Created by 郑南 on 16/7/23.
//  Copyright © 2016年 south. All rights reserved.
//

#import "MainViewController.h"
#import "SettingViewController.h"
#import "SpaceBabbleViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
}
- (IBAction)actionBtnSetting:(id)sender {
    [self performSegueWithIdentifier:@"MainToSetting" sender:nil];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self performSegueWithIdentifier:@"MainToSpace" sender:nil];
}
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//
//}

@end
