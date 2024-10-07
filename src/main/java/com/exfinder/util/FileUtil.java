package com.exfinder.util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Iterator;

import javax.servlet.ServletContext;

import org.springframework.core.io.ClassPathResource;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class FileUtil {
	// private static final String filePath = "C:\\Users\\tj-bu-702-10\\Desktop\\exFinder\\src\\main\\webapp\\resources\\profile_img\\"; // 파일이 저장될 위치
/*
    private static final String projectName = "exFinder";
    private static final String relativePath = "src/main/webapp/resources/profile_img/";

    private static String getBaseFilePath() {
        // 현재 작업 디렉토리에서 프로젝트 이름을 기준으로 경로를 찾기
        Path baseDir = Paths.get(System.getProperty("user.dir")).getParent().getParent(); // src/main 밑으로 올라감
        return baseDir.resolve(projectName).resolve(relativePath).toString();
    }
    private static final String filePath = getBaseFilePath();
*/
    private static final String relativePath = "/resources/profile_img/";
    private static final String projectName = "exFinder";

    // ServletContext를 통해 실제 파일 저장 경로를 가져옴
    public static String getBaseFilePath(ServletContext context) {
        String basePath = context.getRealPath(relativePath);
        File baseDirectory = new File(basePath);
        
        // Tomcat 설치 디렉토리로 이동하는 경우 방지
        String tomcatPath = System.getProperty("catalina.base"); // Tomcat 기본 설치 경로

        // Tomcat 경로가 포함되지 않고, projectName이 포함된 경로를 찾을 때까지 반복
        while (!baseDirectory.getPath().contains(projectName) || baseDirectory.getPath().contains(tomcatPath)) {
            baseDirectory = baseDirectory.getParentFile(); // 상위 디렉토리로 이동
            
            if (baseDirectory == null) {
                throw new IllegalArgumentException("올바른 경로를 찾을 수 없습니다: " + basePath);
            }
        }

        return baseDirectory.getPath(); // 올바른 경로 반환
    }
    
    /*
    public static String getBaseFilePath(ServletContext context) {
        return context.getRealPath(relativePath); // 실제 파일 시스템 경로 반환
    }
     */
    
    public static String updateImg(MultipartHttpServletRequest mpRequest, String oldImgPath, ServletContext context) throws Exception {
        String filePath = getBaseFilePath(context); // 파일 저장 경로
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
            // directory.mkdirs(); // 디렉토리가 존재하지 않으면 생성
            System.out.println("디렉토리 위치 : " + directory);
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
