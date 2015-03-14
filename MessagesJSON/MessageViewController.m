//
//  ViewController.m
//  MessagesJSON
//
//  Created by Nalin Natrajan on 14/3/15.
//  Copyright (c) 2015 Nalin Natrajan. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController () <UITableViewDelegate, UITableViewDataSource>

@property NSArray *messagesArray;

@property (weak, nonatomic) IBOutlet UITableView *messageTableView;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"http://freezing-cloud-6077.herokuapp.com/messages.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue: [NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        self.messagesArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        [self.messageTableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messagesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCell" forIndexPath:indexPath];
    NSDictionary *messageDictionary = (NSDictionary *) [[self.messagesArray objectAtIndex:indexPath.row] objectForKey:@"message"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@, sent at: %@", [messageDictionary objectForKey:@"name"], [messageDictionary objectForKey:@"message_date"]];
    cell.detailTextLabel.text = [messageDictionary objectForKey:@"message"];
    
    return cell;
}

@end
