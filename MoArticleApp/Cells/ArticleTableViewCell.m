//
//  ArticleTableViewCell.m
//  MoArticleApp
//
//  Created by Abhinav Singh on 5/3/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

#import "ArticleTableViewCell.h"

@implementation ArticleTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse{
    [super prepareForReuse];
    self.delegate = nil;
    [self.dataTask cancel];
    self.dataTask = nil;
    [self.articleImgView setImage:nil];
}

-(void)configure:(Article*) value andImageCache:(NSCache*)imageFromCache{
    [self.articleTitle setText:value.title];
    [self.articleAuthor setText:value.author];
    [self.articleDescription setText:value.desc];
    [self.articleSource setText:value.source_name];
    [self.articleTime setText:[self convertDateToString:value.publishedAt]];
    if(self.dataTask == nil) {
        self.dataTask = [self.articleImgView loadImageUsingUrlString:value.urlToImage :imageFromCache];
    }
    
}

-(NSString*)convertDateToString:(NSDate*) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}

- (IBAction)saveForOffline:(UIButton *)sender {
    [self.delegate saveArchiveUrl:(long)sender.tag];
}


@end
