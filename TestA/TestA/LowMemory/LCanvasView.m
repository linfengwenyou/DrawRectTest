//
//  LCanvasView.m
//  TestA
//
//  Created by LIUSONG on 2020/4/20.
//  Copyright © 2020 LIUSONG. All rights reserved.
//

#import "LCanvasView.h"


@interface LCanvasView ()
@property (nonatomic, strong) UIBezierPath  *path;
@property (nonatomic, strong) CAShapeLayer *shapLayer;
@end

@implementation LCanvasView

- (instancetype)init {
	if (self = [super init]) {
		self.backgroundColor = UIColor.whiteColor;
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.backgroundColor = UIColor.blueColor;
	}
	return self;
}

// 根据touches集合获取对应的触摸点
- (CGPoint)pointWithTouches:(NSSet *)touches
{
	UITouch *touch = [touches anyObject];
	
	return [touch locationInView:self];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	CGPoint startP = [self pointWithTouches:touches];
	
	UIBezierPath *path = [UIBezierPath bezierPath];
	[path moveToPoint:startP];
	path.lineWidth = arc4random()%4;
	self.path = path;
	
	
	UIColor *randColor = [UIColor colorWithRed:arc4random()%255 / 255.0f green:arc4random()%255 / 255.0f blue:arc4random()%255 / 255.0f alpha:1];
	
	CAShapeLayer *layer = [CAShapeLayer layer];
	layer.lineWidth = arc4random() % 25;
	layer.strokeColor = randColor.CGColor;
	layer.fillColor = UIColor.clearColor.CGColor;
	layer.lineCap = kCALineCapRound;
	layer.lineJoin = kCALineJoinBevel;
	layer.path = self.path.CGPath;
	
	[self.layer addSublayer:layer];
	self.shapLayer = layer;
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	// 获取移动点
	CGPoint moveP = [self pointWithTouches:touches];
	[self.path addLineToPoint:moveP];
	self.shapLayer.path = self.path.CGPath;

}

@end
