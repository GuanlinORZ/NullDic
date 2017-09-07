//
//  NSMutableArray+LYNil.m
//  NSArray+nil
//
//  Created by gly on 2017/5/2.
//  Copyright © 2017年 gly. All rights reserved.
//

#import "NSMutableArray+LYNil.h"
#import <objc/runtime.h>

@implementation NSMutableArray (LYNil)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class arrCls = NSClassFromString(@"__NSArrayM");
        //查
        Method original = class_getInstanceMethod(arrCls, @selector(objectAtIndex:));
        Method replace = class_getInstanceMethod(arrCls, @selector(ly_swizzing_objectAtIndexM:));
        method_exchangeImplementations(original, replace);
        //增
        Method original1 = class_getInstanceMethod(arrCls, @selector(insertObject:atIndex:));
        Method replace1 = class_getInstanceMethod(arrCls, @selector(ly_swizzing_insertObjectM:atIndex:));
        method_exchangeImplementations(original1, replace1);
        //增
        Method original2 = class_getInstanceMethod(arrCls, @selector(setObject:atIndex:));
        Method replace2 = class_getInstanceMethod(arrCls, @selector(ly_swizzing_setObjectM:atIndex:));
        method_exchangeImplementations(original2, replace2);
        //增
        Method original3 = class_getInstanceMethod(arrCls, @selector(setObject:atIndexedSubscript:));
        Method replace3 = class_getInstanceMethod(arrCls, @selector(ly_swizzing_setObjectM:atIndexedSubscript:));
        method_exchangeImplementations(original3, replace3);
        //删
        Method original4 = class_getInstanceMethod(arrCls, @selector(removeObjectsInRange:));
        Method replace4 = class_getInstanceMethod(arrCls, @selector(ly_swizzing_removeObjectsInRange:));
        method_exchangeImplementations(original4, replace4);
        //改
        Method original5 = class_getInstanceMethod(arrCls, @selector(replaceObjectAtIndex:withObject:));
        Method replace5 = class_getInstanceMethod(arrCls, @selector(ly_swizzing_replaceObjectAtIndex:withObject:));
        method_exchangeImplementations(original5, replace5);
        
    });
}

//查
- (id)ly_swizzing_objectAtIndexM:(NSUInteger)index {
    if (!self.count || self.count == 0) {
        NSLog(@"%s\n%@",__func__,@"数组为空");
        return nil;
    }
    else if (self.count-1 < index){
        NSLog(@"%s\n%@",__func__,@"数组越界了");
        return nil;
    }
    return [self ly_swizzing_objectAtIndexM:index];
}
//增
-(void)ly_swizzing_insertObjectM:(id)anObject atIndex:(NSUInteger)index{
    
    if (index == 0) {
        if (!anObject) {
            NSLog(@"不能为空");
            return;
        }
    }
    else{
        //因为是插入操作 所以在数组最后也可以插入
        if (index> self.count) {
            NSLog(@"%s\n%@",__func__,@"数组越界了");
            return;
        }
        if (!anObject) {
            NSLog(@"不能为空");
            return;
        }
    }
    [self ly_swizzing_insertObjectM:anObject atIndex:index];
}
//增
-(void)ly_swizzing_setObjectM:(id)anObject atIndex:(NSUInteger)index{
    
    if (!anObject) {
        NSLog(@"不能为空");
        return;
    }
    //可以在最末位增加
    if (index>self.count) {
        NSLog(@"%s\n%@",__func__,@"数组越界了");
        return;
    }
    [self ly_swizzing_setObjectM:anObject atIndex:index];
}
//增
-(void)ly_swizzing_setObjectM:(id)anObject atIndexedSubscript:(NSUInteger)index{
    if (!anObject) {
        NSLog(@"不能为空");
        return;
    }
    //可以在最末位增加
    if (index>self.count) {
        NSLog(@"%s\n%@",__func__,@"数组越界了");
        return;
    }
    [self ly_swizzing_setObjectM:anObject atIndexedSubscript:index];
}
//删
-(void)ly_swizzing_removeObjectsInRange:(NSRange)range{
    if (range.location>self.count) {
        NSLog(@"%s\n%@",__func__,@"数组越界了");
        return;
    }
    
    if ((range.location + range.length)>self.count) {
        NSLog(@"%s\n%@",__func__,@"数组越界了");
        return;
    }
    [self ly_swizzing_removeObjectsInRange:range];
}
//改
- (void)ly_swizzing_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject{
    if (!self.count || self.count==0) {
        NSLog(@"%s\n%@",__func__,@"数组为空");
        return;
    }
    if (index>=self.count) {
        NSLog(@"%s\n%@",__func__,@"数组越界了");
        return;
    }
    if (!anObject) {
        NSLog(@"不能为空");
        return;
    }
    [self ly_swizzing_replaceObjectAtIndex:index withObject:anObject];
}

@end
