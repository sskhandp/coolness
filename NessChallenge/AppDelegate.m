//
//  AppDelegate.m
//  NessChallenge
//
//  Created by Sundeep Khandpur on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "BlockMappingClass.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  BlockMappingClass *blockMappingClass = [[BlockMappingClass alloc] init];
  [blockMappingClass setInputArray:[NSArray arrayWithObjects:[NSNumber numberWithInt:1],
                                    [NSNumber numberWithInt:5],
                                    [NSNumber numberWithInt:2],
                                    [NSNumber numberWithInt:20],
                                    [NSNumber numberWithInt:50],
                                    [NSNumber numberWithInt:-1],
                                    nil]];

  [blockMappingClass setTrasnsformBlock:(id) ^(id input) {
    NSLog(@"Mapping...%@", input);

    NSNumber *number = [NSNumber numberWithInt: [(NSNumber*)input intValue] * 2];
    return number;
  }];

  NSDictionary *mappedResult = [blockMappingClass mapAndReturnResult];
  for (id key in mappedResult) {
    NSLog(@"[%@, %@]", key, [mappedResult objectForKey:key]);
  }
}

@end
