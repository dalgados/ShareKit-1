//
//  SHKCustomFormControllerLargeTextField.m
//  ShareKit
//
//  Created by Nathan Weiner on 6/28/10.

//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//

#import "SHKCustomFormControllerLargeTextField.h"
#import "SHKItem.h"

// stop warning on keyboardWillShow
@interface SHKFormControllerLargeTextField ()
- (void)keyboardWillShow:(NSNotification *)notification;
@end


@interface SHKCustomFormControllerLargeTextField ()
@property (nonatomic, retain) UIImageView *itemImageView;
- (void)layoutImageView;
@end

@implementation SHKCustomFormControllerLargeTextField
@synthesize itemImageView = _itemImageView;

#define ImageIndent 20.0f
#define ImageMaxHeight 140.0f

- (void)dealloc
{
    self.itemImageView = nil;
    [super dealloc];
}
- (void)keyboardWillShow:(NSNotification *)notification
{
    if ([super respondsToSelector:@selector(keyboardWillShow:)]) {
        [super keyboardWillShow:notification];
    }
    [self layoutImageView];
}


- (void)layoutImageView
{
    if (!self.image) 
        return;
    CGRect rect;
    // calculate a size for the image to display in with same aspect ratio, (due to contentMode not being a bitmask :(  )
    CGFloat scale = ImageMaxHeight/self.image.size.height;
    rect.origin = CGPointMake(ImageIndent, CGRectGetMaxY(self.textView.bounds) - ImageMaxHeight - (ImageIndent - 10)); // -10 because our image has a drop shadow
    rect.size = CGSizeApplyAffineTransform(self.image.size, CGAffineTransformMakeScale(scale, scale));
    
    self.itemImageView.frame = CGRectIntegral(rect);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.8f animations:^{
        self.itemImageView.alpha = 1.0;
    }];
}

- (void)loadView
{
    [super loadView];
    if (self.image)
    {
        self.itemImageView  = [[[UIImageView alloc] initWithImage:self.image] autorelease];     
        self.itemImageView.frame = CGRectZero;
        self.itemImageView.alpha = 0.0;
        self.itemImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.itemImageView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        [self.view addSubview:self.itemImageView];
    }
}

- (void)viewDidUnload
{
    self.itemImageView = nil;
    [super viewDidUnload];
}


@end
