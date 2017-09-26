//
//  SJCirqueView.h
//  Pods
//
//  Created by SDPMobile on 2017/9/25.
//
//

#import <UIKit/UIKit.h>

@interface SJCirqueView : UIView
/**  背景圆环的颜色 **/
@property (nonatomic, strong) UIColor *bgCirqueColor;

/*
 *  创建圆环
 *  @param  frame    尺寸
 *  @param  durationTime    持续时间
 *  @param  strokeColor    颜色
 *  @param  lineWidth   线宽
 */
- (instancetype)initWithFrame:(CGRect)frame DurationTime:(CGFloat)durationTime StrokeColor:(UIColor *)strokeColor LineWith:(CGFloat)lineWidth;
@end
