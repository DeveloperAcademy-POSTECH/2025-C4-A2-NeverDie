#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The resource bundle ID.
static NSString * const ACBundleID AC_SWIFT_PRIVATE = @"com.academy.NeverDie";

/// The "black01" asset catalog color resource.
static NSString * const ACColorNameBlack01 AC_SWIFT_PRIVATE = @"black01";

/// The "blue01" asset catalog color resource.
static NSString * const ACColorNameBlue01 AC_SWIFT_PRIVATE = @"blue01";

/// The "brown01" asset catalog color resource.
static NSString * const ACColorNameBrown01 AC_SWIFT_PRIVATE = @"brown01";

/// The "brown02" asset catalog color resource.
static NSString * const ACColorNameBrown02 AC_SWIFT_PRIVATE = @"brown02";

/// The "grayCaption00" asset catalog color resource.
static NSString * const ACColorNameGrayCaption00 AC_SWIFT_PRIVATE = @"grayCaption00";

/// The "grayCaption01" asset catalog color resource.
static NSString * const ACColorNameGrayCaption01 AC_SWIFT_PRIVATE = @"grayCaption01";

/// The "grayCaption02" asset catalog color resource.
static NSString * const ACColorNameGrayCaption02 AC_SWIFT_PRIVATE = @"grayCaption02";

/// The "grayCaption03" asset catalog color resource.
static NSString * const ACColorNameGrayCaption03 AC_SWIFT_PRIVATE = @"grayCaption03";

/// The "green01" asset catalog color resource.
static NSString * const ACColorNameGreen01 AC_SWIFT_PRIVATE = @"green01";

/// The "green02" asset catalog color resource.
static NSString * const ACColorNameGreen02 AC_SWIFT_PRIVATE = @"green02";

/// The "green03" asset catalog color resource.
static NSString * const ACColorNameGreen03 AC_SWIFT_PRIVATE = @"green03";

/// The "greenChart01Linear01" asset catalog color resource.
static NSString * const ACColorNameGreenChart01Linear01 AC_SWIFT_PRIVATE = @"greenChart01Linear01";

/// The "greenChart01Linear02" asset catalog color resource.
static NSString * const ACColorNameGreenChart01Linear02 AC_SWIFT_PRIVATE = @"greenChart01Linear02";

/// The "greenChart02" asset catalog color resource.
static NSString * const ACColorNameGreenChart02 AC_SWIFT_PRIVATE = @"greenChart02";

/// The "orange01" asset catalog color resource.
static NSString * const ACColorNameOrange01 AC_SWIFT_PRIVATE = @"orange01";

/// The "white01" asset catalog color resource.
static NSString * const ACColorNameWhite01 AC_SWIFT_PRIVATE = @"white01";

#undef AC_SWIFT_PRIVATE
