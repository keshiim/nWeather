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

@interface FadeBlackView ()

@property (nonatomic, strong) CALayer        *backgroundLayer;
@property (nonatomic, strong) NSMutableArray *historyIndexs;

@end

@implementation FadeBlackView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:CGRectMake(0, 0, Width, Height)];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha           = 0.f;
    }
    
    return self;
}

- (void)addBackgroundLayer {
    
    static NSArray<UIImage *> *images = nil;
    if (!images && images.count == 0) {
        images = ({
            NSArray *array = @[[UIImage imageNamed:@"1"],
                               [UIImage imageNamed:@"2"],
                               [UIImage imageNamed:@"3"],
                               [UIImage imageNamed:@"4"],
                               [UIImage imageNamed:@"5"],
                               [UIImage imageNamed:@"6"],
                               [UIImage imageNamed:@"7"],
                               [UIImage imageNamed:@"8"],
                               [UIImage imageNamed:@"9"]];
            
            array;
        });
    }
    
    //设置背景(注意这个图片其实在根图层)
    NSInteger randIndex = 0;
    randIndex = [self getRandomWithRemainder:images.count];
    //加入historyIndexs中
    [self.historyIndexs addObject:@(randIndex)];
    
    UIImage *backgroundImage = images[randIndex];
    //自定义一个图层
    self.backgroundLayer.contents = (__bridge id)backgroundImage.CGImage;
    self.backgroundLayer.contentsGravity = kCAGravityResizeAspect;
    self.backgroundLayer.contentsScale   = backgroundImage.scale;
}

- (NSInteger)getRandomWithRemainder:(NSInteger)remainder {
    NSInteger randIndex = arc4random() % remainder;
    
    if (self.historyIndexs.count == 0) {
        return randIndex;
    } else if (self.historyIndexs.count == 1) {
        NSInteger lastIndex  = [[self.historyIndexs lastObject] integerValue];
        if (randIndex == lastIndex) {
            randIndex = [self getRandomWithRemainder:remainder];
        }
    } else if (self.historyIndexs.count >= 2) {
        NSInteger lastIndex  = [[self.historyIndexs lastObject] integerValue];
        NSInteger lasstIndex = [self.historyIndexs[self.historyIndexs.count - 2] integerValue];
        
        if (randIndex == lastIndex || randIndex == lasstIndex) {
            randIndex = [self getRandomWithRemainder:remainder];
        }
    }
    
    return randIndex;
}

- (CALayer *)backgroundLayer {
    if (!_backgroundLayer) {
        _backgroundLayer = [[CALayer alloc]init];
        _backgroundLayer.backgroundColor = [UIColor clearColor].CGColor;
        _backgroundLayer.bounds          = self.bounds;//CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height);
        _backgroundLayer.position        = self.center;
        [self.layer addSublayer:self.backgroundLayer];
    }
    
    return _backgroundLayer;
}

- (NSMutableArray *)historyIndexs {
    if (!_historyIndexs) {
        _historyIndexs = @[].mutableCopy;
    }
    
    return _historyIndexs;
}

- (void)show {
    [self addBackgroundLayer];
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
