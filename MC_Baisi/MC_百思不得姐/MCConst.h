


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MCTopicType){
    MCTopicTypeAll = 1,
    MCTopicTypeVideo = 41,
    MCTopicTypeVoice = 31,
    MCTopicTypePicture = 10,
    MCTopicTypeWord = 29,    
};
/** 精华标题栏高度 */
UIKIT_EXTERN CGFloat const MCTitleViewH;
/** 精华标题栏y坐标 */
UIKIT_EXTERN CGFloat const MCTitleViewY;

/** Cell的margin */
UIKIT_EXTERN CGFloat const MCTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const MCTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const MCTopicCellBottomBarH;

/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const MCTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
UIKIT_EXTERN CGFloat const MCTopicCellPictureBreakH;

/** 最热评论标题高度 */
UIKIT_EXTERN CGFloat const MCTopicCellTopCmtTitleH;

UIKIT_EXTERN NSString * const MCUserSexMale;
UIKIT_EXTERN NSString * const MCUserSexFemale;

UIKIT_EXTERN NSString * const MCTabBarDidSelectNotification;

