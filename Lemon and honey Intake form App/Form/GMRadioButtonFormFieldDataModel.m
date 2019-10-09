//
//  GMCheckBoxFormFieldDataModel.m
//  Lemon and honey Intake form App
//
//  Created by Gurpreet Singh on 23/02/17.
//  Copyright © 2017 Gurie. All rights reserved.
//

#import "GMRadioButtonFormFieldDataModel.h"
#import "GMRadioButtonFormFieldCell.h"
#import "FORMFieldValue.h"
#import "GMRadioButtonFormFieldCollectionViewCell.h"

#define reuseIdentifier @"cell"

@interface GMRadioButtonFormFieldDataModel ()<GMRadioButtonFormFieldCollectionViewCellDelegate>

@property (nonatomic, assign) UICollectionView * collectionView;
@property (nonatomic, retain) NSMutableArray * selectedValues;

@end

@implementation GMRadioButtonFormFieldDataModel

+(instancetype)modelFor:(UICollectionView *)collectionView {
    GMRadioButtonFormFieldDataModel * model = [GMRadioButtonFormFieldDataModel new];
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
    [self.collectionView reloadData];
}

-(void)registerCell {
    [self.collectionView registerNib:[UINib nibWithNibName:@"GMRadioButtonFormFieldCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.field.values.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GMRadioButtonFormFieldCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    FORMFieldValue * value = self.field.values[indexPath.row];
    cell.value = value;
    cell.delegate = self;
    
    cell.radioButton.selected = ([value.title isEqual:self.field.value]);
    
    if (self.field.value && self.field.values.count == 2) {
        
        if ([value.title isEqualToString:@"Yes"]) {
            if(self.field.value)
                cell.radioButton.selected = [self.field.value boolValue];
        }
        if ([value.title isEqualToString:@"No"]) {
            if(self.field.value)
                cell.radioButton.selected =![self.field.value boolValue]; //;
        }
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((CGRectGetWidth(collectionView.frame)/[self itemsInRow]) - 11, 60);
}

-(NSInteger)itemsInRow {
    return MIN(2, self.field.values.count);
}

-(void)fieldValue:(FORMFieldValue *)value selected:(BOOL)seleted {
    
    self.field.value = (seleted)?value.title:nil;
    [self.collectionView reloadData];
    [self.delegate dataUpdatesDoneFor:self];
}

@end
