//
//  DaysSinceShared.m
//  DaysSince
//
//  Created by Sam Cole on 3/14/15.
//
//

#import <Foundation/Foundation.h>
#import "DaysSinceShared.h"

NSURL *applicationDocumentsDirectory() {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}