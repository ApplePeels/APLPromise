# Example

##调用方式

```
__block NSInteger index = 0;
[APLPromise async:^(APLPromise* _Nonnull promise){
    NSInteger value = [[promise await:[self testWithFunction]] integerValue];
    NSLog(@"value %ld", value);
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
2019-04-16 10:15:30.257247+0800 APLPromise[8652:276248] value 100
2019-04-16 10:15:32.454697+0800 APLPromise[8652:276248] ret1 1
2019-04-16 10:15:34.509360+0800 APLPromise[8652:276248] ret2 2
2019-04-16 10:15:34.509472+0800 APLPromise[8652:276248] index:2

```