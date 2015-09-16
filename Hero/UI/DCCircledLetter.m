//
//  DCCircledLetter.m
//  Hero
//
//  Created by totaramudu on 03/07/15.
//  Copyright (c) 2015 Deviceworks. All rights reserved.
//

#import "DCCircledLetterView.h"

NSString* const kPropertyFillColor      =   @"fillColor";
NSString* const kPropertyLetter         =   @"label.text";

@interface DCCircledLetterView ()
@property (nonatomic) UILabel* label;
@end

@implementation DCCircledLetterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.fillColor = [UIColor lightGrayColor];
        [self addLabel];
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        [self addObserver:self forKeyPath:kPropertyLetter
                  options:NSKeyValueObservingOptionNew
                  context:nil];
        [self addObserver:self forKeyPath:kPropertyFillColor
                  options:NSKeyValueObservingOptionNew
                  context:nil];
    }
    return self;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:kPropertyLetter];
    [self removeObserver:self forKeyPath:kPropertyFillColor];
}

- (void)layoutSubviews {
    float height = CGRectGetHeight(self.bounds);
    height = height/2;
    UIFont* newFont = [UIFont fontWithName:self.label.font.fontName size:height];
    self.label.font = newFont;
}

- (void)drawRect:(CGRect)rect {
    CGRect drawRect = rect;
    drawRect.size.width = CGRectGetWidth(rect);
    drawRect.size.height = CGRectGetHeight(rect);
    CGRect borderRect = drawRect;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat fillRed, fillGreen, fillBlue, fillAlpha;
    [self.fillColor getRed:&fillRed green:&fillGreen blue:&fillBlue alpha:&fillAlpha];
    // Fill circle with fill color.
    CGContextSetRGBFillColor(context, fillRed, fillGreen, fillBlue, fillAlpha);
    CGContextFillEllipseInRect (context, borderRect);
    CGContextFillPath(context);
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:kPropertyFillColor]) {
        [self setNeedsDisplay];
    } else if ([keyPath isEqualToString:kPropertyLetter]) {}
}

#pragma Private

- (void)addLabel {
    UILabel* label = self.label;
    if (!label) {
        label = [[UILabel alloc] initWithFrame:self.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.clipsToBounds = YES;
        self.label = label;
        [self addSubview:self.label];
    }
}

@end
