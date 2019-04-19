//
//  APLPromiseDefs.h
//  APLPromise
//
//  Created by wangxingming on 2019/4/19.
//  Copyright © 2019 wangxingming. All rights reserved.
//

#ifndef APLPromiseDefs_h
#define APLPromiseDefs_h

//定义async函数
#define ASYNC_RESULT(value)   result(value)

#define ASYNC_CLASS_METHOD(name, function)  ASYNC_METHOD(+, name, function)
#define ASYNC_INSTANCE_METHOD(name, function)   ASYNC_METHOD(-, name, function)

#define ASYNC_METHOD(qualifier, name, function)    \
qualifier (void(^)(APLPromiseResult))async_##name {\
    return ^(APLPromiseResult result) {\
        function    \
    };  \
}\

#endif /* APLPromiseDefs_h */
