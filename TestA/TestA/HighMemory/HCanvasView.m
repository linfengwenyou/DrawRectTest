//
//  HCanvasView.m
//  TestA
//
//  Created by LIUSONG on 2020/4/20.
//  Copyright © 2020 LIUSONG. All rights reserved.
//

#import "HCanvasView.h"

@interface HCanvasView ()
@property (nonatomic, strong) NSMutableArray *lines;
@property (nonatomic, strong) NSMutableArray *colors;
@property (nonatomic, strong) NSMutableArray *lineWidth;
@end

@implementation HCanvasView


- (instancetype)initWithFrame:(CGRect)frame {
	if ( self = [super initWithFrame:frame]) {
		_lines = @[].mutableCopy;
		_colors = @[].mutableCopy;
		_lineWidth = @[].mutableCopy;
		self.backgroundColor = [UIColor blueColor];
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
	
	
	[self.lines addObject:path];
	[self.lineWidth addObject:@(arc4random()%24)];
	
	UIColor *randColor = [UIColor colorWithRed:arc4random()%255 / 255.0f green:arc4random()%255 / 255.0f blue:arc4random()%255 / 255.0f alpha:1];
	[self.colors addObject:randColor];
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	// 获取移动点
	CGPoint moveP = [self pointWithTouches:touches];
	[self.lines.lastObject addLineToPoint:moveP];
	[self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
/* 主要是因为使用此方法会绘制一个画板作为寄宿图， layer.contents
 这个寄宿图的大小，与视图的宽高还有屏幕比例有关，如果宽高非常大，会造成寄宿图创建一个很大的对象
 只要重写drawRect方法就会生成一个寄宿图，哪怕是一个空的实现也会
 */
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	for (int i = 0; i< self.lines.count; i ++) {
		UIBezierPath *path = self.lines[i];
		CGContextAddPath(ctx, path.CGPath);
		UIColor *color = self.colors[i];
		CGFloat lineW = [self.lineWidth[i] floatValue];

		[color setStroke];
		CGContextSetLineWidth(ctx, lineW);

		CGContextSetLineCap(ctx, kCGLineCapRound);
		CGContextSetLineJoin(ctx,kCGLineJoinRound);


		CGContextStrokePath(ctx);

		CGContextSaveGState(ctx);
	}
}

@end
