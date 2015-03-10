//
//  ViewController.m
//  DaysSince
//
//  Created by Sam Cole on 3/9/15.
//  Copyright (c) 2015 Sam Cole.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)reset {
    self.startTime = [NSDate date];
    NSLog(@"Start time set to %@", self.startTime);
    [self refresh];
}

- (void)refresh {
    
    // # seconds since startTime
    int timeElapsed = [[NSDate date] timeIntervalSinceDate:self.startTime];
    NSLog(@"%d seconds since start time", timeElapsed);
#ifndef DEBUG
    // Convert to days
    timeElapsed /= (60 * 60 * 24);
#endif
    [self.counter setText:[NSString stringWithFormat:@"%d", timeElapsed]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
#ifdef DEBUG
    NSLog(@"Debug mode");
    [self.timeSinceLabel setText:@"seconds since"];
#else
    self.refreshButton.hidden = YES;
#endif
    [self reset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetButtonPushed:(id)sender {
    NSLog(@"Reset button pushed");
    [self reset];
}

- (IBAction)refreshButtonPushed:(id)sender {
    NSLog(@"Refresh button pushed");
    [self refresh];
}
@end
