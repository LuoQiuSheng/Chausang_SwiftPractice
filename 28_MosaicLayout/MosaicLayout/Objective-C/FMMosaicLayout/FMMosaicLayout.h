//
// FMMosaicLayout.h
// FMMosaicLayout
//

#import <UIKit/UIKit.h>

@class FMMosaicLayout;

typedef NS_ENUM(NSUInteger, FMMosaicCellSize) {
    FMMosaicCellSizeSmall,
    FMMosaicCellSizeBig
};

@protocol FMMosaicLayoutDelegate <UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(FMMosaicLayout *)collectionViewLayout numberOfColumnsInSection:(NSInteger)section;

@optional

- (FMMosaicCellSize)collectionView:(UICollectionView *)collectionView layout:(FMMosaicLayout *)collectionViewLayout mosaicCellSizeForItemAtIndexPath:(NSIndexPath *)indexPath;
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(FMMosaicLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(FMMosaicLayout *)collectionViewLayout interitemSpacingForSectionAtIndex:(NSInteger)section;

// Header/Footer
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(FMMosaicLayout *)collectionViewLayout
 heightForHeaderInSection:(NSInteger)section;
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(FMMosaicLayout *)collectionViewLayout
 heightForFooterInSection:(NSInteger)section;
- (BOOL)headerShouldOverlayContentInCollectionView:(UICollectionView *)collectionView
                                            layout:(FMMosaicLayout *)collectionViewLayout;
- (BOOL)footerShouldOverlayContentInCollectionView:(UICollectionView *)collectionView
                                            layout:(FMMosaicLayout *)collectionViewLayout;

@end

@interface FMMosaicLayout : UICollectionViewLayout

// Not used, just for backwards compatability
@property (nonatomic, weak) id<FMMosaicLayoutDelegate> delegate;

@end
