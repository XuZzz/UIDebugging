//
//  UIColor+ChangeColor.h
//  UIDebugging
//
//  Created by Xu on 2020/10/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ChangeColor)
/**
 *  带#号的十六进制颜色转换
 *
 *  @param color 带#号的颜色字符串
 *
 *  @return 颜色
 */
+ (UIColor *)colorWithHexString: (NSString *)color;
@end

NS_ASSUME_NONNULL_END
