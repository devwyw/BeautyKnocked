//
//  SearchController.h
//  BeautyKnocked
//
//  Created by Mac on 2017/7/21.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchTextDelegate <NSObject>

-(void)SearchField:(NSString *)text;

@end

@interface SearchController : UIViewController
@property (nonatomic,strong) id<SearchTextDelegate> searchDelegate;
@property (nonatomic,copy) NSString * text;
@end
