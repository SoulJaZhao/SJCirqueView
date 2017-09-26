//
//  SJCirqueView.m
//  Pods
//
//  Created by SDPMobile on 2017/9/25.
//
//

#import "SJCirqueView.h"

@interface SJCirqueView ()
/**  创建背景shapeLayer **/
@property (nonatomic, strong) CAShapeLayer *bgShapeLayer;
/**  圆心坐标 **/
@property (nonatomic, assign) CGPoint centerPoint;
/**  半径 **/
@property (nonatomic, assign) CGFloat cirqueRadius;
/**  圆环宽度 **/
@property (nonatomic, assign) CGFloat cirqueLineWidth;
/**  创建shapeLayer **/
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
/**  圆环颜色 **/
@property (nonatomic, strong) UIColor *strokeColor;
/**  设置起点弧度 **/
@property (nonatomic, assign) CGFloat startAngle;
/**  圆环路径 **/
@property (nonatomic, strong) UIBezierPath *cirquePath;
/**  定时器 **/
@property (nonatomic, strong) CADisplayLink *displayLink;
/**  定时时间 **/
@property (nonatomic, assign) CGFloat durationTime;
@end

@implementation SJCirqueView

#pragma mark - 生成圆环方法
- (instancetype)initWithFrame:(CGRect)frame DurationTime:(CGFloat)durationTime StrokeColor:(UIColor *)strokeColor LineWith:(CGFloat)lineWidth {
    self = [super initWithFrame:frame];
    if (self) {
        // 默认背景圆环的颜色
        _bgCirqueColor = [UIColor lightGrayColor];
        
        // 设置圆心坐标
        _centerPoint = self.center;
        
        // 圆环的半径
        _cirqueRadius = self.frame.size.width / 2;
        
        // 圆环宽度
        _cirqueLineWidth = lineWidth;
        
        // 圆环颜色
        _strokeColor = strokeColor;
        
        // 定时时间
        _durationTime = durationTime;
        
        // 生成背景圆环
        [self initBgCirque];
        
        // 生成动画圆环
        [self initCirque];
    }
    return self;
}

#pragma mark - 生成背景圆环
- (void)initBgCirque {
    // 创建shapeLayer
    _bgShapeLayer = [CAShapeLayer layer];
    
    // 创建贝塞尔曲线
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.center radius:_cirqueRadius startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];
    // 设置Layer
    _bgShapeLayer.lineWidth = _cirqueLineWidth;
    _bgShapeLayer.strokeColor = _bgCirqueColor.CGColor;
    _bgShapeLayer.fillColor = [UIColor clearColor].CGColor;
    _bgShapeLayer.fillMode = kCAFillModeForwards;
    // 设置Path
    _bgShapeLayer.path = path.CGPath;
    // 添加Layer
    [self.layer addSublayer:_bgShapeLayer];
}

#pragma mark - 设置背景圆环的颜色
- (void)setBgCirqueColor:(UIColor *)bgCirqueColor {
    _bgShapeLayer.strokeColor = bgCirqueColor.CGColor;
}

#pragma mark - 生成动画圆环
- (void)initCirque {
    // 创建shapeLayer
    _shapeLayer = [CAShapeLayer layer];
    
    // 设置Layer
    _shapeLayer.lineWidth = _cirqueLineWidth;
    _shapeLayer.strokeColor = _strokeColor.CGColor;
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _bgShapeLayer.fillMode = kCAFillModeForwards;
    
    // 路径
    _cirquePath = [UIBezierPath bezierPath];
    _shapeLayer.path = _cirquePath.CGPath;
    
    // 设置起始弧度
    _startAngle = -90;
    
    // 添加Layer
    [self.layer addSublayer:_shapeLayer];
    
    // 创建定时器
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawCirque)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    _displayLink.paused = NO;
}

#pragma mark - 绘制圆弧
- (void)drawCirque {
    if (_startAngle < -90 || _startAngle > 270) {
        [self destoryDisplayLink];
    } else {
        // 距离
        CGFloat delta = 360 / (_durationTime * 60);
        // 结束的弧度
        CGFloat endAngle = _startAngle + delta;
        
        [_cirquePath addArcWithCenter:_centerPoint radius:_cirqueRadius startAngle:_startAngle * (M_PI / 180) endAngle:endAngle * (M_PI / 180) clockwise:YES];
        _shapeLayer.path = _cirquePath.CGPath;
        _startAngle += delta;
    }
}

#pragma mark - 暂停定时器
- (void)destoryDisplayLink {
    if (_displayLink.paused == NO) {
        _displayLink.paused = YES;
    }
    [_displayLink invalidate];
}

#pragma mark - 移除视图
- (void)removeFromSuperview {
    [super removeFromSuperview];
    [self destoryDisplayLink];
    _displayLink = nil;
}

@end
