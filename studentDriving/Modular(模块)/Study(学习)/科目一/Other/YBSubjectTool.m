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

#define YBSubjectPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

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
            
            tempArray = [self getSubjectData:type];
            
        }else{// 文件不存在
           
            if (archiveResult) {// 解压成功
                
                tempArray = [self getSubjectData:type];

            }else{// 解压失败
                
            }
            
        }
        
    }];
    
    return tempArray;
}

+ (NSArray *)getSubjectData:(subjectType)type
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
        
        // select *, rowid "NAVICAT_ROWID" from "main"."web_note" order by "id" limit 0,1000
        // SELECT count(*) FROM web_note where kemu =1   and (strTppe='01' or strTppe='02' or strTppe='03' or strTppe='04')SELECT count(*) FROM web_note where kemu =1   and (strTppe='01' or strTppe='02' or strTppe='03' or strTppe='04')
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM web_note where kemu =%ld   and (strTppe='01' or strTppe='02' or strTppe='03' or strTppe='04')",(long)type];
        
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
