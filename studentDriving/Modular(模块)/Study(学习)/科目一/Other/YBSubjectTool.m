//
//  YBSubjectTool.m
//  studentDriving
//
//  Created by JiangangYang on 16/4/9.
//  Copyright © 2016年 jatd. All rights reserved.
//

#import "YBSubjectTool.h"
#import "ZipArchive.h"
#import "FMDB.h"
#import "YBSubjectData.h"

@interface YBSubjectTool ()

@end

@implementation YBSubjectTool

static FMDatabaseQueue *_queue;

+ (void)zipArchiveSubjectDataWithArchive:(zipArchiveBlock)zipArchiveBlock
{
    
    ZipArchive* zip = [[ZipArchive alloc] init];

    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSArray *fileArray = [fileManager subpathsOfDirectoryAtPath:YBSubjectPath error:nil];
    
    BOOL isExist = false;
    for (NSString *str in fileArray) {
        NSLog(@"fileManager str:%@",str);
        if ([str hasPrefix:@"ggtkFile"]) {
            isExist = YES;
            break;
        }
    }
    NSLog(@"fileManager isExist:%d",isExist);
    
    if (isExist) {
        
        NSLog(@"文件存在，读取文件");
        zipArchiveBlock(YES,YES);

    }else{
        
        NSString* unzipto = [YBSubjectPath stringByAppendingString:@"/ggtkFile"] ;

        NSLog(@"文件不存在");
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"ggtkFile"] ofType:@"zip"];

        if([zip UnzipOpenFile:path])
        {
            
            NSLog(@"压缩包存在");
            
            BOOL ret = [zip UnzipFileTo:unzipto overWrite:YES];
            if(ret)
            {
                NSLog(@"解压成功");
                zipArchiveBlock(NO,YES);
                
            }else{
                
                NSLog(@"解压失败");
                zipArchiveBlock(NO,NO);
                
            }
            
            [zip UnzipCloseFile];
            
        }
        
    }
    
}

+ (NSArray *)getAllSubjectDataWithType:(subjectType)type
{
    __block NSArray *tempArray = [NSArray array];
    
    [self zipArchiveSubjectDataWithArchive:^(BOOL fileIsExit, BOOL archiveResult) {
        
        if (fileIsExit) {// 文件存在
            
            tempArray = [self getAllSubjectChapterWithType:type];
            
        }else{// 文件不存在
            
            if (archiveResult) {// 解压成功
                
                tempArray = [self getAllSubjectChapterWithType:type];
                
            }else{// 解压失败
                
                
            }
            
        }
        
    }];
    
    return tempArray;
}

// 获取指定科目的章节
+ (NSArray *)getAllSubjectChapterWithType:(subjectType)type
{
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    NSString *dbPath = [YBSubjectPath stringByAppendingString:@"/ggtkFile/ggtk_20151201.db"];
    NSLog(@"获取指定科目的章节dbPath:%@",dbPath);
  
    FMDatabase *dataBase = [FMDatabase databaseWithPath:dbPath];
    
    if (dataBase) {
        
        [dataBase open];
        
        NSString *sql = @"";
        switch (type) {
            case subjectOne:
                
                sql = [NSString stringWithFormat:@"SELECT c.title as title ,c.id as id, '0'||c.mid as mid, count(c.id) as count FROM Chapter c, web_note w WHERE c.kemu = %ld AND w.kemu=%ld AND (c.id = 1 OR c.id = 2 OR c.id = 3 OR c.id = 4) AND w.chapterid = c.id AND ( w.strTppe = '01' OR w.strTppe = '02' OR w.strTppe = '03' OR w.strTppe = '04') GROUP BY c.title,c.id ORDER BY c.id",(long)type,(long)type];

                break;
                
            case subjectFour:
                
                sql = [NSString stringWithFormat:@"SELECT c.title as title ,c.id as id, c.mid as mid, count(c.id) as count FROM (select '0'||mid as mid ,title ,id ,kemu FROM Chapter where kemu=%ld AND fid=0 and ( mid<>8 )) c, web_note w WHERE c.kemu = %ld AND w.kemu=%ld AND w.strTppe = c.mid GROUP BY c.title,c.id, c.mid ORDER BY c.id",(long)type,(long)type,(long)type];
                
                break;
                
            default:
                break;
        }
        NSLog(@"sql:%@",sql);

        FMResultSet *rs = [dataBase executeQuery:sql];
        
        while ([rs next]) {
            
            YBSubjectData *subjectData = [[YBSubjectData alloc] init];
            
            NSString *mid = [rs stringForColumn:@"mid"];
            subjectData.mid = mid;
            
            NSString *title = [rs stringForColumn:@"title"];
            subjectData.title = title;
            
            NSInteger ID = [[rs stringForColumn:@"id"] integerValue];
            subjectData.ID = ID;
            
            NSInteger count = [[rs stringForColumn:@"count"] integerValue];
            subjectData.count = count;
            
            [tempArray addObject:subjectData];
            
        }
        
    }
    
    return tempArray;
    
}

+ (NSArray *)getAllSubjectDataWithType:(subjectType)type chapter:(NSString *)chapter
{
    NSMutableArray *tempArray = [NSMutableArray array];

    //NSFileManager *fileManager = [[NSFileManager alloc] init];

    NSString *dbPath = [YBSubjectPath stringByAppendingString:@"/ggtkFile/ggtk_20151201.db"];
    NSLog(@"dbPath:%@",dbPath);
    
   // NSString *imgPath = [YBSubjectPath stringByAppendingString:@"/ggtkFile/resources"];
   // NSArray *imgArray = [fileManager subpathsOfDirectoryAtPath: imgPath error:nil];
   // NSLog(@"imgArrayPath:%@",imgArray);
    
   // NSString *name = @"0014ec3c884a4e7bbdbbf61d07e0d597.jpg";
   // NSString *subjectImgPath = [YBSubjectPath stringByAppendingFormat:@"/ggtkFile/resources/%@",name];//[documentpath stringByAppendingString:@"/ggtkFile/resources/%@",name];
   // NSLog(@"subjectImgPath:%@",subjectImgPath);
    
    FMDatabase *dataBase = [FMDatabase databaseWithPath:dbPath];
    
    if (dataBase) {
        
        [dataBase open];
        
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM web_note where kemu =%ld and strTppe='%@' order by id",(long)type,chapter];
        
        NSLog(@"sql:%@",sql);
        
        FMResultSet *rs = [dataBase executeQuery:sql];
        
        while ([rs next]) {
            
            YBSubjectData *subjectData = [[YBSubjectData alloc] init];
            
            NSInteger ID = [[rs stringForColumn:@"id"] integerValue];
            subjectData.ID = ID;
            
            NSInteger intNumber = [[rs stringForColumn:@"intNumber"] integerValue];
            subjectData.intNumber = intNumber;
            
            NSInteger type = [[rs stringForColumn:@"type"] integerValue];
            subjectData.type = type;
            
            NSInteger strTppe = [[rs stringForColumn:@"strTppe"] integerValue];
            subjectData.strTppe = strTppe;

            NSInteger strType_l = [[rs stringForColumn:@"strType_l"] integerValue];
            subjectData.strType_l = strType_l;

            NSString *license_type = [rs stringForColumn:@"license_type"];
            subjectData.license_type = license_type;

            NSString *question = [rs stringForColumn:@"question"];
            subjectData.question = question;

            NSString *answer1 = [rs stringForColumn:@"answer1"];
            subjectData.answer1 = answer1;

            NSString *answer2 = [rs stringForColumn:@"answer2"];
            subjectData.answer2 = answer2;

            NSString *answer3 = [rs stringForColumn:@"answer3"];
            subjectData.answer3 = answer3;

            NSString *answer4 = [rs stringForColumn:@"answer4"];
            subjectData.answer4 = answer4;

            NSString *answer5 = [rs stringForColumn:@"answer5"];
            subjectData.answer5 = answer5;

            NSString *answer6 = [rs stringForColumn:@"answer6"];
            subjectData.answer6 = answer6;

            NSString *answer7 = [rs stringForColumn:@"answer7"];
            subjectData.answer7 = answer7;

            NSInteger answer_true = [[rs stringForColumn:@"answer_true"] integerValue];
            subjectData.answer_true = answer_true;

            NSString *explain = [rs stringForColumn:@"explain"];
            subjectData.explain = explain;

            NSInteger kemu = [[rs stringForColumn:@"kemu"] integerValue];
            subjectData.kemu = kemu;

            NSString *explain_form = [rs stringForColumn:@"explain_form"];
            subjectData.explain_form = explain_form;

            NSString *moretypes = [rs stringForColumn:@"moretypes"];
            subjectData.moretypes = moretypes;

            NSString *chapterid = [rs stringForColumn:@"chapterid"];
            subjectData.chapterid = chapterid;

            NSString *img_url = [rs stringForColumn:@"img_url"];
            subjectData.img_url = img_url;

            NSString *video_url = [rs stringForColumn:@"video_url"];
            subjectData.video_url = video_url;

            NSInteger diff_degree = [[rs stringForColumn:@"diff_degree"] integerValue];
            subjectData.diff_degree = diff_degree;
            
            [tempArray addObject:subjectData];
            
        }
        
    }
    
    return tempArray;

}

// INSERT into error_book ('webnoteid','userid','kemu') VALUES(1,'dfsd0',1)
+ (void)setupSqlite
{
    // 0.获得沙盒中的数据库文件名
    NSString *dbPath = [YBSubjectPath stringByAppendingString:@"/ggtkFile/ggtk_20151201.db"];
    NSLog(@"dbPath:%@",dbPath);
    
    // 1.创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    
    // 2.创表
    [_queue inDatabase:^(FMDatabase *db) {
        
        BOOL result = [db executeUpdate:@"create table if not exists error_books (id integer primary key autoincrement, kemu int, webnoteid int,userid text);"];
        
        if (result) {
            NSLog(@"创表成功");
        } else {
            NSLog(@"创表失败");
        }
        
    }];
    
}

+ (void)insertWrongQuestionwithtype:(subjectType)type userid:(NSString *)userid webnoteid:(NSInteger)webnoteid
{
    
    NSLog(@"type:%ld-userid:%@-webnoteid:%ld",(long)type,userid,(long)webnoteid);
    
    [self setupSqlite];
    
    [_queue inDatabase:^(FMDatabase *db) {
        
        NSString *sql = [NSString stringWithFormat:@"INSERT into error_books ('kemu','webnoteid','userid') VALUES (%ld,%ld,%@);",type,webnoteid,userid];
        NSLog(@"insertWrongQuestionwithtype sql:%@",sql);
        
        // 2.存储数据
        [db executeUpdate:sql];

    }];
    
    [_queue close];
    
}

+ (void)isExitWrongQuestionWithtype:(subjectType)type userid:(NSString *)userid webnoteid:(NSInteger)webnoteid isExitBlock:(isExitBlock)isExitBlock
{

    NSString *dbPath = [YBSubjectPath stringByAppendingString:@"/ggtkFile/ggtk_20151201.db"];
    NSLog(@"dbPath:%@",dbPath);
    
    FMDatabase *dataBase = [FMDatabase databaseWithPath:dbPath];
    
    if (dataBase) {
        
        [dataBase open];
        
        NSString *sql = [NSString stringWithFormat:@"SELECT count(*) as count from web_note w,error_books e where w.id=e.webnoteid and e.userid =%@ and e.kemu=%ld and e.webnoteid=%ld",userid,(long)type,webnoteid];
        
        if ([userid isEqualToString:@"null"]) {
            sql = [NSString stringWithFormat:@"SELECT count(*) as count from web_note w,error_books e where w.id=e.webnoteid  and e.userid is null and e.kemu=%ld and e.webnoteid=%ld",(long)type,webnoteid];
        }
        
        FMResultSet *rs = [dataBase executeQuery:sql];
        
        NSLog(@"判断错题是否存在sql:%@-rs:%@ [rs stringForColumn:count]:%@",sql,rs,[rs stringForColumn:@"count"]);

        if ([rs stringForColumn:@"count"] && [[rs stringForColumn:@"count"] integerValue] !=0) {
            isExitBlock(YES);
        }else{
            isExitBlock(NO);
        }
        
    }
    
}

+ (NSArray *)getAllWrongQuestionwithtype:(subjectType)type userid:(NSString *)userid
{
    NSMutableArray *tempArray = [NSMutableArray array];
    
    NSString *dbPath = [YBSubjectPath stringByAppendingString:@"/ggtkFile/ggtk_20151201.db"];
    NSLog(@"dbPath:%@",dbPath);
    
    FMDatabase *dataBase = [FMDatabase databaseWithPath:dbPath];
    
    if (dataBase) {
        
        [dataBase open];
        
        NSString *sql = [NSString stringWithFormat:@"SELECT w.* from web_note w,error_books e where w.id=e.webnoteid  and e.userid  =%@ and e.kemu=%ld",userid,(long)type];
        
        if ([userid isEqualToString:@"null"]) {
            sql = [NSString stringWithFormat:@"SELECT w.* from web_note w,error_books e where w.id=e.webnoteid  and e.userid is null and e.kemu=%ld",(long)type];
        }
        
        NSLog(@"获取错题sql:%@",sql);
        
        FMResultSet *rs = [dataBase executeQuery:sql];
        
        while ([rs next]) {
            
            YBSubjectData *subjectData = [[YBSubjectData alloc] init];//[NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            NSInteger ID = [[rs stringForColumn:@"id"] integerValue];
            subjectData.ID = ID;
            
            NSInteger intNumber = [[rs stringForColumn:@"intNumber"] integerValue];
            subjectData.intNumber = intNumber;
            
            NSInteger type = [[rs stringForColumn:@"type"] integerValue];
            subjectData.type = type;
            
            NSInteger strTppe = [[rs stringForColumn:@"strTppe"] integerValue];
            subjectData.strTppe = strTppe;
            
            NSInteger strType_l = [[rs stringForColumn:@"strType_l"] integerValue];
            subjectData.strType_l = strType_l;
            
            NSString *license_type = [rs stringForColumn:@"license_type"];
            subjectData.license_type = license_type;
            
            NSString *question = [rs stringForColumn:@"question"];
            subjectData.question = question;
            
            NSString *answer1 = [rs stringForColumn:@"answer1"];
            subjectData.answer1 = answer1;
            
            NSString *answer2 = [rs stringForColumn:@"answer2"];
            subjectData.answer2 = answer2;
            
            NSString *answer3 = [rs stringForColumn:@"answer3"];
            subjectData.answer3 = answer3;
            
            NSString *answer4 = [rs stringForColumn:@"answer4"];
            subjectData.answer4 = answer4;
            
            NSString *answer5 = [rs stringForColumn:@"answer5"];
            subjectData.answer5 = answer5;
            
            NSString *answer6 = [rs stringForColumn:@"answer6"];
            subjectData.answer6 = answer6;
            
            NSString *answer7 = [rs stringForColumn:@"answer7"];
            subjectData.answer7 = answer7;
            
            NSInteger answer_true = [[rs stringForColumn:@"answer_true"] integerValue];
            subjectData.answer_true = answer_true;
            
            NSString *explain = [rs stringForColumn:@"explain"];
            subjectData.explain = explain;
            
            NSInteger kemu = [[rs stringForColumn:@"kemu"] integerValue];
            subjectData.kemu = kemu;
            
            NSString *explain_form = [rs stringForColumn:@"explain_form"];
            subjectData.explain_form = explain_form;
            
            NSString *moretypes = [rs stringForColumn:@"moretypes"];
            subjectData.moretypes = moretypes;
            
            NSString *chapterid = [rs stringForColumn:@"chapterid"];
            subjectData.chapterid = chapterid;
            
            NSString *img_url = [rs stringForColumn:@"img_url"];
            subjectData.img_url = img_url;
            
            NSString *video_url = [rs stringForColumn:@"video_url"];
            subjectData.video_url = video_url;
            
            NSInteger diff_degree = [[rs stringForColumn:@"diff_degree"] integerValue];
            subjectData.diff_degree = diff_degree;
            
            [tempArray addObject:subjectData];
            
        }
        
    }
    
    return tempArray;
    
}

// 获取随机考试题库
+ (NSArray *)getAllExamDataWithType:(subjectType)type
{
    NSMutableArray *tempArray = [NSMutableArray array];
    
    NSString *dbPath = [YBSubjectPath stringByAppendingString:@"/ggtkFile/ggtk_20151201.db"];
    NSLog(@"dbPath:%@",dbPath);
    
    FMDatabase *dataBase = [FMDatabase databaseWithPath:dbPath];
    
    if (dataBase) {
        
        [dataBase open];
        
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM web_note where kemu =%ld   and (strTppe='01' or strTppe='02' or strTppe='03' or strTppe='04') order BY RANDOM() limit 100",(long)type];
        
        NSLog(@"sql:%@",sql);
        
        FMResultSet *rs = [dataBase executeQuery:sql];
        
        while ([rs next]) {
                        
            YBSubjectData *subjectData = [[YBSubjectData alloc] init];//[NSKeyedUnarchiver unarchiveObjectWithData:data];
            
            NSInteger ID = [[rs stringForColumn:@"id"] integerValue];
            subjectData.ID = ID;
            
            NSInteger intNumber = [[rs stringForColumn:@"intNumber"] integerValue];
            subjectData.intNumber = intNumber;
            
            NSInteger type = [[rs stringForColumn:@"type"] integerValue];
            subjectData.type = type;
            
            NSInteger strTppe = [[rs stringForColumn:@"strTppe"] integerValue];
            subjectData.strTppe = strTppe;
            
            NSInteger strType_l = [[rs stringForColumn:@"strType_l"] integerValue];
            subjectData.strType_l = strType_l;
            
            NSString *license_type = [rs stringForColumn:@"license_type"];
            subjectData.license_type = license_type;
            
            NSString *question = [rs stringForColumn:@"question"];
            subjectData.question = question;
            
            NSString *answer1 = [rs stringForColumn:@"answer1"];
            subjectData.answer1 = answer1;
            
            NSString *answer2 = [rs stringForColumn:@"answer2"];
            subjectData.answer2 = answer2;
            
            NSString *answer3 = [rs stringForColumn:@"answer3"];
            subjectData.answer3 = answer3;
            
            NSString *answer4 = [rs stringForColumn:@"answer4"];
            subjectData.answer4 = answer4;
            
            NSString *answer5 = [rs stringForColumn:@"answer5"];
            subjectData.answer5 = answer5;
            
            NSString *answer6 = [rs stringForColumn:@"answer6"];
            subjectData.answer6 = answer6;
            
            NSString *answer7 = [rs stringForColumn:@"answer7"];
            subjectData.answer7 = answer7;
            
            NSInteger answer_true = [[rs stringForColumn:@"answer_true"] integerValue];
            subjectData.answer_true = answer_true;
            
            NSString *explain = [rs stringForColumn:@"explain"];
            subjectData.explain = explain;
            
            NSInteger kemu = [[rs stringForColumn:@"kemu"] integerValue];
            subjectData.kemu = kemu;
            
            NSString *explain_form = [rs stringForColumn:@"explain_form"];
            subjectData.explain_form = explain_form;
            
            NSString *moretypes = [rs stringForColumn:@"moretypes"];
            subjectData.moretypes = moretypes;
            
            NSString *chapterid = [rs stringForColumn:@"chapterid"];
            subjectData.chapterid = chapterid;
            
            NSString *img_url = [rs stringForColumn:@"img_url"];
            subjectData.img_url = img_url;
            
            NSString *video_url = [rs stringForColumn:@"video_url"];
            subjectData.video_url = video_url;
            
            NSInteger diff_degree = [[rs stringForColumn:@"diff_degree"] integerValue];
            subjectData.diff_degree = diff_degree;
            
            [tempArray addObject:subjectData];
            
        }
        
    }
    
    return tempArray;
    
}

/**
 *  根据语音时长格式化时长
 *
 *  @param duration 原始时长
 *
 *  @return 格式化后的时长
 */
+ (NSString *)duration:(NSString *)duration
{
    int times = [duration intValue];
    
    NSString *newTime;
    
    if (times < 60) {// 小于60秒
        
        if (times < 10) {// 小于10秒
            
            if (times==0) {
                newTime = [NSString stringWithFormat:@"00:00"];
            }else{
                newTime = [NSString stringWithFormat:@"00:0%.0d" , times];
            }
            
        } else {// 大于10秒
            
            newTime = [NSString stringWithFormat:@"00:%.0d" , times];
        }
        
    } else {// 大于60秒
        
        int t = times / 60;// 分钟
        float  p = times % 60;// 秒
        
        if (t > 10) {// 大于10分钟
            
            if (p < 10) {// 秒钟小于10秒
                newTime = [NSString stringWithFormat:@"%d:0%.0f" ,t,p];
            } else {// 秒钟大于10秒
                newTime = [NSString stringWithFormat:@"%d:%.0f" , t,p];
            }
            
        } else {// 小于10分钟,小于一分钟
            
            if (p < 10) {// 秒钟小于10秒
                newTime = [NSString stringWithFormat:@"0%d:0%.0f" ,t,p];
            } else {// 秒钟大于10秒
                newTime = [NSString stringWithFormat:@"0%d:%.0f" , t,p];
            }
            
        }
        
    }
    
    return newTime;
}

@end
