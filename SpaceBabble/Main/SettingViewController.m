//
//  SettingViewController.m
//  SpaceBabble
//
//  Created by 郑南 on 16/7/23.
//  Copyright © 2016年 south. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
@property (strong, nonatomic) IBOutlet UISwitch *SwitchBgMusic;
@property (strong, nonatomic) IBOutlet UISwitch *SwitchSoundEffects;

@end

@implementation SettingViewController

@synthesize SwitchBgMusic,SwitchSoundEffects;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
   
    SwitchBgMusic.on = [self isBackgroundMusic];
    SwitchSoundEffects.on = [self isSoundEffects];
}
- (IBAction)actionSwich:(id)sender {
    UISwitch* swich = sender;
    BOOL state = swich.on;
    if (state) {
        NSLog(@"play");
        [self playWithSound:@"GameLoop"of:@"mp3"];
    }else {[self stopSound];NSLog(@"stop");}
}
- (IBAction)actionBtnSave:(id)sender {
    
    [[NSUserDefaults standardUserDefaults]setBool:SwitchBgMusic.on forKey:@"backgroundMusic"];
    [[NSUserDefaults standardUserDefaults]setBool:SwitchSoundEffects.on forKey:@"soundEffects"];
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
