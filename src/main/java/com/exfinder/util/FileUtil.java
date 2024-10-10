package com.exfinder.util;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Iterator;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.core.io.ClassPathResource;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class FileUtil {

    public static String getBaseFilePath(ServletContext context) {
        // 톰캣의 webapps 디렉토리 경로를 가져옴
        String basePath = context.getRealPath("/"); // 현재 애플리케이션(exFinder)의 루트
        // wtpwebapps를 webapps로 변경
        String imagePath = basePath.replace("wtpwebapps", "webapps").replace("exFinder\\", "exFinder_server\\") + "profile_img/";
        
        // 디버그 로그
        System.out.println("imagePath : " + imagePath);
        File baseDirectory = new File(imagePath);

        // 이미지 경로가 존재하지 않으면 생성
        if (!baseDirectory.exists()) {
            baseDirectory.mkdirs(); // 디렉토리가 존재하지 않으면 생성
        }

        return baseDirectory.getPath();
    }

    
    public static String updateImg(String u_id, MultipartHttpServletRequest mpRequest, String oldImgPath, ServletContext context) throws Exception {
        
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
                storedFileName = u_id + "_" +  getRandomString() + getFileExtension(multipartFile.getOriginalFilename());
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
