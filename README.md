# Example

##调用方式

```
ASYNC_INSTANCE_METHOD(testWithFunction:(NSString*)value, {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        ASYNC_RESULT(value);
    });
})

__block NSInteger index = 0;
[APLPromise async:^(APLPromise* _Nonnull promise){
    NSString* value = [promise await:[self async_testWithFunction:@"testFunctionValue"]];
    NSLog(@"value %@", value);
    id ret1 = [promise await:^(APLPromiseResult result) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            index++;
            result(@(index));
        });
    }];
    NSLog(@"ret1 %@", ret1);
    id ret2 = [promise await:^(APLPromiseResult result) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            index++;
            result(@(index));
        });
    }];
    NSLog(@"ret2 %@", ret2);
    
    NSLog(@"index:%ld", index);
}];
```

##output
```
2019-04-16 10:15:30.257247+0800 APLPromise[8652:276248] value testFunctionValue
2019-04-16 10:15:32.454697+0800 APLPromise[8652:276248] ret1 1
2019-04-16 10:15:34.509360+0800 APLPromise[8652:276248] ret2 2
2019-04-16 10:15:34.509472+0800 APLPromise[8652:276248] index:2

```