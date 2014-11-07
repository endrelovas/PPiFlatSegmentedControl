//
//  ViewController.m
//  PPiFlatSegmentedControl-Demo
//
//  Created by Pedro Piñera Buendía on 12/08/13.
//  Copyright (c) 2013 PPinera. All rights reserved.
//

#import "ViewController.h"
#import "PPiFlatSegmentedControl.h"
#import "NSString+FontAwesome.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *items = @[[[PPiFlatSegmentItem alloc] initWithTitle:@"Face" andIcon:@"icon-facebook"],
                       [[PPiFlatSegmentItem alloc] initWithTitle:@"Linkedin" andIcon:@"icon-linkedin"],
                       [[PPiFlatSegmentItem alloc] initWithTitle:@"Twitter" andIcon:@"icon-twitter"]];
    PPiFlatSegmentedControl *segmented=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(20, 20, 250, 30)
                                                                                items:items
                                                                         iconPosition:IconPositionRight
                                                                    andSelectionBlock:^(NSUInteger segmentIndex) {}
                                                                       iconSeparation:5];
    segmented.color=[UIColor colorWithRed:88.0f/255.0 green:88.0f/255.0 blue:88.0f/255.0 alpha:1];
    segmented.borderWidth=0.5;
    segmented.borderColor= [UIColor colorWithRed:0.0f/255.0 green:141.0f/255.0 blue:147.0f/255.0 alpha:1];
    segmented.selectedColor=[UIColor colorWithRed:0.0f/255.0 green:141.0f/255.0 blue:147.0f/255.0 alpha:1];
    segmented.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                               NSForegroundColorAttributeName:[UIColor whiteColor]};
    segmented.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                       NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.view addSubview:segmented];
    

    NSArray *items2 = @[[[PPiFlatSegmentItem alloc] initWithTitle:@"Linkedin" andIcon:@"icon-linkedin"],
                       [[PPiFlatSegmentItem alloc] initWithTitle:@"Twitter" andIcon:@"icon-twitter"]];
    PPiFlatSegmentedControl *segmented2=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(20, 80, 250, 30)
                                                                                 items:items2
                                                                          iconPosition:IconPositionRight
                                                                     andSelectionBlock:^(NSUInteger segmentIndex) { }
                                                                        iconSeparation:5];
    segmented2.color=[UIColor whiteColor];
    segmented2.borderWidth=0.5;
    segmented2.borderColor=[UIColor colorWithRed:244.0f/255.0 green:67.0f/255.0 blue:60.0f/255.0 alpha:1];
    segmented2.selectedColor=[UIColor colorWithRed:244.0f/255.0 green:67.0f/255.0 blue:60.0f/255.0 alpha:1];
    segmented2.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                               NSForegroundColorAttributeName:[UIColor colorWithRed:244.0f/255.0 green:67.0f/255.0 blue:60.0f/255.0 alpha:1]};
    segmented2.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                       NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.view addSubview:segmented2];

    NSArray *items3 = @[[[PPiFlatSegmentItem alloc] initWithTitle:@"Facebook" andIcon:@"icon-facebook"],
                        [[PPiFlatSegmentItem alloc] initWithTitle:@"Twitter" andIcon:@"icon-twitter"],
                        [[PPiFlatSegmentItem alloc] initWithTitle:@"Cloud" andIcon:@"icon-cloud"]];
    PPiFlatSegmentedControl *segmented3=[[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(20, 140, 250, 30)
                                                                                 items:items3
                                                                          iconPosition:IconPositionRight
                                                                     andSelectionBlock:^(NSUInteger segmentIndex) {}
                                                                        iconSeparation:0];
    segmented3.color=[UIColor colorWithRed:88.0f/255.0 green:88.0f/255.0 blue:88.0f/255.0 alpha:1];
    segmented3.borderWidth=0.5;
    segmented3.borderColor=[UIColor darkGrayColor];
    segmented3.selectedColor=[UIColor colorWithRed:0.0f/255.0 green:141.0f/255.0 blue:176.0f/255.0 alpha:1];
    segmented3.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                               NSForegroundColorAttributeName:[UIColor whiteColor]};
    segmented3.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:13],
                                       NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.view addSubview:segmented3];
    [segmented3 setItems:items2];
    
    
    PPiFlatSegmentedControl *segmentControl = [[PPiFlatSegmentedControl alloc] initWithFrame:CGRectMake(20, 200, 250, 30)
                                                              items:@[[[PPiFlatSegmentItem alloc] initWithTitle:NSLocalizedString(@"Friends", nil) andIcon:nil], [[PPiFlatSegmentItem alloc] initWithTitle:NSLocalizedString(@"Everyone", nil) andIcon:nil]]
                                                       iconPosition:IconPositionRight andSelectionBlock:^(NSUInteger segmentIndex) {
                                                           // code here
                                                       }
                                                     iconSeparation:0];
    segmentControl.layer.cornerRadius = 0;
    segmentControl.color=[UIColor colorWithRed:235.0f/255.0 green:179.0f/255.0 blue:125.0f/255.0 alpha:1];
    segmentControl.borderWidth=.5;
    
    segmentControl.borderColor=[UIColor whiteColor];
    segmentControl.selectedColor=[UIColor colorWithRed:228.0f/255.0 green:153.0f/255.0 blue:81.0f/255.0 alpha:1];
    segmentControl.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:16],
                                    NSForegroundColorAttributeName:[UIColor whiteColor]};
    segmentControl.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:16],
                                            NSForegroundColorAttributeName:[UIColor whiteColor]};
    [self.view addSubview:segmentControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
