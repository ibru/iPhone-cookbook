#import "TabBarController.h"

@implementation TabBarController

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController

- (void)viewDidLoad {
  [self setTabURLs:[NSArray arrayWithObjects:@"tt://category/init",	//category controller with id = init
                                             @"tt://search",
                                             @"tt://grocery",
                                             @"tt://archive",
                                             @"tt://extras",
                                             nil]];
}

@end
