//
//  CategoryTableViewCell.m
//  Kucharka
//
//  Created by Jiri Urbasek on 3/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CategoryTableViewCell.h"
#import "CategoryTableItem.h"


@implementation CategoryTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier]) {
         _item = nil; 
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////  
// TTTableViewCell  

- (id)object {  
    return _item;  
}  


- (void)setObject:(id)object {  
    if (_item != object) {  
        [super setObject:object];  
				 
        self.textLabel.textAlignment = UITextAlignmentRight;
        self.detailTextLabel.textAlignment = UITextAlignmentLeft;
    }  
}

static const CGFloat kHPadding = 10;
static const CGFloat kVPadding = 10;
static const CGFloat kMargin = 10;
static const CGFloat kSmallMargin = 6;
static const CGFloat kSpacing = 8;
static const CGFloat kControlPadding = 8;
static const CGFloat kDefaultTextViewLines = 5;
static const CGFloat kMoreButtonMargin = 40;

static const CGFloat kKeySpacing = 12;
static const CGFloat kKeyWidth = 75;
static const CGFloat kMaxLabelHeight = 2000;
static const CGFloat kDisclosureIndicatorWidth = 23;

static const NSInteger kMessageTextLineCount = 2;

static const CGFloat kDefaultImageSize = 50;
static const CGFloat kDefaultMessageImageWidth = 34;
static const CGFloat kDefaultMessageImageHeight = 34;

- (void)layoutSubviews {
	[super layoutSubviews];
    
	self.textLabel.frame = CGRectMake(140, kVPadding + 2,
									  150, self.textLabel.font.ttLineHeight);
	
	CGFloat valueWidth = self.contentView.width - (kHPadding*2 + kKeyWidth + kKeySpacing);
	CGFloat innerHeight = self.contentView.height - kVPadding*2;
	self.detailTextLabel.frame = CGRectMake(kHPadding, kVPadding,
											valueWidth, innerHeight);
}


@end
