//
//  HelloWorldViewController.h
//  JSONTutorial
//
//  Created by Karthik on 21/05/13.
//  Copyright (c) 2013 Karthik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelloWorldViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLConnectionDataDelegate>
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
- (IBAction)GetTop10Alubms:(id)sender;

@end
