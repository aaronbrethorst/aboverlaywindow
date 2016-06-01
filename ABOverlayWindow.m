//
//  ABOverlayWindow.m
//
//  ABOverlayWindow
//
//  Copyright (c) 2016 Aaron Brethorst
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "ABOverlayWindow.h"

NSString * const ABGridPaddingWidthKey = @"ABGridPaddingWidthKey";
NSString * const ABGridColorKey = @"ABGridColorKey";
NSString * const ABGridColumnCountKey = @"ABGridColumnCountKey";

#define kDefaultPaddingWidth 8.f
#define kDefaultColumnCount 3
#define kDefaultGridColor [UIColor colorWithRed:(66.f/255.f) green:(186.f/255.f) blue:(236.f/255.f) alpha:0.5f]

@interface ABGridView : UIView
@property(nonatomic,assign) CGFloat padding;
@property(nonatomic,assign) NSUInteger columnCount;
@property(nonatomic,strong) UIColor *columnColor;
@end

@implementation ABGridView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        self.userInteractionEnabled = NO;
        self.opaque = NO;
        _columnColor = [UIColor colorWithRed:(66.f/255.f) green:(186.f/255.f) blue:(236.f/255.f) alpha:0.5f];
        _padding = 16.f;
        _columnCount = 3;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);

    CGContextSetStrokeColorWithColor(context, self.columnColor.CGColor);
    CGContextSetLineWidth(context, 2.0f);

    CGFloat columnWidth = (CGRectGetWidth(rect) - (self.padding * (CGFloat)(self.columnCount + 1))) / (CGFloat)self.columnCount;
    CGFloat xPos = 0;

    while (xPos < CGRectGetWidth(rect)) {
        [self drawLineAtXPosition:xPos height:CGRectGetHeight(rect) context:context];
        xPos += self.padding;

        [self drawLineAtXPosition:xPos height:CGRectGetHeight(rect) context:context];
        xPos += columnWidth;
    }
}

- (void)drawLineAtXPosition:(CGFloat)xPos height:(CGFloat)height context:(CGContextRef)context {
    CGContextMoveToPoint(context, xPos, 0.0f);
    CGContextAddLineToPoint(context, xPos, height);
    CGContextStrokePath(context);
}

@end

@interface ABOverlayViewController : UIViewController
- (ABGridView*)gridView;
@end

@implementation ABOverlayViewController

- (void)loadView {
    ABGridView *gridView = [[ABGridView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.view = gridView;
}

- (ABGridView*)gridView {
    return (ABGridView*)self.view;
}

@end

@implementation ABOverlayWindow

- (instancetype)init {
    self = [super init];

    if (self) {
        self.windowLevel = UIWindowLevelAlert;
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)showWithConfiguration:(nullable NSDictionary*)configuration {
    ABOverlayViewController *overlayController = [[ABOverlayViewController alloc] init];

    UIColor *columnColor = configuration[ABGridColorKey] ?: kDefaultGridColor;
    NSInteger columnCount = configuration[ABGridColumnCountKey] ? [configuration[ABGridColumnCountKey] integerValue] : kDefaultColumnCount;
    CGFloat padding = configuration[ABGridPaddingWidthKey] ? [configuration[ABGridPaddingWidthKey] floatValue] : kDefaultPaddingWidth;

    overlayController.gridView.columnColor = columnColor;
    overlayController.gridView.columnCount = columnCount;
    overlayController.gridView.padding = padding;

    self.rootViewController = overlayController;
    self.hidden = NO;
}

@end
