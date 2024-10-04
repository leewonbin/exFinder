package com.exfinder.util;

import java.io.File;
import java.util.Iterator;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class FileUtil {
	// private static final String filePath = "C:\\Users\\tj-bu-702-10\\Desktop\\exFinder\\src\\main\\webapp\\resources\\profile_img\\"; // 파일이 저장될 위치

    // 기준 파일의 절대 경로 설정
    private static final String filePath = getBaseFilePath();

    private static String getBaseFilePath() {
        try {
            // 클래스패스의 루트 경로를 가져옴
            String resourcePath = FileUtil.class.getClassLoader().getResource("").getPath();
            // 두 번 부모 디렉토리로 올라간 후, 추가 경로를 설정
            File baseFile = new File(new File(resourcePath).getParentFile().getParent(), "src/main/webapp/resources/profile_img/");
            return baseFile.getAbsolutePath(); // 절대 경로 반환
        } catch (Exception e) {
            e.printStackTrace();
            return null; // 에러 발생 시 null 반환
        }
    }

    public static String updateImg(MultipartHttpServletRequest mpRequest, String oldImgPath) throws Exception {
        // 기존 이미지 삭제 로직
        if (oldImgPath != null && !oldImgPath.isEmpty()) {
            File oldFile = new File(filePath, oldImgPath);
            if (oldFile.exists()) {
                oldFile.delete();
            }
        }

        Iterator<String> iterator = mpRequest.getFileNames();
        MultipartFile multipartFile = null;
        String storedFileName = null;

        File directory = new File(filePath);
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
