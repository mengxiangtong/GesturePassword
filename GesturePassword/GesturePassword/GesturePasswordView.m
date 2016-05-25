//
//  GesturePasswordView.m
//  GesturePassword
//
//  Created by hb on 14-8-23.
//  Copyright (c) 2014年 黑と白の印记. All rights reserved.
//

#import "GesturePasswordView.h"
#import "GesturePasswordButton.h"
#import "TentacleView.h"

@implementation GesturePasswordView {
    NSMutableArray * buttonArray;
    
    CGPoint lineStartPoint;
    CGPoint lineEndPoint;
    
}
@synthesize imgView;
@synthesize forgetButton;
@synthesize changeButton;

@synthesize tentacleView;
@synthesize state;
@synthesize gesturePasswordDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:236/255 green:235/255 blue:227/255 alpha:1];
        
        // Initialization code
        buttonArray = [[NSMutableArray alloc]initWithCapacity:0];
       
        
        //shou shi mi ma
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.bounds.size.width, 30)];
        titleLabel.text = @"手势密码";
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        
        
        
        //头像
        imgView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width/2-30, CGRectGetMaxY(titleLabel.frame)+10, 54, 54)];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.contentMode = 0;
        imgView.image = [UIImage imageNamed:@"IMG_3394.jpg"];
        [imgView setBackgroundColor:[UIColor whiteColor]];
        
        [imgView.layer setMasksToBounds: YES];
        [imgView.layer setCornerRadius:27];
        
//        [imgView.layer setBorderColor:[UIColor grayColor].CGColor];
//        [imgView.layer setBorderWidth:3];
        [self addSubview:imgView];
        
        
        state = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/2-140, CGRectGetMaxY(imgView.frame)+5, 280, 30)];
        [state setTextAlignment:NSTextAlignmentCenter];
        [state setFont:[UIFont systemFontOfSize:14.f]];
        [self addSubview:state];
        
        //键盘
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width/2-160, CGRectGetMaxY(state.frame)+30, 320, self.bounds.size.height -  state.frame.origin.y -20)];
        view.backgroundColor = [UIColor clearColor];
        
        for (int i=0; i<9; i++) {
            NSInteger row = i/3;
            NSInteger col = i%3;
            // Button Frame
            
            NSInteger distance = 35;
            NSInteger size = 60;
            
            GesturePasswordButton * gesturePasswordButton = [[GesturePasswordButton alloc]initWithFrame:CGRectMake(col*(distance+size)+35, row*(distance+size), size, size)];
            
           // gesturePasswordButton.backgroundColor = [UIColor cyanColor];
            [gesturePasswordButton setTag:i];
            [view addSubview:gesturePasswordButton];
            [buttonArray addObject:gesturePasswordButton];
        }
        
        frame.origin.y=0;
        [self addSubview:view];
        
        
        //xian
        tentacleView = [[TentacleView alloc]initWithFrame:view.frame];
        //tentacleView.backgroundColor = [UIColor redColor];
        [tentacleView setButtonArray:buttonArray];
        [tentacleView setTouchBeginDelegate:self];
        [self addSubview:tentacleView];
        
        
        
        forgetButton = [[UIButton alloc]initWithFrame:CGRectMake(0, frame.size.height/2+220, self.bounds.size.width, 40)];
        //forgetButton.backgroundColor = [UIColor yellowColor];
        [forgetButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [forgetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [forgetButton setTitle:@"忘记手势密码" forState:UIControlStateNormal];
        [forgetButton setTitleColor:[UIColor blackColor] forState:0];
        
        [forgetButton addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchDown];
        [self addSubview:forgetButton];
        
//        changeButton = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width/2+30, frame.size.height/2+220, 120, 30)];
//        [changeButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
//        [changeButton setTitleColor:[UIColor blackColor] forState:0];
//        
//        //[changeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [changeButton setTitle:@"修改手势密码" forState:UIControlStateNormal];
//        [changeButton addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchDown];
//        [self addSubview:changeButton];
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect
{
    //画渐变 背景
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] =
    {
        252 / 255.0, 250 / 255.0, 251 / 255.0, 1.00,
        
        252 / 255.0,  251 / 255.0, 252 / 255.0, 1.00,
    };
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents
    (rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    CGColorSpaceRelease(rgb);
    CGContextDrawLinearGradient(context, gradient,CGPointMake
                                (0.0,0.0) ,CGPointMake(0.0,self.frame.size.height),
                                kCGGradientDrawsBeforeStartLocation);
}

- (void)gestureTouchBegin {
    [self.state setText:@""];
}

# pragma mark - - 调用代理

-(void)forget{
    
    if (self.gesturePasswordDelegate && [self.gesturePasswordDelegate respondsToSelector:@selector(forget) ]) {
       
        [gesturePasswordDelegate forget];

    }
    
}

-(void)change{
    
    if (self.gesturePasswordDelegate && [self.gesturePasswordDelegate respondsToSelector:@selector(change)]) {
        
        [gesturePasswordDelegate change];

    }
    
}


@end
