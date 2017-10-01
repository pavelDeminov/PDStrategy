//
//  StrategyContextTableViewCell.m
//  Commerce
//
//  Created by Pavel Deminov on 29/09/2017.
//  Copyright © 2017 Minimal Cafe. All rights reserved.
//

#import "PDStrategyContextTableViewCell.h"

@interface PDStrategyContextTableViewCell ()

@end

@implementation PDStrategyContextTableViewCell

+ (BOOL)dynamicHeight {
    return YES;
}

+ (CGFloat)defaultHeight {
    return 44;
}

- (void)setModel:(PDItemModel *)model {
    _model = model;
    [self updateUI];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(valueChanged) forControlEvents:(UIControlEventEditingChanged)];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)updateUI {
    PDItemModel *model = self.model;
    
    if (!self.model.object || [self.model.object isKindOfClass:[NSString class]]) {
        self.textField.text = model.object;
        self.valueLabel.text = model.object;
    }
    self.textField.placeholder = model.placeholder;
    self.iconImageView.image = model.icon;
    self.titleLabel.text = model.title;
    self.errorLabel.text = self.model.errorRule.error;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self updateUI];
    [self.delegate cellDidBeginEdit:self];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (void)valueChanged {
    self.model.object = self.textField.text;
}

@end
