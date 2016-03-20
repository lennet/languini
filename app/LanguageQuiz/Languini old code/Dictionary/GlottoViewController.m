//
//  GlottoViewController.m
//  Languini
//
//  Created by Daniel  on 29.06.15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import "GlottoViewController.h"

@interface GlottoViewController ()

@end

@implementation GlottoViewController
@synthesize glottoID;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpWebView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationItem setTitle:[NSString stringWithFormat:@"Glottolog - %@", glottoID]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpWebView {
    NSMutableString *urlAddress = [[NSMutableString alloc] initWithString:@"http://www.glottolog.org/glottolog?search="];
    [urlAddress appendString:glottoID];
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requestObj];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
