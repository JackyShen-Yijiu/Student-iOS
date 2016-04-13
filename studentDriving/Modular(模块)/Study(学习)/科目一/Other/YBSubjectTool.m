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
        NSLog(@"str:%@",str);
        if ([str hasPrefix:@"ggtkFile"]) {
            isExist = YES;
            break;
        }
    }
    NSLog(@"isExist:%d",isExist);
    
    if (isExist) {
        
        NSLog(@"文件存在，读取文件");
//        NSString *dbPath = [YBSubjectPath stringByAppendingString:@"/ggtkFile/ggtk_20151201.db"];
//        NSLog(@"dbPath:%@",dbPath);
//        
//        NSString *imgPath = [YBSubjectPath stringByAppendingString:@"/ggtkFile/resources"];
//        NSArray *imgArray = [fileManager subpathsOfDirectoryAtPath: imgPath error:nil];
//        NSLog(@"imgArrayPath:%@",imgArray);
//        
//        NSString *name = @"0014ec3c884a4e7bbdbbf61d07e0d597.jpg";
//        NSString *subjectImgPath = [YBSubjectPath stringByAppendingFormat:@"/ggtkFile/resources/%@",name];//[documentpath stringByAppendingString:@"/ggtkFile/resources/%@",name];
//        NSLog(@"subjectImgPath:%@",subjectImgPath);

        zipArchiveBlock(YES,YES);

    }else{
        
        NSString* unzipto = [YBSubjectPath stringByAppendingString:@"/ggtkFile"] ;

        NSLog(@"文件不存在");
        
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"ggtkFile"] ofType:@"zip"];
        if( [zip UnzipOpenFile:path] )
        {
            BOOL ret = [zip UnzipFileTo:unzipto overWrite:YES];
            if(ret)
            {
                NSLog(@"解压成功");
//                NSString *dbPath = [YBSubjectPath stringByAppendingString:@"/ggtkFile/ggtk_20151201.db"];
//                NSLog(@"dbPath:%@",dbPath);
//                
//                NSString *imgPath = [YBSubjectPath stringByAppendingString:@"/ggtkFile/resources"];
//                NSArray *imgArray = [fileManager subpathsOfDirectoryAtPath: imgPath error:nil];
//                NSLog(@"imgArrayPath:%@",imgArray);
//                
//                NSString *name = @"0014ec3c884a4e7bbdbbf61d07e0d597.jpg";
//                NSString *subjectImgPath = [YBSubjectPath stringByAppendingFormat:@"/ggtkFile/resources/%@",name];//[documentpath stringByAppendingString:@"/ggtkFile/resources/%@",name];
//                NSLog(@"subjectImgPath:%@",subjectImgPath);
                
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
    NSLog(@"dbPath:%@",dbPath);
  
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



@end
