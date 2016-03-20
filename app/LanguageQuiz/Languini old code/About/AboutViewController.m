//
//  AboutViewController.m
//  Languini
//
//  Created by Nils Risse on 04/07/15.
//  Copyright (c) 2015 Coding Da Vinci. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (strong, nonatomic) IBOutlet UITextView *infoTextView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *infoTextViewHeight;
@property (strong, nonatomic) IBOutlet UITextView *licenceTextView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *licenceTextViewHeight;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([[[NSLocale preferredLanguages] objectAtIndex:0] isEqualToString:@"de"]) {
        self.licenceTextView.attributedText = [self germanLicence];
        self.infoTextView.attributedText = [self germanInfo];
    } else {
        self.licenceTextView.attributedText = [self englishLicence];
        self.infoTextView.attributedText = [self englishInfo];
    }
    
    [self.infoTextView layoutIfNeeded];
    [self.infoTextView.layoutManager ensureLayoutForTextContainer:self.infoTextView.textContainer];
    [self.infoTextView layoutIfNeeded];
    
    self.infoTextViewHeight.constant = self.infoTextView.contentSize.height+15;
    [self.view layoutIfNeeded];

    [self.licenceTextView layoutIfNeeded];
    [self.licenceTextView.layoutManager ensureLayoutForTextContainer:self.licenceTextView.textContainer];
    [self.licenceTextView layoutIfNeeded];
    
    self.licenceTextViewHeight.constant = self.licenceTextView.contentSize.height+15;
    [self.view layoutIfNeeded];
    
    self.licenceTextView.editable = NO;
    self.infoTextView.editable = NO;
}

- (IBAction)handleCancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSAttributedString*)germanLicence
{
    // Create the attributed string
    NSMutableAttributedString *germanLicence = [[NSMutableAttributedString alloc]initWithString:
                                                @"Lizenzen\n\nDaten:\nLanguage Science Press (CC-BY)\nGlottolog/Cross Linguistic Linked Data (CC-BY 3.0)\n\nBilder: \nLanguage Science Press\nCoding Da Vinci Logo - CC-BY 3.0\nMap - Wikipedia  - PD-USGov-CIA-WF\n\nFrameworks:\nReachability - Copyright (C) 2014 Apple Inc. All Rights Reserved.\n\nSchriften:\nAlwaysforever (C) Brittney Murphy Design\n\nLanguini wurde unter der MIT Lizenz veröffentlicht.\nFür weitere Informationen besuchen Sie\nhttps://github.com/lennet/languini"];
    
    // Declare the fonts
    UIFont *germanLicenceFont1 = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
    UIFont *germanLicenceFont2 = [UIFont fontWithName:@"Helvetica" size:14.0];
    
    // Declare the colors
    UIColor *germanLicenceColor1 = [UIColor colorWithRed:0.000000 green:0.000000 blue:0.000000 alpha:1.000000];
    
    // Declare the paragraph styles
    NSMutableParagraphStyle *germanLicenceParaStyle1 = [[NSMutableParagraphStyle alloc]init];
    germanLicenceParaStyle1.alignment = NSTextAlignmentCenter;
    germanLicenceParaStyle1.defaultTabInterval = 36;
    germanLicenceParaStyle1.tabStops = @[[[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:28.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:56.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:84.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:112.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:140.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:168.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:196.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:224.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:252.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:280.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:308.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:336.000000 options:nil], ];
    
    
    // Create the attributes and add them to the string
    [germanLicence addAttribute:NSParagraphStyleAttributeName value:germanLicenceParaStyle1 range:NSMakeRange(0,9)];
    [germanLicence addAttribute:NSStrokeColorAttributeName value:germanLicenceColor1 range:NSMakeRange(0,9)];
    [germanLicence addAttribute:NSFontAttributeName value:germanLicenceFont1 range:NSMakeRange(0,9)];
    [germanLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(0,9)];
    [germanLicence addAttribute:NSParagraphStyleAttributeName value:germanLicenceParaStyle1 range:NSMakeRange(9,8)];
    [germanLicence addAttribute:NSStrokeColorAttributeName value:germanLicenceColor1 range:NSMakeRange(9,8)];
    [germanLicence addAttribute:NSFontAttributeName value:germanLicenceFont2 range:NSMakeRange(9,8)];
    [germanLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(9,8)];
    [germanLicence addAttribute:NSUnderlineColorAttributeName value:germanLicenceColor1 range:NSMakeRange(17,22)];
    [germanLicence addAttribute:NSStrokeColorAttributeName value:germanLicenceColor1 range:NSMakeRange(17,22)];
    [germanLicence addAttribute:NSUnderlineStyleAttributeName value:@(1) range:NSMakeRange(17,22)];
    [germanLicence addAttribute:NSParagraphStyleAttributeName value:germanLicenceParaStyle1 range:NSMakeRange(17,22)];
    [germanLicence addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"http://langsci-press.org/"] range:NSMakeRange(17,22)];
    [germanLicence addAttribute:NSFontAttributeName value:germanLicenceFont2 range:NSMakeRange(17,22)];
    [germanLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(17,22)];
    [germanLicence addAttribute:NSParagraphStyleAttributeName value:germanLicenceParaStyle1 range:NSMakeRange(39,9)];
    [germanLicence addAttribute:NSStrokeColorAttributeName value:germanLicenceColor1 range:NSMakeRange(39,9)];
    [germanLicence addAttribute:NSFontAttributeName value:germanLicenceFont2 range:NSMakeRange(39,9)];
    [germanLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(39,9)];
    [germanLicence addAttribute:NSUnderlineColorAttributeName value:germanLicenceColor1 range:NSMakeRange(48,9)];
    [germanLicence addAttribute:NSStrokeColorAttributeName value:germanLicenceColor1 range:NSMakeRange(48,9)];
    [germanLicence addAttribute:NSUnderlineStyleAttributeName value:@(1) range:NSMakeRange(48,9)];
    [germanLicence addAttribute:NSParagraphStyleAttributeName value:germanLicenceParaStyle1 range:NSMakeRange(48,9)];
    [germanLicence addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"http://glottolog.org/"] range:NSMakeRange(48,9)];
    [germanLicence addAttribute:NSFontAttributeName value:germanLicenceFont2 range:NSMakeRange(48,9)];
    [germanLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(48,9)];
    [germanLicence addAttribute:NSParagraphStyleAttributeName value:germanLicenceParaStyle1 range:NSMakeRange(57,1)];
    [germanLicence addAttribute:NSStrokeColorAttributeName value:germanLicenceColor1 range:NSMakeRange(57,1)];
    [germanLicence addAttribute:NSFontAttributeName value:germanLicenceFont2 range:NSMakeRange(57,1)];
    [germanLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(57,1)];
    [germanLicence addAttribute:NSUnderlineColorAttributeName value:germanLicenceColor1 range:NSMakeRange(58,28)];
    [germanLicence addAttribute:NSStrokeColorAttributeName value:germanLicenceColor1 range:NSMakeRange(58,28)];
    [germanLicence addAttribute:NSUnderlineStyleAttributeName value:@(1) range:NSMakeRange(58,28)];
    [germanLicence addAttribute:NSParagraphStyleAttributeName value:germanLicenceParaStyle1 range:NSMakeRange(58,28)];
    [germanLicence addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"http://clld.org/"] range:NSMakeRange(58,28)];
    [germanLicence addAttribute:NSFontAttributeName value:germanLicenceFont2 range:NSMakeRange(58,28)];
    [germanLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(58,28)];
    [germanLicence addAttribute:NSParagraphStyleAttributeName value:germanLicenceParaStyle1 range:NSMakeRange(86,23)];
    [germanLicence addAttribute:NSStrokeColorAttributeName value:germanLicenceColor1 range:NSMakeRange(86,23)];
    [germanLicence addAttribute:NSFontAttributeName value:germanLicenceFont2 range:NSMakeRange(86,23)];
    [germanLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(86,23)];
    [germanLicence addAttribute:NSUnderlineColorAttributeName value:germanLicenceColor1 range:NSMakeRange(109,22)];
    [germanLicence addAttribute:NSStrokeColorAttributeName value:germanLicenceColor1 range:NSMakeRange(109,22)];
    [germanLicence addAttribute:NSUnderlineStyleAttributeName value:@(1) range:NSMakeRange(109,22)];
    [germanLicence addAttribute:NSParagraphStyleAttributeName value:germanLicenceParaStyle1 range:NSMakeRange(109,22)];
    [germanLicence addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"http://langsci-press.org/index"] range:NSMakeRange(109,22)];
    [germanLicence addAttribute:NSFontAttributeName value:germanLicenceFont2 range:NSMakeRange(109,22)];
    [germanLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(109,22)];
    [germanLicence addAttribute:NSParagraphStyleAttributeName value:germanLicenceParaStyle1 range:NSMakeRange(131,1)];
    [germanLicence addAttribute:NSStrokeColorAttributeName value:germanLicenceColor1 range:NSMakeRange(131,1)];
    [germanLicence addAttribute:NSFontAttributeName value:germanLicenceFont2 range:NSMakeRange(131,1)];
    [germanLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(131,1)];
    [germanLicence addAttribute:NSUnderlineColorAttributeName value:germanLicenceColor1 range:NSMakeRange(132,20)];
    [germanLicence addAttribute:NSStrokeColorAttributeName value:germanLicenceColor1 range:NSMakeRange(132,20)];
    [germanLicence addAttribute:NSUnderlineStyleAttributeName value:@(1) range:NSMakeRange(132,20)];
    [germanLicence addAttribute:NSParagraphStyleAttributeName value:germanLicenceParaStyle1 range:NSMakeRange(132,20)];
    [germanLicence addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"http://codingdavinci.de/presse/"] range:NSMakeRange(132,20)];
    [germanLicence addAttribute:NSFontAttributeName value:germanLicenceFont2 range:NSMakeRange(132,20)];
    [germanLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(132,20)];
    [germanLicence addAttribute:NSParagraphStyleAttributeName value:germanLicenceParaStyle1 range:NSMakeRange(152,19)];
    [germanLicence addAttribute:NSStrokeColorAttributeName value:germanLicenceColor1 range:NSMakeRange(152,19)];
    [germanLicence addAttribute:NSFontAttributeName value:germanLicenceFont2 range:NSMakeRange(152,19)];
    [germanLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(152,19)];
    [germanLicence addAttribute:NSUnderlineColorAttributeName value:germanLicenceColor1 range:NSMakeRange(171,9)];
    [germanLicence addAttribute:NSStrokeColorAttributeName value:germanLicenceColor1 range:NSMakeRange(171,9)];
    [germanLicence addAttribute:NSUnderlineStyleAttributeName value:@(1) range:NSMakeRange(171,9)];
    [germanLicence addAttribute:NSParagraphStyleAttributeName value:germanLicenceParaStyle1 range:NSMakeRange(171,9)];
    [germanLicence addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"https://en.wikipedia.org/wiki/File:BlankMap-World6-Equirectangular.svg"] range:NSMakeRange(171,9)];
    [germanLicence addAttribute:NSFontAttributeName value:germanLicenceFont2 range:NSMakeRange(171,9)];
    [germanLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(171,9)];
    [germanLicence addAttribute:NSParagraphStyleAttributeName value:germanLicenceParaStyle1 range:NSMakeRange(180,33)];
    [germanLicence addAttribute:NSStrokeColorAttributeName value:germanLicenceColor1 range:NSMakeRange(180,33)];
    [germanLicence addAttribute:NSFontAttributeName value:germanLicenceFont2 range:NSMakeRange(180,33)];
    [germanLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(180,33)];
    [germanLicence addAttribute:NSUnderlineColorAttributeName value:germanLicenceColor1 range:NSMakeRange(213,12)];
    [germanLicence addAttribute:NSStrokeColorAttributeName value:germanLicenceColor1 range:NSMakeRange(213,12)];
    [germanLicence addAttribute:NSUnderlineStyleAttributeName value:@(1) range:NSMakeRange(213,12)];
    [germanLicence addAttribute:NSParagraphStyleAttributeName value:germanLicenceParaStyle1 range:NSMakeRange(213,12)];
    [germanLicence addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"https://developer.apple.com/library/ios/samplecode/Reachability/Listings/Reachability_Reachability_h.html"] range:NSMakeRange(213,12)];
    [germanLicence addAttribute:NSFontAttributeName value:germanLicenceFont2 range:NSMakeRange(213,12)];
    [germanLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(213,12)];
    [germanLicence addAttribute:NSParagraphStyleAttributeName value:germanLicenceParaStyle1 range:NSMakeRange(225,66)];
    [germanLicence addAttribute:NSStrokeColorAttributeName value:germanLicenceColor1 range:NSMakeRange(225,66)];
    [germanLicence addAttribute:NSFontAttributeName value:germanLicenceFont2 range:NSMakeRange(225,66)];
    [germanLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(225,66)];
    [germanLicence addAttribute:NSUnderlineColorAttributeName value:germanLicenceColor1 range:NSMakeRange(291,13)];
    [germanLicence addAttribute:NSStrokeColorAttributeName value:germanLicenceColor1 range:NSMakeRange(291,13)];
    [germanLicence addAttribute:NSUnderlineStyleAttributeName value:@(1) range:NSMakeRange(291,13)];
    [germanLicence addAttribute:NSParagraphStyleAttributeName value:germanLicenceParaStyle1 range:NSMakeRange(291,13)];
    [germanLicence addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"http://www.dafont.com/always-forever.font"] range:NSMakeRange(291,13)];
    [germanLicence addAttribute:NSFontAttributeName value:germanLicenceFont2 range:NSMakeRange(291,13)];
    [germanLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(291,13)];
    [germanLicence addAttribute:NSParagraphStyleAttributeName value:germanLicenceParaStyle1 range:NSMakeRange(304,5)];
    [germanLicence addAttribute:NSStrokeColorAttributeName value:germanLicenceColor1 range:NSMakeRange(304,5)];
    [germanLicence addAttribute:NSFontAttributeName value:germanLicenceFont2 range:NSMakeRange(304,5)];
    [germanLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(304,5)];
    [germanLicence addAttribute:NSUnderlineColorAttributeName value:germanLicenceColor1 range:NSMakeRange(309,22)];
    [germanLicence addAttribute:NSStrokeColorAttributeName value:germanLicenceColor1 range:NSMakeRange(309,22)];
    [germanLicence addAttribute:NSUnderlineStyleAttributeName value:@(1) range:NSMakeRange(309,22)];
    [germanLicence addAttribute:NSParagraphStyleAttributeName value:germanLicenceParaStyle1 range:NSMakeRange(309,22)];
    [germanLicence addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"http://brittneymurphydesign.com/"] range:NSMakeRange(309,22)];
    [germanLicence addAttribute:NSFontAttributeName value:germanLicenceFont2 range:NSMakeRange(309,22)];
    [germanLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(309,22)];
    [germanLicence addAttribute:NSParagraphStyleAttributeName value:germanLicenceParaStyle1 range:NSMakeRange(331,93)];
    [germanLicence addAttribute:NSStrokeColorAttributeName value:germanLicenceColor1 range:NSMakeRange(331,93)];
    [germanLicence addAttribute:NSFontAttributeName value:germanLicenceFont2 range:NSMakeRange(331,93)];
    [germanLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(331,93)];
    [germanLicence addAttribute:NSUnderlineColorAttributeName value:germanLicenceColor1 range:NSMakeRange(424,34)];
    [germanLicence addAttribute:NSStrokeColorAttributeName value:germanLicenceColor1 range:NSMakeRange(424,34)];
    [germanLicence addAttribute:NSUnderlineStyleAttributeName value:@(1) range:NSMakeRange(424,34)];
    [germanLicence addAttribute:NSParagraphStyleAttributeName value:germanLicenceParaStyle1 range:NSMakeRange(424,34)];
    [germanLicence addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"https://github.com/lennet/languini"] range:NSMakeRange(424,34)];
    [germanLicence addAttribute:NSFontAttributeName value:germanLicenceFont2 range:NSMakeRange(424,34)];
    [germanLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(424,34)];
    
    return [[NSAttributedString alloc]initWithAttributedString:germanLicence];
}


- (NSAttributedString*)germanInfo
{
    // Create the attributed string
    NSMutableAttributedString *germanInfo = [[NSMutableAttributedString alloc]initWithString:
                                             @"Languini entstand 2015 im Rahmen des Kulturhackathons „Coding Da Vinci“.\n Der Datensatz wurde von Language Science Press bereitgestellt.\n\nLanguage Science Press veröffentlich frei verfügbare linguistische Literatur. Bisher wurden 15 Bücherreihen von 165 Autoren aus 31 Ländern und 5 Kontinenten veröffentlich.\nDas „CLLD“-Projekt entwickelt einen Datensatz, in dem unterschiedliche linguistische Daten miteinander verknüpft werden. Der Datensatz enthält momentan 10 Datensätze und eine große Anzahl lexikalischer Informationen, die man unter clld.org findet.\n"];
    
    // Declare the fonts
    UIFont *germanInfoFont1 = [UIFont fontWithName:@"Helvetica" size:14.0];
    
    // Declare the colors
    UIColor *germanInfoColor1 = [UIColor colorWithRed:0.000000 green:0.000000 blue:0.000000 alpha:1.000000];
    
    // Declare the paragraph styles
    NSMutableParagraphStyle *germanInfoParaStyle1 = [[NSMutableParagraphStyle alloc]init];
    germanInfoParaStyle1.alignment = NSTextAlignmentCenter;
    germanInfoParaStyle1.defaultTabInterval = 36;
    germanInfoParaStyle1.tabStops = @[[[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:28.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:56.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:84.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:112.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:140.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:168.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:196.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:224.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:252.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:280.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:308.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:336.000000 options:nil], ];
    
    
    // Create the attributes and add them to the string
    [germanInfo addAttribute:NSParagraphStyleAttributeName value:germanInfoParaStyle1 range:NSMakeRange(0,541)];
    [germanInfo addAttribute:NSStrokeColorAttributeName value:germanInfoColor1 range:NSMakeRange(0,541)];
    [germanInfo addAttribute:NSFontAttributeName value:germanInfoFont1 range:NSMakeRange(0,541)];
    [germanInfo addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(0,541)];
    [germanInfo addAttribute:NSUnderlineColorAttributeName value:germanInfoColor1 range:NSMakeRange(541,8)];
    [germanInfo addAttribute:NSStrokeColorAttributeName value:germanInfoColor1 range:NSMakeRange(541,8)];
    [germanInfo addAttribute:NSUnderlineStyleAttributeName value:@(1) range:NSMakeRange(541,8)];
    [germanInfo addAttribute:NSParagraphStyleAttributeName value:germanInfoParaStyle1 range:NSMakeRange(541,8)];
    [germanInfo addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"http://clld.org"] range:NSMakeRange(541,8)];
    [germanInfo addAttribute:NSFontAttributeName value:germanInfoFont1 range:NSMakeRange(541,8)];
    [germanInfo addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(541,8)];
    [germanInfo addAttribute:NSParagraphStyleAttributeName value:germanInfoParaStyle1 range:NSMakeRange(549,9)];
    [germanInfo addAttribute:NSStrokeColorAttributeName value:germanInfoColor1 range:NSMakeRange(549,9)];
    [germanInfo addAttribute:NSFontAttributeName value:germanInfoFont1 range:NSMakeRange(549,9)];
    [germanInfo addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(549,9)];
    
    return [[NSAttributedString alloc]initWithAttributedString:germanInfo];
}


- (NSAttributedString*)englishInfo
{
    // Create the attributed string
    NSMutableAttributedString *englishInfo = [[NSMutableAttributedString alloc]initWithString:
                                              @"\nLanguini was built 2015 as part of the culture hackathon „Coding Da Vinci“\n\nThe dataset was provided by Language Science Press.\n\n\n\nLanguage Science Press is an open access publisher\ncommitted to the accessibility and reusability of scientific work.\nThere are currently 15 books series with 165 editors from 31 countries\nand 5 continents.\nThe Cross-Linguistic Linked Data project is developing and\ncurating interoperable data publication structures using Linked Data\nprinciples as integration mechanism for distributed resources. There\nare currently 10 data repositories available at clld.org, and a large\nproject for lexical data has just been funded."];
    
    // Declare the fonts
    UIFont *englishInfoFont1 = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
    UIFont *englishInfoFont2 = [UIFont fontWithName:@"Helvetica" size:14.0];
    
    // Declare the colors
    UIColor *englishInfoColor1 = [UIColor colorWithRed:0.000000 green:0.000000 blue:0.000000 alpha:1.000000];
    UIColor *englishInfoColor2 = [UIColor colorWithRed:0.219608 green:0.431373 blue:1.000000 alpha:1.000000];
    
    // Declare the paragraph styles
    NSMutableParagraphStyle *englishInfoParaStyle1 = [[NSMutableParagraphStyle alloc]init];
    englishInfoParaStyle1.alignment = NSTextAlignmentCenter;
    englishInfoParaStyle1.defaultTabInterval = 36;
    englishInfoParaStyle1.tabStops = @[[[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:28.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:56.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:84.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:112.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:140.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:168.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:196.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:224.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:252.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:280.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:308.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:336.000000 options:nil], ];
    
    
    // Create the attributes and add them to the string
    [englishInfo addAttribute:NSParagraphStyleAttributeName value:englishInfoParaStyle1 range:NSMakeRange(0,1)];
    [englishInfo addAttribute:NSStrokeColorAttributeName value:englishInfoColor1 range:NSMakeRange(0,1)];
    [englishInfo addAttribute:NSFontAttributeName value:englishInfoFont1 range:NSMakeRange(0,1)];
    [englishInfo addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(0,1)];
    [englishInfo addAttribute:NSParagraphStyleAttributeName value:englishInfoParaStyle1 range:NSMakeRange(1,583)];
    [englishInfo addAttribute:NSStrokeColorAttributeName value:englishInfoColor1 range:NSMakeRange(1,583)];
    [englishInfo addAttribute:NSFontAttributeName value:englishInfoFont2 range:NSMakeRange(1,583)];
    [englishInfo addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(1,583)];
    [englishInfo addAttribute:NSForegroundColorAttributeName value:englishInfoColor2 range:NSMakeRange(584,8)];
    [englishInfo addAttribute:NSStrokeColorAttributeName value:englishInfoColor2 range:NSMakeRange(584,8)];
    [englishInfo addAttribute:NSUnderlineColorAttributeName value:englishInfoColor2 range:NSMakeRange(584,8)];
    [englishInfo addAttribute:NSUnderlineStyleAttributeName value:@(1) range:NSMakeRange(584,8)];
    [englishInfo addAttribute:NSParagraphStyleAttributeName value:englishInfoParaStyle1 range:NSMakeRange(584,8)];
    [englishInfo addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"http://clld.org/"] range:NSMakeRange(584,8)];
    [englishInfo addAttribute:NSFontAttributeName value:englishInfoFont2 range:NSMakeRange(584,8)];
    [englishInfo addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(584,8)];
    [englishInfo addAttribute:NSParagraphStyleAttributeName value:englishInfoParaStyle1 range:NSMakeRange(592,60)];
    [englishInfo addAttribute:NSStrokeColorAttributeName value:englishInfoColor1 range:NSMakeRange(592,60)];
    [englishInfo addAttribute:NSFontAttributeName value:englishInfoFont2 range:NSMakeRange(592,60)];
    [englishInfo addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(592,60)];
    
    return [[NSAttributedString alloc]initWithAttributedString:englishInfo];
}

- (NSAttributedString*)englishLicence
{
    // Create the attributed string
    NSMutableAttributedString *englishLicence = [[NSMutableAttributedString alloc]initWithString:
                                                 @"\nLanguini was built 2015 as part of the culture hackathon „Coding Da Vinci“\n\nThe dataset was provided by Language Science Press.\n\n\n\nLanguage Science Press is an open access publisher\ncommitted to the accessibility and reusability of scientific work.\nThere are currently 15 books series with 165 editors from 31 countries\nand 5 continents.\nThe Cross-Linguistic Linked Data project is developing and\ncurating interoperable data publication structures using Linked Data\nprinciples as integration mechanism for distributed resources. There\nare currently 10 data repositories available at clld.org, and a large\nproject for lexical data has just been funded."];
    
    // Declare the fonts
    UIFont *englishLicenceFont1 = [UIFont fontWithName:@"Helvetica-Bold" size:14.0];
    UIFont *englishLicenceFont2 = [UIFont fontWithName:@"Helvetica" size:14.0];
    
    // Declare the colors
    UIColor *englishLicenceColor1 = [UIColor colorWithRed:0.000000 green:0.000000 blue:0.000000 alpha:1.000000];
    UIColor *englishLicenceColor2 = [UIColor colorWithRed:0.219608 green:0.431373 blue:1.000000 alpha:1.000000];
    
    // Declare the paragraph styles
    NSMutableParagraphStyle *englishLicenceParaStyle1 = [[NSMutableParagraphStyle alloc]init];
    englishLicenceParaStyle1.alignment = NSTextAlignmentCenter;
    englishLicenceParaStyle1.defaultTabInterval = 36;
    englishLicenceParaStyle1.tabStops = @[[[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:28.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:56.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:84.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:112.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:140.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:168.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:196.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:224.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:252.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:280.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:308.000000 options:nil], [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:336.000000 options:nil], ];
    
    
    // Create the attributes and add them to the string
    [englishLicence addAttribute:NSParagraphStyleAttributeName value:englishLicenceParaStyle1 range:NSMakeRange(0,1)];
    [englishLicence addAttribute:NSStrokeColorAttributeName value:englishLicenceColor1 range:NSMakeRange(0,1)];
    [englishLicence addAttribute:NSFontAttributeName value:englishLicenceFont1 range:NSMakeRange(0,1)];
    [englishLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(0,1)];
    [englishLicence addAttribute:NSParagraphStyleAttributeName value:englishLicenceParaStyle1 range:NSMakeRange(1,583)];
    [englishLicence addAttribute:NSStrokeColorAttributeName value:englishLicenceColor1 range:NSMakeRange(1,583)];
    [englishLicence addAttribute:NSFontAttributeName value:englishLicenceFont2 range:NSMakeRange(1,583)];
    [englishLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(1,583)];
    [englishLicence addAttribute:NSForegroundColorAttributeName value:englishLicenceColor2 range:NSMakeRange(584,8)];
    [englishLicence addAttribute:NSStrokeColorAttributeName value:englishLicenceColor2 range:NSMakeRange(584,8)];
    [englishLicence addAttribute:NSUnderlineColorAttributeName value:englishLicenceColor2 range:NSMakeRange(584,8)];
    [englishLicence addAttribute:NSUnderlineStyleAttributeName value:@(1) range:NSMakeRange(584,8)];
    [englishLicence addAttribute:NSParagraphStyleAttributeName value:englishLicenceParaStyle1 range:NSMakeRange(584,8)];
    [englishLicence addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"http://clld.org/"] range:NSMakeRange(584,8)];
    [englishLicence addAttribute:NSFontAttributeName value:englishLicenceFont2 range:NSMakeRange(584,8)];
    [englishLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(584,8)];
    [englishLicence addAttribute:NSParagraphStyleAttributeName value:englishLicenceParaStyle1 range:NSMakeRange(592,60)];
    [englishLicence addAttribute:NSStrokeColorAttributeName value:englishLicenceColor1 range:NSMakeRange(592,60)];
    [englishLicence addAttribute:NSFontAttributeName value:englishLicenceFont2 range:NSMakeRange(592,60)];
    [englishLicence addAttribute:NSKernAttributeName value:@(0) range:NSMakeRange(592,60)];
    
    return [[NSAttributedString alloc]initWithAttributedString:englishLicence];
}

@end
