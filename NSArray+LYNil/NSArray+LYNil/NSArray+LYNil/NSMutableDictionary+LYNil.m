//
//  NSMutableDictionary+LYNil.m
//  NSArray+nil
//
//  Created by gly on 2017/5/2.
//  Copyright © 2017年 gly. All rights reserved.
//

#import "NSMutableDictionary+LYNil.h"
#import <objc/runtime.h>

@implementation NSMutableDictionary (LYNil)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class dictCls = NSClassFromString(@"__NSDictionaryM");
        Method original = class_getInstanceMethod(dictCls, @selector(setObject:forKey:));
        Method replace = class_getInstanceMethod(dictCls, @selector(ly_swizzing_setObject:forKey:));
        method_exchangeImplementations(original, replace);
        
        //删
        Method original1 = class_getInstanceMethod(dictCls, @selector(removeObjectForKey:));
        Method replace1 = class_getInstanceMethod(dictCls, @selector(ly_swizzing_removeObjectForKey:));
        method_exchangeImplementations(original1, replace1);
        
    });
}
-(void)ly_swizzing_setObject:(id)aObject forKey:(id<NSCopying>)akey{
    
    if (!aObject) {
        NSLog(@"object is null");
        return;
    }
    if (!akey) {
        NSLog(@"key is null");
        return;
    }
    [self ly_swizzing_setObject:aObject forKey:akey];
}
-(void)ly_swizzing_removeObjectForKey:(id)akey{
    if (!akey) {
        NSLog(@"key is null");
        return;
    }
    [self ly_swizzing_removeObjectForKey:akey];
}

@end
