//
//  GMCheckBoxFormFieldDataModel.m
//  Lemon and honey Intake form App
//
//  Created by Gurpreet Singh on 23/02/17.
//  Copyright © 2017 Gurie. All rights reserved.
//

#import "GMCheckBoxFormFieldDataModel.h"
#import "GMCheckBoxFormFieldCollectionViewCell.h"
#import "FORMFieldValue.h"

#define reuseIdentifier @"cell"

@interface GMCheckBoxFormFieldDataModel ()<GMCheckBoxFormFieldCollectionViewCellDelegate>

@property (nonatomic, assign) UICollectionView * collectionView;
@property (nonatomic, retain) NSMutableArray * selectedValues;

@end

@implementation GMCheckBoxFormFieldDataModel

+(instancetype)modelFor:(UICollectionView *)collectionView {
    GMCheckBoxFormFieldDataModel * model = [GMCheckBoxFormFieldDataModel new];
    model.collectionView = collectionView;
    collectionView.delegate = model;
    collectionView.dataSource = model;
    [model registerCell];
    return model;
}

-(NSMutableArray *)selectedValues {
    if (!_selectedValues) {
        _selectedValues = [NSMutableArray new];
    }
    return _selectedValues;
}

-(void)setField:(FORMField *)field {
    _field = field;
    [self.selectedValues removeAllObjects];
    NSArray * array = [self.field.value componentsSeparatedByString:@","];
    [self.selectedValues addObjectsFromArray:array];    
    [self.collectionView reloadData];
}

-(void)registerCell {
    [self.collectionView registerNib:[UINib nibWithNibName:@"GMCheckBoxFormFieldCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.field.values.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GMCheckBoxFormFieldCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    FORMFieldValue * value = self.field.values[indexPath.row];
    cell.value = value;
    cell.delegate = self;
    
    cell.checkBox.selected = [self.field.value containsString:value.title] || [self.field.value isEqual:@"1"];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FORMFieldValue * values = self.field.values[indexPath.row];
    CGFloat height = [self heightForText:values.title maxWidth:(CGRectGetWidth(collectionView.frame)/[self itemsInRow])+50];

    return CGSizeMake((CGRectGetWidth(collectionView.frame)/[self itemsInRow]) - 11, height*2);
}
-(CGFloat)heightForText:(NSString *)text maxWidth:(CGFloat)width {
    
    CGSize constraint = CGSizeMake(width, 20000.0f);
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    return size.height;
}
-(NSInteger)itemsInRow {
    return MIN(2, self.field.values.count);
}

-(void)fieldValue:(FORMFieldValue *)value selected:(BOOL)seleted
{
    if (self.field.value && self.selectedValues.count == 0) {
        NSArray * array = [self.field.value componentsSeparatedByString:@","];
        [self.selectedValues addObjectsFromArray:array];
    }

    if (seleted) {
        [self.selectedValues addObject:value.title];
    }else {
        [self.selectedValues removeObject:value.title];
    }
    
    if (self.selectedValues.count) {
        //-- if only have one value we are assuming it as Agree/Disagree checkbox.
        if (self.field.values.count == 1) {
            self.field.value = @"1";
        }else {
            //-- for multiple checkboxes
            self.field.value = [self.selectedValues componentsJoinedByString:@","];
        }
    }else {
        self.field.value = nil;
    }
    
    [self.delegate dataUpdatesDoneFor:self];
}

@end
