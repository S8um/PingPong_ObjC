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
    
    NSLog(@"%@", @"Загрузка завершена");
    NSLog(@"Width = %f, height = %f", SCREEN_WIDTH, SCREEN_HEIGHT);
    [self config];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%@", @"До отображения на экране");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"%@", @"После отображения на экране");
    [self becomeFirstResponder];
    [self newGame];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSLog(@"%@", @"До закрытия контроллера");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self resignFirstResponder];
    NSLog(@"%@", @"После закрытия контроллера");
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    NSLog(@"%@", @"Обработки поворота экрана");
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

- (void)touchesBegan: (NSSet<UITouch *> *)touches withEvent: (UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInView:self.view];
        if (self.bottomTouch == nil && point.y > HALF_SCREEN_HEIGHT) {
            self.bottomTouch = touch;
            self.paddleBottom.center = CGPointMake(point.x, point.y);
        }
        else if (self.topTouch == nil && point.y < HALF_SCREEN_HEIGHT) {
            self.topTouch = touch;
            self.paddleTop.center = CGPointMake(point.x, point.y);
        }
    }
}

- (void)touchesMoved: (NSSet<UITouch *> *)touches withEvent: (UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint point = [touch locationInView:self.view];
        if (touch == self.topTouch) {
            if (point.y > HALF_SCREEN_HEIGHT) {
                self.paddleTop.center = CGPointMake(point.x, HALF_SCREEN_HEIGHT);
                return;
            }
            self.paddleTop.center = point;
        }
        else if (touch == self.bottomTouch) {
            if (point.y < HALF_SCREEN_HEIGHT) {
                self.paddleBottom.center = CGPointMake(point.x, HALF_SCREEN_HEIGHT);
                return;
            }
            self.paddleBottom.center = point;
        }
    }
}

- (void)touchesEnded: (NSSet<UITouch *> *)touches withEvent: (UIEvent *)event {
    for (UITouch *touch in touches) {
        if (touch == self.topTouch) {
            self.topTouch = nil;
        }
        else if (touch == self.bottomTouch) {
            self.bottomTouch = nil;
        }
    }
}

- (void)touchesCancelled: (NSSet<UITouch *> *)touches withEvent: (UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
};

- (void)displayMessage:(NSString *)message {
    [self stop];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Ping Pong"
                                                                             message:message
                                                                      preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if ([self gameOver]) {
            [self newGame];
            return;
        }
        [self reset];
        [self start];
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)newGame {
    [self reset];
    
    self.scoreTop.text = @"0";
    self.scoreBottom.text = @"0";
    
    [self displayMessage:@"Готовы к игре?"];
}

- (int)gameOver {
    if ([self.scoreTop.text intValue] >= MAX_SCORE) return 1;
    if ([self.scoreBottom.text intValue] >= MAX_SCORE) return 2;
    return 0;
}

- (void)start {
    self.ball.center = CGPointMake(HALF_SCREEN_WIDTH, HALF_SCREEN_HEIGHT);
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(animate) userInfo:nil repeats:YES];
    }
    self.ball.hidden = NO;
}

- (void)reset {
    if ((arc4random() % 2) == 0) {
        self.dx = -1;
    } else {
        self.dx = 1;
    }
    
    if (self.dy != 0) {
        self.dy = -self.dy;
    } else if ((arc4random() % 2) == 0) {
        self.dy = -1;
    } else  {
        self.dy = 1;
    }
    
    self.ball.center = CGPointMake(HALF_SCREEN_WIDTH, HALF_SCREEN_HEIGHT);
    
    self.speed = 2;
}

- (void)stop {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.ball.hidden = YES;
}

- (void)animate {
    self.ball.center = CGPointMake(self.ball.center.x + self.dx * self.speed, self.ball.center.y + self.dy * self.speed);
    [self checkCollision:CGRectMake(0, 0, 20, SCREEN_HEIGHT) X:fabs(self.dx) Y:0];
    [self checkCollision:CGRectMake(SCREEN_WIDTH, 0, 20, SCREEN_HEIGHT) X:-fabs(self.dx) Y:0];
    if ([self checkCollision:self.paddleTop.frame X:(self.ball.center.x - self.paddleTop.center.x) / 32.0 Y:1]) {
        [self increaseSpeed];
    }
    if ([self checkCollision:self.paddleBottom.frame X:(self.ball.center.x - self.paddleBottom.center.x) / 32.0 Y:-1]) {
        [self increaseSpeed];
    }
    [self goal];
}

- (void)increaseSpeed {
    self.speed += 0.5;
    if (self.speed > 10) self.speed = 10;
}

- (BOOL)checkCollision: (CGRect)rect X:(float)x Y:(float)y {
    if (CGRectIntersectsRect(self.ball.frame, rect)) {
        if (x != 0) self.dx = x;
        if (y != 0) self.dy = y;
        return YES;
    }
    return NO;
}

- (BOOL)goal
{
    if (self.ball.center.y < 0 || self.ball.center.y >= SCREEN_HEIGHT) {
        NSInteger s1 = [self.scoreTop.text intValue];
        NSInteger s2 = [self.scoreBottom.text intValue];
        
        if (self.ball.center.y < 0) ++s2; else ++s1;
        self.scoreTop.text = [NSString stringWithFormat:@"%ld", (long)s1];
        self.scoreBottom.text = [NSString stringWithFormat:@"%ld", (long)s2];
        
        NSInteger gameOver = [self gameOver];
        if (gameOver) {
            [self displayMessage:[NSString stringWithFormat:@"Игрок %li выиграл", (long)gameOver]];
        } else {
            [self reset];
        }
        
        return YES;
    }
    return NO;
}

@end
