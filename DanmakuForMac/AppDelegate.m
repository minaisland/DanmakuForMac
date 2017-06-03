//
//  AppDelegate.m
//  DanmakuForMac
//
//  Created by 郑先生 on 16/1/16.
//  Copyright © 2016年 郑先生. All rights reserved.
//

#import "AppDelegate.h"
#import "DanmakuView.h"

@interface AppDelegate () <DanmakuDelegate>

@property (weak) IBOutlet NSWindow *window;
@property (nonatomic, readonly) NSView *view;
@property (nonatomic, strong) DanmakuView *danmakuView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat curTime;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    CGRect rect =  CGRectMake(0, 2, NSWidth(self.view.bounds), NSHeight(self.view.bounds)-4);
    DanmakuConfiguration *configuration = [[DanmakuConfiguration alloc] init];
    configuration.duration = 10;
    configuration.paintHeight = 30;
    configuration.fontSize = 23;
    configuration.largeFontSize = 25;
    configuration.maxLRShowCount = 30;
    configuration.maxShowCount = 45;
    _danmakuView = [[DanmakuView alloc] initWithFrame:rect Configuration:configuration];
    _danmakuView.delegate = self;
    [self.view addSubview:_danmakuView];
    
    NSString *danmakufile = [[NSBundle mainBundle] pathForResource:@"danmakufile" ofType:nil];
    NSArray *danmakus = [NSArray arrayWithContentsOfFile:danmakufile];
    _danmakuView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    [_danmakuView prepareDanmakus:danmakus];
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)onTimeCount
{
    _curTime+=0.1/120;
    if (_curTime>120.0) {
        _curTime=0;
    }
    [self onTimeChange:nil];
}

- (void)onTimeChange:(id)sender
{
    NSLog(@"%@", [NSString stringWithFormat:@"%.0fs", _curTime*120.0]);
}

- (IBAction)onStart:(NSButton *)sender
{
    if (_danmakuView.isPrepared) {
        if (!_timer) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(onTimeCount) userInfo:nil repeats:YES];
        }
        [_danmakuView start];
    }
}

- (float)danmakuViewGetPlayTime:(DanmakuView *)danmakuView
{
    return _curTime*120.0;
}

- (BOOL)danmakuViewIsBuffering:(DanmakuView *)danmakuView
{
    return NO;
}

- (NSView *)view
{
    return self.window.contentView;
}

@end
