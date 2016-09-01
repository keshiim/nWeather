//
//  FadeBlackView.m
//  YoCelsius
//
//  Created by XianMingYou on 15/2/28.
//
//  https://github.com/YouXianMing
//  http://www.cnblogs.com/YouXianMing/
//

#import "FadeBlackView.h"

@implementation FadeBlackView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:CGRectMake(0, 0, Width, Height)];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha           = 0.f;
        [self addBackgroundLayer];
    }
    
    return self;
}

- (void)addBackgroundLayer {
    //设置背景(注意这个图片其实在根图层)
    UIImage *backgroundImage=[UIImage imageNamed:@"4"];
//    self.view.backgroundColor=[UIColor colorWithPatternImage:backgroundImage];
    
    //自定义一个图层
    CALayer *_layer=[[CALayer alloc]init];
    _layer.backgroundColor = [UIColor clearColor].CGColor;
    _layer.bounds          = CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height);
    _layer.contents        = (id)backgroundImage.CGImage;
    _layer.position        = self.center;
    [self.layer addSublayer:_layer];
}

- (void)show {
    
    [UIView animateWithDuration:1.f animations:^{
        
        self.alpha = 0.75f;
    }];
}

- (void)hide {
    
    [UIView animateWithDuration:0.75f animations:^{
        
        self.alpha = 0.f;
    }];
}

@end
