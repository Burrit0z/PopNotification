#import "Tweak.h"

static void hooked_NCNSLVC_handleTap (NCNotificationShortLookViewController *self, SEL cmd, UITapGestureRecognizer *gestureRecognizer) {
    // verify the view is the right class
    if([self.view isKindOfClass:objc_getClass("NCNotificationViewControllerView")]) {
        @try {
            // get the shortlook view and cell
            NCNotificationShortLookView *shortView = ((NCNotificationViewControllerView *)self.view).contentView;
            NCNotificationListCell *cell = (NCNotificationListCell *)self.view.superview.superview;

            // 1 count notifications are "grouped"
            BOOL multiGrouped = ([cell.delegate.groupListView isGrouped] && [cell.delegate.groupListView count] > 1);

            // try to avoid groups and banners
            if(!multiGrouped && ![shortView _isBanner]) {
                // get the cell (NCNotificationListCell)
                [cell _executeDefaultAction];
                return;
            }

        } @catch (NSException *exc) {
        }
    }
    orig_NCNSLVC_handleTap(self, cmd, gestureRecognizer);
}

__attribute__((constructor)) static void loadTweak(__unused int argc, __unused char **argv, __unused char **envp) {
    // tweak constructor
    MSHookMessageEx(objc_getClass("NCNotificationShortLookViewController"),
       @selector(_handleTapOnView:),
       (IMP) &hooked_NCNSLVC_handleTap,
       (IMP *) &orig_NCNSLVC_handleTap);

    NSLog(@"[popnotification]: Loaded");

}
