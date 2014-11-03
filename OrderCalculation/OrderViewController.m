//
//  OrderViewController.m
//  OrderCalculation
//
//  Created by Ravikanth Muthavarapu on 10/10/14.
//  Copyright (c) 2014 Ravikanth Muthavarapu. All rights reserved.
//

#import "OrderViewController.h"
#import "DatabaseClass.h"
@interface OrderViewController ()

@end

@implementation OrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [DatabaseClass sharedInstance];
    [[DatabaseClass alloc] getAllValues:@"hello"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
