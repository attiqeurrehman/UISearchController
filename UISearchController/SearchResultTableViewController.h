//
//  SearchResultTableViewController.h
//  UISearchController
//
//  Created by Attiqe Ur Rehman on 09/08/2015.
//  Copyright (c) 2015 arbisoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchResultDelegate <NSObject>

@optional

-(void)didShowFavourite;

@end

@interface SearchResultTableViewController : UITableViewController

@property (nonatomic, weak) id<SearchResultDelegate> delegate;

@end
