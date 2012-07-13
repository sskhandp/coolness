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
  dispatch_queue_t mappingQueue = dispatch_queue_create("ness.challenge.queue",
                                                        DISPATCH_QUEUE_CONCURRENT);

  for (id key in _inputArray) {
    dispatch_async(mappingQueue, ^{
      [mappedResults setObject:_transformBlock(key)
                        forKey:key];
    });
  }
  dispatch_barrier_sync(mappingQueue, ^{
    NSLog(@"Barrier executed");
    // no-op barrier block to wait until all the keys are mapped.
  });

  dispatch_release(mappingQueue);

  return mappedResults;
}

@end
