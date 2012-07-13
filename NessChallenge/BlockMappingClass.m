//
//  TestClass.m
//  NessChallenge
//
//  Created by Sundeep Khandpur on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BlockMappingClass.h"

@implementation BlockMappingClass {
  TransformBlock _transformBlock;
  NSArray *_inputArray;
}

-(void) setTrasnsformBlock:(TransformBlock) transformBlock {
  NSAssert(transformBlock != nil, @"Cannot pass nil transformBlock");
  _transformBlock = transformBlock;
}

-(void) setInputArray:(NSArray*) inputArray {
  NSAssert(inputArray != nil, @"Cannot pass nil inputArray");
  _inputArray = inputArray;
}

-(NSDictionary*) mapAndReturnResult {
  NSMutableDictionary *mappedResults = [[NSMutableDictionary alloc] init];
  dispatch_queue_t mappingQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  dispatch_group_t group = dispatch_group_create();
  
  for (id key in _inputArray) {
    dispatch_group_async(group, mappingQueue, ^{
      @synchronized(mappedResults) {
        [mappedResults setObject:_transformBlock(key)
                          forKey:key];
      }
    });
  }
  dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
  
  // Release the group when it is no longer needed.
  dispatch_release(group);

  return mappedResults;
}

@end
