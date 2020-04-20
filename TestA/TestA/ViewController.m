//
//  ViewController.m
//  TestA
//
//  Created by LIUSONG on 2020/4/16.
//  Copyright © 2020 LIUSONG. All rights reserved.
//

#import "ViewController.h"
#import "LCanvasView.h"
#import "HCanvasView.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//	[self lowMemoryCanvas];
	[self highMemoryCanvas];
}

- (void)lowMemoryCanvas {
	LCanvasView *	canvasView = [[LCanvasView alloc] initWithFrame:CGRectMake(0, 0, 5000, 5000)];	// 宽高越大，内存消耗越明显
	[self.view addSubview:canvasView];
}

- (void)highMemoryCanvas {
	HCanvasView *	canvasView = [[HCanvasView alloc] initWithFrame:CGRectMake(0, 0, 5000, 5000)];
	[self.view addSubview:canvasView];
}


@end
