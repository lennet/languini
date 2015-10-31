//
//  GlottoViewController.h
//  Languini
//
//  Created by Daniel  on 29.06.15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GlottoViewController : UIViewController
@property(strong, nonatomic) IBOutlet UIWebView *webView;
@property(strong, nonatomic) NSString *glottoID;

@end
