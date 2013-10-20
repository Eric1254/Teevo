//
//  TeevoCommon.h
//  Teevo
//
//  Created by Sumit Kumar Singh on 30/09/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SERVER_URL @"http://teevo.lpipl.com/teevo_api/api.php"
#define FUNC_ALL_CAT @"getAllCategory"
#define FUNC_BOOK_BY_CATID @"getopbooksbycatid"
#define FUNC_4_BOOK_BY_CATID @"getopbooksbycatid"
#define FUNC_ALL_BOOK_BY_CATID @"getopbooksbycatid2"
#define FUNC_LOGIN @"login"
#define FUNC_FORFOT_PWD @"forgotpassword"
#define FUNC_NEW_USER @"storeUser"
#define FUNC_BOOK_DETAIL_BY_ID @"getbookdetailbyid"
#define FUNC_MY_DOWNLOADS @"getmydownaloads"
#define FUNC_QUIZ_BOOK_BY_ID @"getquizbybookid"
#define FUNC_QUIZAND_BY_ID @"getquizansbyquizid"
#define FUNC_ALL_YEAR @"getallyear"
#define FUNC_TODAYS_QUIZ @"gettodaysquiz"
#define FUNC_MY_TEEVO @"getmyteevo"
#define FUNC_QUIZ_ARCHIEVE @"getarchives"
#define FUNC_DUMMYARCHIVES @"dummyarchives"
#define FUNC_GET_QUIZ_ARCHIVE @"getquizbyarchives"
#define FUNC_ADDPOINTS @"addpoints"
#define FUNC_GETALLPOINTS @"getallpoints"
#define FUNC_GETALLPOINTSBYMONTH @"getallpointsbymonth"
#define FUNC_TREADER_EBOOK @"gettodaysquiz"


/*

 api url >> http://teevo.lpipl.com/teevo_api/api.php
 
 test url >> http://teevo.lpipl.com/teevo_api/test_api.php
 
 
 //////////////////////////////////////////////
 
 function name >> getAllCategory
 params >> {"catid":"1"}
 
 get all subcategories of any category by its id
 
 
 //////////////////////////////
 
 function name >> getopbooksbycatid
 params >> {"catid":"1"}
 
 get all teevo books by its  subcatid
 
 //////////////////////////////
 
 function name >> getopbooksbycatid
 params >> {"catid":"1"}
 
 get only 4  teevo books by its  subcatid and get grouped by bookid
 
 //////////////////////////////
 
 function name >> getopbooksbycatid2
 params >> {"catid":"1"}
 
 get all teevo books by its  subcatid and get order by bookid
 
 //////////////////////////////
 
 function name >> login
 params >> {"email":"jeet@yahoo.coms","password":"123test"}
 
 login function with email and password
 
 //////////////////////////////
 
 function name >> forgotpassword
 params >> {"email":"jeet@yahoo.coms"}
 
 forget password recovery by user email
 
 //////////////////////////////
 
 function name >> storeUser
 
 params >>  { "firstname" :"jeeten" , "lastname" :"singh" , "email" :"jeet@taa.com" , "password" :"123456" , "mobile" :"1234567891" , "addressline1" :"41 sachivalaya nagar A"  }
 Register user with its details
 If user email already exist then it will show error that user already exist
 
 //////////////////////////////
 
 function name >> getbookdetailbyid
 params >> {"bookid":"1"}
 
 get book details by its id
 
 //////////////////////////////
 
 function name >> getmydownaloads
 params >> {"userid":"1"}
 
 get all download history of user by user id
 
 //////////////////////////////
 
 function name >> getquizbybookid
 params >> {"year":"2013","month":"3"}
 
 get  quiz by year and month
 
 //////////////////////////////
 
 function name >> getquizansbyquizid
 params >> {"quizid":"9"}
 
 get  quiz answers by quiz id
 
 //////////////////////////////
 
 
 function name >> getallyear
 no parameter required
 
 get all list of years
 
 //////////////////////////////
 
 Testing URl >> http://teevo.lpipl.com/teevo_api/test_api.php
 
 *************************************************************
 get todays quiz
 
 function name >> gettodaysquiz
 
 parameter >> no param
 
 **************************************************************
 
 get my teevo
 
 function name >>>>> getmyteevo
 parameter >>>>>>> no param
 
 ******************************************************************
 get my teevo images
 
 function name >>  getmyteevoimage
 parameter >>>>  {"bookid":"2"}
 
 ***********************************************************************
 
 
 getting the list of quiz names
 
 function >>> getquizbyarchives
 params >>> {"month":"10","year":"2013"}
 
 ***********************************************************
 
 getting the quiz questions and answers by quiz id
 
 function >>>> getarchives
 params >>>>  {"quizid":"3"}
 
 *************************************************************
 
 
 
*/