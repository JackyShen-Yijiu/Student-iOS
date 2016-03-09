//
//  JGUserTools.m
//  KongfuziStudent
//
//  Created by linhuijie on 3/13/15.
//  Copyright (c) 2015 kongfuzi. All rights reserved.
//
#import "JGUserTools.h"
#import <sqlite3.h>

//本地已经加载的所有用户，key为环信id
static NSMutableDictionary *usersDictionary;

//本地数据库句柄
static sqlite3 *db;
static BOOL isInitialized = NO;

const NSString* USER_TABLE = @"USERINFO";
const NSString* GROUP_TABLE = @"GROUPINFO";

NSString *sqlCreateUserInfoTable = nil;

NSString *sqlCreateGroupInfoTable = nil;

#define yikaojiuguodDBName @"yikaojiuguodDBName"

@implementation JGUserTools

+(void)execSql:(NSString *)sql
{
    char *err;
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库操作数据失败!error=%s", err);
    }
}

+(void) checkInitialization
{
    if(!isInitialized){
        [self initialize];
    }
}

+(void) initialize
{
    NSLog(@"CommonTools开始初始化...");
    
    sqlCreateUserInfoTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT, mid TEXT, nickname TEXT, avatar TEXT)", USER_TABLE];
    sqlCreateGroupInfoTable = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (ID INTEGER PRIMARY KEY AUTOINCREMENT, groupid TEXT, groupname TEXT, avatar TEXT, avatar_large TEXT)", GROUP_TABLE];
    
    isInitialized = NO;
    if(!usersDictionary){
        usersDictionary = [[NSMutableDictionary alloc] init];
    }
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES) lastObject];
    if([doc characterAtIndex:(doc.length-1)] != '/'){
        doc = [doc stringByAppendingString:@"/"];
    }
    NSString *fileName = [doc stringByAppendingString:[NSString stringWithFormat:@"%@.db",yikaojiuguodDBName]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:fileName]){
        [fileManager removeItemAtPath:fileName error:nil];
        NSLog(@"delete db file:%@", fileName);
    }
    const char* cFileName = [fileName UTF8String];
    int result = sqlite3_open(cFileName, &db);
    if(result != SQLITE_OK){
        sqlite3_close(db);
        NSLog(@"打开数据库失败！result=%d", result);
    }else{
        [self execSql:sqlCreateUserInfoTable];
        [self execSql:sqlCreateGroupInfoTable];
        NSLog(@"创建数据库成功！路径=%@", fileName);
    }
    isInitialized = YES;
    
}


/**
 *  保存用户信息
 *
 *  @param user 用户对象
 */
+ (void)saveKFZUser:(JGUserModel *) user
{
    [self checkInitialization];
    
    if(user != nil && user.userid != nil && ![user.userid  isEqual: @""]){
        
        @synchronized(usersDictionary){
            
            [usersDictionary setObject:user forKey:user.userid];
        
            NSString *sql = [NSString stringWithFormat:
                             @"INSERT OR REPLACE INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
                             USER_TABLE, @"mid", @"nickname", @"avatar", user.userid,user.nickname,user.originalpic];
            [self execSql:sql];
            
        }
            
    }
}

/**
 *根据环信ID获取对应的我们的服务器上的用户昵称和头像等信息
 */
+ (JGUserModel *) getKFZUserByEMUserName:(NSString *)mEMUserName
{
    [self checkInitialization];
    
    JGUserModel *user = [usersDictionary objectForKey:mEMUserName];
    
    if(user){
        
        return user;
        
    }else{
        
        [self queryUserFromRemoteAsync:mEMUserName];
    }
    return user;
}

/**
 *根据环信ID获取对应的我们的服务器上的用户昵称
 */
+ (NSString *) getNickNameByEMUserName:(NSString *)mEMUserName
{
    [self checkInitialization];
    NSLog(@"获取用户昵称:%@", mEMUserName);
    JGUserModel *user = [self getKFZUserByEMUserName:mEMUserName];
    if(user){
        NSLog(@"user.name:%@",user.nickname);
        return user.nickname;
    }
    return @"";
}

/**
 *根据环信ID获取对应的我们的服务器上的头像url
 */
+ (NSString *) getAvatarUrlByEMUserName:(NSString *)mEMUserName
{
    [self checkInitialization];
    JGUserModel *user = [[JGUserModel alloc] init];
    
    NSLog(@"获取用户头像:%@", mEMUserName);

    if (mEMUserName && [mEMUserName length]!=0) {
        user = [self getKFZUserByEMUserName:mEMUserName];
    }
    if(user){
        return user.originalpic;
    }
    return @"";
}

/**
 *根据本地数据库中保存的KFZUserObject对象，其中包含用户昵称和头像等信息
 */
+ (NSMutableDictionary *) loadKFZUserListDict
{
    NSLog(@"加载用户列表，从数据库");
    [self checkInitialization];
    NSString *sqlQuery = [NSString stringWithFormat:@"SELECT * FROM %@", USER_TABLE];
    sqlite3_stmt * statement;
    char *err;
    if (sqlite3_prepare_v2(db, [sqlQuery UTF8String], -1, &statement, &err) == SQLITE_OK) {
        @synchronized(usersDictionary){
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                NSString *mid = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
                NSString *nickname = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 2)];
                NSString *avatar = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 3)];
                
                NSLog(@"mid:%@ nickname:%@ avatar:%@",mid,nickname,avatar);
                
                JGUserModel *user = [[JGUserModel alloc] init];
                user.userid = mid;
                user.originalpic = avatar;
                user.nickname = nickname;
                [usersDictionary setObject:user forKey:mid];
                
                NSLog(@"mid:%@  nickname:%@  avatar:%@",mid, nickname, avatar);
                
            }
            
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_USERLOADED object:nil];
        
    }else{
        NSLog(@"操作数据库失败，err=%s", err);
    }
    
    NSLog(@"加载用户列表完成！");
    return usersDictionary;
    
}

/**
 *返回全局的KFZUserObject Dictionary对象，其中包含用户昵称和头像等信息
 */
+(NSMutableDictionary *) getKFZUserListDict
{
    [self checkInitialization];
    
    return usersDictionary;
}

+(JGUserModel *)queryUserFromRemote:(NSString *)mEMUsername
{
    NSLog(@"从远程同步加载用户信息...%@", mEMUsername);
    
    [self checkInitialization];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSString *subjecturl = [NSString stringWithFormat:kgetuserinfo,mEMUsername];
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,subjecturl];
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"从远程同步加载用户信息:%@",data);
        
        if ([data isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dictData = [data objectForKey:@"data"];
            
            NSDictionary *headportrait = [dictData objectForKey:@"headportrait"];
            
            NSLog(@"headportrait objectForKey:originalpic:%@",[headportrait objectForKey:@"originalpic"]);
            
            JGUserModel *globalUserObject = [[JGUserModel alloc] init];
            globalUserObject.userid = mEMUsername;
            globalUserObject.nickname = [dictData objectForKey:@"name"];
            globalUserObject.originalpic = [NSString stringWithFormat:@"%@",[headportrait objectForKey:@"originalpic"]];
            [self saveKFZUser:globalUserObject];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_USERLOADED object:nil];
            
        }
        
        dispatch_semaphore_signal(semaphore);
        
    } withFailure:^(id data) {
        dispatch_semaphore_signal(semaphore);
    }];

    // 等待5秒
    dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 0.0*NSEC_PER_SEC));
    
    JGUserModel *user = [usersDictionary objectForKey:mEMUsername];
    
    return user;
}

/**
 *  校验用户信息
 *
 *  @param mEMUsername 用户名
 */
+ (void)queryUserFromRemoteAsync:(NSString *)mEMUsername
{
    [self checkInitialization];
    
    if([usersDictionary objectForKey:mEMUsername]){
        return;
    }
    
    NSString *subjecturl = [NSString stringWithFormat:kgetuserinfo,mEMUsername];
    
    NSString *urlString = [NSString stringWithFormat:BASEURL,subjecturl];
    
    [JENetwoking startDownLoadWithUrl:urlString postParam:nil WithMethod:JENetworkingRequestMethodGet withCompletion:^(id data) {
        
        NSLog(@"校验用户信息:%@",data);
        
        if ([data isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dictData = [data objectForKey:@"data"];
            
            NSDictionary *headportrait = [dictData objectForKey:@"headportrait"];
            
            JGUserModel *globalUserObject = [[JGUserModel alloc] init];
            globalUserObject.userid = mEMUsername;
            globalUserObject.nickname = [dictData objectForKey:@"name"];
            globalUserObject.originalpic = [NSString stringWithFormat:@"%@",[headportrait objectForKey:@"originalpic"]];
            [self saveKFZUser:globalUserObject];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_USERLOADED object:nil];
            
        }
        
    } withFailure:^(id data) {
    }];
    
    

}

@end


