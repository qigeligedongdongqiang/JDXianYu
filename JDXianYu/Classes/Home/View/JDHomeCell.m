//
//  JDHomeCell.m
//  JDXianYu
//
//  Created by JADON on 16/8/26.
//  Copyright © 2016年 JADON. All rights reserved.
//

#import "JDHomeCell.h"
#import "JDHomeNormalCell.h"

@interface JDHomeCell()
@property (weak, nonatomic) IBOutlet UILabel *headLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *footLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgFrontView;
@property (weak, nonatomic) IBOutlet UIImageView *imgBackView;

@end



@implementation JDHomeCell

- (void)setHomeCell:(JDHomeNormalCell *)homeCell {
    _homeCell = homeCell;
    self.headLabel.text = homeCell.head;
    self.descriptionLabel.text = homeCell.selfDescription;
    self.footLabel.text = homeCell.foot;
    self.imgFrontView.image = [UIImage imageNamed:homeCell.img1];
    self.imgBackView.image  = [UIImage imageNamed:homeCell.img2];
}

+ (instancetype)homeCellWithTableView:(UITableView *)tableView {
    static NSString *reuseId = @"normalCell";
    JDHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JDHomeCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
