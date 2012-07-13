//
//  TestClass.h
//  NessChallenge
//
//  Created by Sundeep Khandpur on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id(^TransformBlock)(id);

@interface BlockMappingClass : NSObject

-(void) setTrasnsformBlock:(TransformBlock) transformBlock;
-(void) setInputArray:(NSArray*) inputArray;
-(NSDictionary*) mapAndReturnResult;

@end
