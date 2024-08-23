package com.wit.commons;

import java.io.File;

public class BoardConfig {
	public static int recordCountPerPage = 10;
	public static int naviCountPerPage = 5;
//	 게시판 board_code 1로 설정
	public static int board = 1;

//	 공지사항 board_code 2로 설정
	public static int notice = 2;

	// realPath
	public static String realPath = "C:" + File.separator + "UploadServerFile" + File.separator;
	//public static String realPath= "C:" + File.separator +"Wit"+File.separator + "UploadServerFile"+File.separator;
}