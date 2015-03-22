//
//  ViewController.m
//  DaysSince
//
//  Created by Sam Cole on 3/9/15.
//  Copyright (c) 2015 Sam Cole.
//

#import "ViewController.h"
#import "DaysSinceShared.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)reset {
    self.startTime = [NSDate date];
    NSLog(@"Start time set to %@", self.startTime);
    [self refresh];
    [self saveCounterData];
}

- (void)refresh {
    
    // # seconds since startTime
    NSInteger timeElapsed = [[NSDate date] timeIntervalSinceDate:self.startTime];
    NSLog(@"%ld seconds since start time", (long)timeElapsed);
#ifndef DEBUG
    // Convert to days
    timeElapsed /= (60 * 60 * 24);
#endif
    [self.counterLabel setText:[NSString stringWithFormat:@"%ld", (long)timeElapsed]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
#ifdef DEBUG
    [self.timeSinceLabel setText:@"seconds since"];
#else
    self.refreshButton.hidden = YES;
#endif
    
    self.counterPath = pathToStoredCounter(self.counterIndex);
    if([[NSFileManager defaultManager] fileExistsAtPath:self.counterPath]) {
        
        NSLog(@"Loading counter from file %@", self.counterPath);
        Counter *counter = [NSKeyedUnarchiver unarchiveObjectWithFile:self.counterPath];
        self.eventTextField.text = counter.event;
        self.startTime = counter.startTime;
        NSLog(@"Counter successfully loaded");
        [self refresh];
        
    }
    else
        [self reset];
    
    // This is the most recent view to load, so save its index in currentView
    NSNumber *currentView = [NSNumber numberWithInteger:self.counterIndex];
    NSError *error = nil;
    
    NSData *currentViewData = [NSKeyedArchiver archivedDataWithRootObject:currentView];
    
    BOOL success = [currentViewData writeToFile:pathToCurrentViewIndex() options:NSDataWritingFileProtectionNone error:&error];
    
    if(success)
        NSLog(@"Successfully wrote counter index %ld to file %@", (long)self.counterIndex, pathToCurrentViewIndex());
    
    
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

- (IBAction)eventEdited:(id)sender {
    NSLog(@"Event updated to \"%@\"", self.eventTextField.text);
    [self saveCounterData];
}

- (IBAction)plusButtonPushed:(id)sender {
    NSLog(@"+ button pushed");
    
}

- (BOOL)saveCounterData {
    
    Counter *counter = [[Counter alloc] initWithStartTime:[self startTime] event:self.eventTextField.text];
    NSError *error = nil;
    
    NSData *counterData = [NSKeyedArchiver archivedDataWithRootObject:counter];
    
    BOOL success = [counterData writeToFile:self.counterPath options:NSDataWritingFileProtectionNone error:&error];
    
    if(success)
        NSLog(@"Successfully wrote counter data to file %@", self.counterPath);

    
    return success;
}

@end
