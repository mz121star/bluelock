
#import "XCUtils.h"
#import "BLAppDelegate.h"


static NSString *kUserToken = @"usertoken";
static NSString *kUsername = @"username";
static NSString *kUserID = @"uid";
static NSString *kUserInfo = @"userInfo";
static NSString *kInviteCode = @"inviteCode";

static NSString *kAddressBTC = @"btc_address";
static NSString *kAddressCOC = @"coc_address";
static NSString *kAddressETC = @"etc_address";
static NSString *kAddressETH = @"eth_address";
static NSString *kAddressZEC = @"zec_address";


@implementation XCUtils

+ (__kindof UIViewController *)applicationRootViewController {
    UIApplication *app = [UIApplication sharedApplication];
    BLAppDelegate *delegate = (BLAppDelegate *)app.delegate;
    UIWindow *keyWindow = delegate.window;
    return keyWindow.rootViewController;
}

@end

@implementation UserInfo

+ (NSUserDefaults *)info {
    return [NSUserDefaults standardUserDefaults];
}

+ (void)storage:(id)obj key:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - 用户 Token
+ (void)userToken:(NSString *)token {
    [self storage:token key:kUserToken];
    
}
+ (NSString *)userToken {
    return [[self info] objectForKey:kUserToken];
}
#pragma mark - 用户名
+ (void)username:(NSString *)username {
    [self storage:username key:kUsername];
}
+ (NSString *)username {
    return [[self info] objectForKey:kUsername];
}
#pragma mark - 用户id
+ (void)uID:(NSString *)userID {
    [self storage:userID key:kUserID];
}
+ (NSString *)uID {
    return [[self info] objectForKey:kUserID];
}
#pragma mark - 用户邀请码
+ (void)inviteCode:(NSString *)inviteCode {
    [self storage:inviteCode key:kInviteCode];
}
+ (NSString *)inviteCode {
    return [[self info] objectForKey:kInviteCode];
}

#pragma mark - Addresses
+ (void)addressBTC:(NSString *)btc_address {
    [self storage:btc_address key:kAddressBTC];
}
+ (NSString *)addressBTC {
    return [[self info] objectForKey:kAddressBTC];
}
+ (void)addressCOC:(NSString *)coc_address {
    [self storage:coc_address key:kAddressCOC];
}
+ (NSString *)addressCOC {
    return [[self info] objectForKey:kAddressCOC];
}
+ (void)addressETC:(NSString *)etc_address {
    [self storage:etc_address key:kAddressETC];
}
+ (NSString *)addressETC {
    return [[self info] objectForKey:kAddressETC];
}
+ (void)addressETH:(NSString *)eth_address {
    [self storage:eth_address key:kAddressETH];
}
+ (NSString *)addressETH {
    return [[self info] objectForKey:kAddressETH];
}
+ (void)addressZEC:(NSString *)zec_address {
    [self storage:zec_address key:kAddressZEC];
}
+ (NSString *)addressZEC {
    return [[self info] objectForKey:kAddressZEC];
}


@end

#import <CommonCrypto/CommonDigest.h>
@implementation NSString (MD5)

- (NSString *)MD5Digest
{
    const char* input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

@end


@implementation XCGlobal

static XCGlobal * kSingleton = nil;

+ (instancetype)global {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kSingleton = [[self alloc] init];
    });
    
    return kSingleton;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

+ (UIWindow *)keyWindow {
    // Default case: iterate over UIApplication windows
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow]; // as default.
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
        
        if(windowOnMainScreen && windowIsVisible && windowLevelNormal) {
            keyWindow = window;
            break;
        }
    }
    return keyWindow;
}

@end



