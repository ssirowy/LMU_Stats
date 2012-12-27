//
//  LMUPDFModuleView.m
//  Stats
//
//  Created by Scott Sirowy on 8/14/12.
//
//

#import "LMUPDFModuleView.h"
#import "LMUPDFModule.h"

@interface LMUPDFModuleView ()

@property (nonatomic, retain) UIWebView*    webView;

- (LMUPDFModule*)pdfModule;

@end

@implementation LMUPDFModuleView

- (void)dealloc
{
    [_webView   release];
    [super      dealloc];
}

- (id)initWithFrame:(CGRect)frame withModule:(LMUPDFModule*)module
{
    self = [super initWithFrame:frame withModule:module];
    if (self) {
        
        UIWebView*  wv = [[UIWebView alloc] initWithFrame:self.bounds];
        wv.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.webView = wv;
        [wv release];
        
        [self addSubview:wv];
        
        NSString*   pdfPath = [[NSBundle mainBundle] pathForResource:self.pdfModule.fileName ofType:@"pdf"];
        NSURL*      pdfURL = [NSURL fileURLWithPath:pdfPath];
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:pdfURL]];
    }
    return self;
}

- (LMUPDFModule*)pdfModule
{
    return (LMUPDFModule*)self.module;
}

@end
