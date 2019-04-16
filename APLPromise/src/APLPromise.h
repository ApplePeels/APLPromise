//
//  APLPromise.h
//  APLPromise
//
//  Created by wangxingming on 2019/4/16.
//  Copyright © 2019 wangxingming. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^APLPromiseResult)(id);

@interface APLPromise : NSObject

+ (void)async:(void(^)(APLPromise* promise))block;

- (id)await:(void(^)(APLPromiseResult result))block;

@end

NS_ASSUME_NONNULL_END
