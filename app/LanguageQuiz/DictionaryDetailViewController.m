//
//  DictionaryDetailViewController.m
//  LanguageQuiz
//
//  Created by Daniel  on 20.05.15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import "DictionaryDetailViewController.h"


@implementation DictionaryDetailViewController
@synthesize titleLabel, loadingIndicator, websiteView, searchString;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WikiHelper *wikiHelper = [[WikiHelper alloc] init];
    wikiHelper.apiURL = @"http://en.wikipedia.org";
    wikiHelper.delegate = self;
    
    NSMutableString *searchWord = [[NSMutableString alloc] initWithString:@"ISO_639:"];
    [searchWord appendString:searchString];
    //searchString;
    titleLabel.text = searchWord;
    
    [wikiHelper fetchArticle:searchWord];
    [loadingIndicator startAnimating];
    loadingIndicator.hidden = FALSE;
//    websiteView.delegate = [websiteView delegate];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dataLoaded:(NSString *)htmlPage{
    [loadingIndicator stopAnimating];
    loadingIndicator.hidden = TRUE;
    [websiteView loadHTMLString:htmlPage baseURL:nil];
    [self webViewDidFinishLoad:websiteView];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)theWebView
{
    CGSize contentSize = theWebView.scrollView.contentSize;
    CGSize viewSize = self.view.bounds.size;
    
    float rw = viewSize.width / contentSize.width;
    
    theWebView.scrollView.minimumZoomScale = rw;
    theWebView.scrollView.maximumZoomScale = rw;
    theWebView.scrollView.zoomScale = rw;
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
