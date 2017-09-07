//
//  NSArray+LYNil.m
//  NSArray+nil
//
//  Created by gly on 2017/5/2.
//  Copyright © 2017年 gly. All rights reserved.
//

#import "NSArray+LYNil.h"
#import <objc/runtime.h>

@implementation NSArray (LYNil)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 取值
        Method original_get_1 = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
        Method replace_get_1 = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(ly_swizzing_objectAtIndexI:));
        method_exchangeImplementations(original_get_1, replace_get_1);
        
        Method original_get_2 = class_getInstanceMethod(objc_getClass("__NSArray0"), @selector(objectAtIndex:));
        Method replace_get_2 = class_getInstanceMethod(objc_getClass("__NSArray0"), @selector(ly_swizzing_objectAtIndex0:));
        method_exchangeImplementations(original_get_2, replace_get_2);
        
        Method original_get_3 = class_getInstanceMethod(objc_getClass("__NSSingleObjectArrayI"), @selector(objectAtIndex:));
        Method replace_get_3 = class_getInstanceMethod(objc_getClass("__NSSingleObjectArrayI"), @selector(ly_swizzing_objectAtIndexSingle:));
        method_exchangeImplementations(original_get_3, replace_get_3);
        
        Method original_get_4 = class_getInstanceMethod(objc_getClass("__NSPlaceholderArray"), @selector(objectAtIndex:));
        Method replace_get_4 = class_getInstanceMethod(objc_getClass("__NSPlaceholderArray"), @selector(ly_swizzing_objectAtIndexPlaceholder:));
        method_exchangeImplementations(original_get_4, replace_get_4);
        
        //赋值
        Method original_init_1 = class_getInstanceMethod(objc_getClass("__NSPlaceholderArray"), @selector(initWithObjects:count:));
        Method replace_init_1 = class_getInstanceMethod(objc_getClass("__NSPlaceholderArray"), @selector(ly_swizzing_initWithObjects:count:));
        method_exchangeImplementations(original_init_1, replace_init_1);
        
        
    });
}

#pragma mark objectAtIndex:
//__NSArrayI
- (id)ly_swizzing_objectAtIndexI:(NSUInteger)index {
    
    if (![self judgeArrayIndex:index]) {
        return nil;
    }
    return [self ly_swizzing_objectAtIndexI:index];
}
//__NSArray0
- (id)ly_swizzing_objectAtIndex0:(NSUInteger)index {
    
    if (![self judgeArrayIndex:index]) {
        return nil;
    }
    return [self ly_swizzing_objectAtIndex0:index];
}
//__NSSingleObjectArrayI
- (id)ly_swizzing_objectAtIndexSingle:(NSUInteger)index {
    
    if (![self judgeArrayIndex:index]) {
        return nil;
    }
    return [self ly_swizzing_objectAtIndexSingle:index];
}
//__NSPlaceholderArray
- (id)ly_swizzing_objectAtIndexPlaceholder:(NSUInteger)index {
    NSLog(@"%s\n%s\n%@",class_getName(self.class),__func__,@"数组未初始化");
    return nil;
}
-(BOOL)judgeArrayIndex:(NSUInteger)index{
    
    if (!self.count || self.count == 0) {
        NSLog(@"%s\n%s\n%@",class_getName(self.class),__func__,@"数组为空");
        return NO;
    }
    else if (self.count-1 < index){
        NSLog(@"%s\n%s\n%@",class_getName(self.class),__func__,@"数组越界了");
        return NO;
    }
    return YES;
}

#pragma mark initWithObjects:count:
- (id)ly_swizzing_initWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt{
    for (int i = 0 ; i<cnt ; i++) {
        if (objects[i] == nil) {
            NSLog(@"数组第%d个参数为空",i);
            return nil;
        }
    }
    return [self ly_swizzing_initWithObjects:objects count:cnt];
}
@end
