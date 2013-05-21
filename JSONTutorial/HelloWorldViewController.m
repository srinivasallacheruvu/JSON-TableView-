//
//  HelloWorldViewController.m
//  JSONTutorial
//
//  Created by Karthik on 21/05/13.
//  Copyright (c) 2013 Karthik. All rights reserved.
//

#import "HelloWorldViewController.h"

@interface HelloWorldViewController (){
    NSMutableData *webData;
    NSURLConnection *connection;
    NSMutableArray *array;
}

@end

@implementation HelloWorldViewController
@synthesize myTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self myTableView]setDelegate:self];
    [[self myTableView]setDataSource:self];
    array=[[NSMutableArray alloc]init];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [webData setLength:0];
    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [webData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"fail with error!");
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSDictionary *allDataDictionary=[NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    NSDictionary *feed=[allDataDictionary objectForKey:@"feed"];
    NSArray *arrayOfEntry=[feed objectForKey:@"entry"];
    for ( NSDictionary *diction in arrayOfEntry) {
        NSDictionary *title=[diction objectForKey:@"title"];
        NSString *label=[title objectForKey:@"label"];
        [array addObject:label];
        
    }
    [[self myTableView]reloadData];
}
- (IBAction)GetTop10Alubms:(id)sender {
    NSURL *url=[NSURL URLWithString:@"https://itunes.apple.com/us/rss/topalbums/limit=10/explicit=true/json"];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    connection=[NSURLConnection connectionWithRequest:request delegate:self];
    if (connection) {
        webData=[[NSMutableData alloc]init];
        }
    }

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [array count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Cellidentifier=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Cellidentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cellidentifier];
        
    }
    cell.textLabel.text=[array objectAtIndex:indexPath.row];
    return cell;
}

@end
