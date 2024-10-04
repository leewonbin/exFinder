package com.exfinder.util;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Iterator;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class FileUtil {
	// private static final String filePath = "C:\\Users\\tj-bu-702-10\\Desktop\\exFinder\\src\\main\\webapp\\resources\\profile_img\\"; // 파일이 저장될 위치

    private static final String projectName = "exFinder";
    private static final String relativePath = "src/main/webapp/resources/profile_img/";

    private static String getBaseFilePath() {
        // 현재 작업 디렉토리에서 프로젝트 이름을 기준으로 경로를 찾기
        Path baseDir = Paths.get(System.getProperty("user.dir")).getParent().getParent(); // src/main 밑으로 올라감
        return baseDir.resolve(projectName).resolve(relativePath).toString();
    }

    private static final String filePath = getBaseFilePath();

    public static String updateImg(MultipartHttpServletRequest mpRequest, String oldImgPath) throws Exception {
    	File directory = new File(filePath);
    	
    	System.out.println("filePath : " + filePath);
    	System.out.println("directory : " + directory);
    	
        // 기존 이미지 삭제 로직
        if (oldImgPath != null && !oldImgPath.isEmpty()) {
            File oldFile = new File(directory, oldImgPath);
            if (oldFile.exists()) {
                oldFile.delete();
            }
        }

        Iterator<String> iterator = mpRequest.getFileNames();
        MultipartFile multipartFile = null;
        String storedFileName = null;

       
        if (!directory.exists()) {
            directory.mkdirs(); // 디렉토리가 존재하지 않으면 생성
        }

        while (iterator.hasNext()) {
            multipartFile = mpRequest.getFile(iterator.next());
            if (!multipartFile.isEmpty()) {
                // UUID 생성하여 파일 이름으로 사용
                storedFileName = getRandomString() + getFileExtension(multipartFile.getOriginalFilename());
                File file = new File(directory, storedFileName);
                multipartFile.transferTo(file); // 파일 저장
            }
        }

        return storedFileName; // 저장된 파일 이름 반환
    }

    // 파일의 확장자를 가져오는 메서드
    private static String getFileExtension(String filename) {
        return filename.substring(filename.lastIndexOf("."));
    }

    // UUID 기반의 임의의 문자열 생성
    private static String getRandomString() {
        return java.util.UUID.randomUUID().toString().replaceAll("-", "");
    }

}
