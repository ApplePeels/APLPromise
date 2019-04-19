//
//  APLPromiseDefs.h
//  APLPromise
//
//  Created by wangxingming on 2019/4/19.
//  Copyright © 2019 wangxingming. All rights reserved.
//

#ifndef APLPromiseDefs_h
#define APLPromiseDefs_h

//async函数内返回值
#define ASYNC_RESULT(value)   result(value)

//定义async函数(类方法、实例方法)
#define ASYNC_CLASS_METHOD(name, function)  ASYNC_METHOD(+, name, function)
#define ASYNC_INSTANCE_METHOD(name, function)   ASYNC_METHOD(-, name, function)

#define ASYNC_METHOD(qualifier, name, function)    \
qualifier (void(^)(APLPromiseResult))async_##name {\
    return ^(APLPromiseResult result) {\
        function    \
    };  \
}\

/* Example
ASYNC_INSTANCE_METHOD(testWithFunction:(NSString*)value, {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ASYNC_RESULT(value);
    });
})
 
[self async_testWithFunction:@"testFunctionValue"]];
*/

#endif /* APLPromiseDefs_h */
