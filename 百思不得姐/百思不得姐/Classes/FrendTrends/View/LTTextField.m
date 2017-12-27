//
//  LTTextField.m
//  百思不得姐
//
//  Created by Sunallies on 2017/12/23.
//  Copyright © 2017年 helen. All rights reserved.
//

#import "LTTextField.h"
#include <objc/runtime.h>
//static NSString * const LTPlaceholderColorKeyPath = @"_placeholderLabel.textColor";
@implementation LTTextField

- (void)awakeFromNib{
    [super awakeFromNib];
    //[self getIvars];
    //[self getAllProperties];
    self.tintColor = self.textColor;
    [self resignFirstResponder];
}

- (BOOL)becomeFirstResponder{
    
    UILabel *label = [self valueForKeyPath:@"_placeholderLabel"];
    label.textColor = self.textColor;
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder{
    UILabel *label = [self valueForKey:@"_placeholderLabel"];
    label.textColor = [UIColor grayColor];
    //[self setValue:[UIColor grayColor] forKey:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}
- (void)getIvars{
  unsigned int count = 0;
  Ivar * ivars = class_copyIvarList([UITextField class], &count);
  for (int i = 0; i< count; i++ ) {
     Ivar ivar = ivars[i];
     NSLog(@"ivar------%s",ivar_getName(ivar));
    }
}
    
//Ivar *ivars = class_copyProtocolList([UITextField class], &count);

    
- (void)getAllProperties{
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([UITextField class], &count);
    for (int i = 0; i<count; i++) {
        objc_property_t pros = properties[i];
        NSLog(@"property------%s",property_getName(pros));
    }
}
@end
