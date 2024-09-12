package com.exfinder.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class NewsCrawlController {
    // Logger 설정: 로그를 기록하기 위한 Logger 객체를 생성
    private static final Logger logger = LoggerFactory.getLogger(NewsCrawlController.class);

    // 공용으로 사용할 HashMap 정의
    public static HashMap<String, String> map;

    @RequestMapping(value = "news", method = RequestMethod.GET)
    public String getExchangeRateNews(Model model) throws IOException {

        // 현재 날짜를 yyyy.MM.dd 형식으로 변환하기 위한 DateTimeFormatter 객체 생성
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd", Locale.KOREA);

        // 현재 날짜 가져오기
        LocalDate currentDate = LocalDate.now();
        String e_date = currentDate.format(formatter); // 오늘 날짜 포맷팅

        // 하루 전 날짜 설정
        LocalDate previousDate = currentDate.minusDays(1);
        String s_date = previousDate.format(formatter); // 하루 전 날짜 포맷팅

        // 검색할 환율 뉴스의 통화 설정
        String query = "USD"; // 기본 통화 (미국 달러)
        String s_from = s_date.replace(".", ""); // 시작 날짜에서 "."을 제거한 값
        String e_to = e_date.replace(".", ""); // 종료 날짜에서 "."을 제거한 값
        
        // 네이버 뉴스 검색 URL을 구성하여 요청 (첫 페이지만 크롤링)
        String address = "https://search.naver.com/search.naver?where=news&query=" + query
                + "+환율&ds=" + s_date + "&de=" + e_date + "&nso=so%3Ar%2Cp%3Afrom" + s_from + "to" + e_to 
                + "%2Ca%3A&start=1"; // 첫 페이지 크롤링
        Document rawData = Jsoup.connect(address).timeout(5000).get(); // URL로부터 HTML 데이터를 가져옴
        System.out.println("크롤링할 주소: " + address); // 디버깅용 주소 출력

        // 뉴스 제목과 URL을 추출
        ArrayList<String> newsURLs = new ArrayList<>(); // 뉴스 URL 리스트
        ArrayList<String> newsTitles = new ArrayList<>(); // 뉴스 제목 리스트

        // 네이버 뉴스의 4개 항목 (id: sp_nws1, sp_nws2, sp_nws3, sp_nws4)을 가져오기
        for (int i = 1; i <= 4; i++) {
            // 각각의 뉴스 항목을 선택 (li.bx#sp_nws1, li.bx#sp_nws2, ...)
            Elements newsElements = rawData.select("li.bx#sp_nws" + i); 
            System.out.println("뉴스 항목 " + i + " 수: " + newsElements.size());
            
            // 각 뉴스 항목에서 URL과 제목을 추출하여 리스트에 저장
            for (Element news : newsElements) {
                String newsURL = news.select("a.news_tit").attr("href"); // 뉴스 URL 추출
                String newsTitle = news.select("a.news_tit").attr("title"); // 뉴스 제목 추출

                // 각 뉴스 URL과 제목을 출력 (디버깅용)
                System.out.println("뉴스 제목: " + newsTitle);
                System.out.println("뉴스 URL: " + newsURL);
                
                newsURLs.add(newsURL); // URL 리스트에 추가
                newsTitles.add(newsTitle); // 제목 리스트에 추가
            }
        }

        // 크롤링 완료 후 최종 리스트 출력 (디버깅용)
        System.out.println("최종 뉴스 제목 리스트: " + newsTitles);
        System.out.println("최종 뉴스 URL 리스트: " + newsURLs);
        
        // Model 객체에 뉴스 URL과 제목을 속성으로 추가하여 JSP에 전달
        model.addAttribute("newsURLs", newsURLs);
        model.addAttribute("newsTitles", newsTitles);
        return "news"; // news/news.jsp로 이동
    }
}
