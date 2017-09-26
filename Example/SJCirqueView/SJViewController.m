//
//  SJViewController.m
//  SJCirqueView
//
//  Created by superzhaolong@126.com on 09/25/2017.
//  Copyright (c) 2017 superzhaolong@126.com. All rights reserved.
//

#import "SJViewController.h"
#import <SJCirqueView/SJCirqueView.h>

@interface SJViewController ()
@property (nonatomic, strong) SJCirqueView *cirqueView;
@end

@implementation SJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _cirqueView = [[SJCirqueView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)
                                         DurationTime:20.0f
                                          StrokeColor:[UIColor blueColor]
                                             LineWith:8.0f
                   ];
    
    [self.view addSubview:_cirqueView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
