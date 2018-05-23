//
//  ViewController.m
//  Demo_OC
//
//  Created by DaiLingchi on 2018/5/23.
//  Copyright © 2018年 DiorStone. All rights reserved.
//

#import <DSTransition/DSTransition.h>
#import "ViewController.h"
#import "ViewController1.h"

@interface ViewController ()

@property (nonatomic, strong) BocoPresenter *presenter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [BocoPresenter new];
    self.presenter.backgroundColor = [UIColor yellowColor];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)tapAction:(id)sender
{
    [self.presenter presentViewControllerWithPresentingViewController:self presentedViewController:[ViewController1 new] animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
