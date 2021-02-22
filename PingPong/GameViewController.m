//
//  GameViewController.m
//  PingPong
//
//  Created by admin on 22.02.2021.
//

#import "GameViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define HALF_SCREEN_WIDTH SCREEN_WIDTH/2
#define HALF_SCREEN_HEIGHT SCREEN_HEIGHT/2
#define MAX_SCORE 6

@interface GameViewController ()

@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UIView *gridView;

@property (strong, nonatomic) UIView *ball;
@property (nonatomic) float dx;
@property (nonatomic) float dy;
@property (nonatomic) float speed;

@property (strong, nonatomic) UIImageView *paddleTop;
@property (strong, nonatomic) UIImageView *paddleBottom;
@property (strong, nonatomic) UITouch *topTouch;
@property (strong, nonatomic) UITouch *bottomTouch;
@property (strong, nonatomic) UILabel *scoreTop;
@property (strong, nonatomic) UILabel *scoreBottom;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Width = %f, height = %f", SCREEN_WIDTH, SCREEN_HEIGHT);
    
    [self config];
}

- (void)config {
    self.view.backgroundColor = [UIColor colorWithRed:100.0/255.0
                                                green:170.0/255.0
                                                 blue:200.0/255.0
                                                alpha:1.0];
    [self createGrid];
    [self createBall];
    [self createPaddleTop];
    [self createPaddleBottom];
    [self createScoreTop];
    [self createScoreBottom];
}

- (void) createGrid {
    self.gridView = [[UIView alloc] initWithFrame: CGRectMake(0,
                                                              HALF_SCREEN_HEIGHT - 2,
                                                              SCREEN_WIDTH,
                                                              4)];
    self.gridView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    [self.view addSubview: self.gridView];
};

- (void) createBall {
    self.ball = [[UIView alloc] initWithFrame: CGRectMake(self.view.center.x - 10,
                                                          self.view.center.y - 10,
                                                          20,
                                                          20)];
    self.ball.backgroundColor = [UIColor whiteColor];
    self.ball.layer.cornerRadius = 10;
    self.ball.hidden = YES;
    [self.view addSubview: self.ball];
};

- (void) createPaddleTop {
    self.paddleTop = [[UIImageView alloc] initWithFrame: CGRectMake(SCREEN_WIDTH - 120,
                                                                    40,
                                                                    90,
                                                                    60)];
    self.paddleTop.image = [UIImage imageNamed: @"paddle_top"];
    self.paddleTop.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview: self.paddleTop];
};

- (void) createPaddleBottom {
    self.paddleBottom = [[UIImageView alloc] initWithFrame: CGRectMake(30,
                                                                       SCREEN_HEIGHT - 90,
                                                                       90,
                                                                       60)];
    self.paddleBottom.image = [UIImage imageNamed: @"paddle_bottom"];
    self.paddleBottom.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview: self.paddleBottom];
};

- (void) createScoreTop {
    self.scoreTop = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH - 50,
                                                               HALF_SCREEN_HEIGHT - 70,
                                                               50,
                                                               50)];
    self.scoreTop.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
    self.scoreTop.text = @"0";
    self.scoreTop.font = [UIFont systemFontOfSize:40.0 weight:UIFontWeightLight];
    self.scoreTop.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: self.scoreTop];
};

- (void) createScoreBottom {
    self.scoreBottom = [[UILabel alloc] initWithFrame: CGRectMake(SCREEN_WIDTH - 50,
                                                                  HALF_SCREEN_HEIGHT + 20,
                                                                  50,
                                                                  50)];
    self.scoreBottom.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
    self.scoreBottom.text = @"0";
    self.scoreBottom.font = [UIFont systemFontOfSize:40.0 weight:UIFontWeightLight];
    self.scoreBottom.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: self.scoreBottom];
};

@end
