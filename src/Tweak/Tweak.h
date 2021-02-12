#import <UIKit/UIKit.h>
#import <substrate.h>
#import <objc/runtime.h>

@interface NCNotificationShortLookViewController : UIViewController
- (void)_handleTapOnView:(UITapGestureRecognizer *)gestureRecognizer;
@end

@interface NCNotificationListView : UIScrollView
@property (nonatomic, assign) NSUInteger count;
- (BOOL)isGrouped;
@end

@interface NCNotificationGroupList : NSObject
@property (nonatomic, strong) NCNotificationListView *groupListView;
@end

@interface NCNotificationListCell : UIView
@property (nonatomic, strong) NCNotificationGroupList *delegate;
- (void)_executeDefaultAction;
@end

@interface NCNotificationShortLookView : UIView
@property (nonatomic, strong) NCNotificationGroupList *delegate;
- (BOOL)_isBanner;
- (BOOL)_axIsGrouped;
@end

@interface NCNotificationViewControllerView : UIView
@property (nonatomic, strong) NCNotificationShortLookView *contentView;
@end

// hooks
// NCNSLVC = NCNotificationShortLookViewController
static void (*orig_NCNSLVC_handleTap) (NCNotificationShortLookViewController *, SEL, UITapGestureRecognizer *);
static void hooked_NCNSLVC_handleTap (NCNotificationShortLookViewController *, SEL, UITapGestureRecognizer *);
