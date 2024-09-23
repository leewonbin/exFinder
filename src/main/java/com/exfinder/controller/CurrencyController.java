package com.exfinder.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.exfinder.dto.CurrencyDto;
import com.exfinder.dto.ExchangeRateDto;
import com.exfinder.dto.UserDto;
import com.exfinder.service.CurrencyService;
import com.exfinder.service.ExchangeRateService;

@Controller
public class CurrencyController {

	@Autowired
	private CurrencyService service;

	@Autowired
	private ExchangeRateService exchangerateservice;

	@RequestMapping(value = "/exFinder_Currency", method = RequestMethod.GET)
	public String exFinder_Currency(Model model, HttpSession session, @RequestParam("c_code") String c_code)
			throws Exception {
		CurrencyDto currency = new CurrencyDto();
		currency.setC_code(c_code);
		currency = service.currency_Select(c_code);
		System.out.println(currency);
		model.addAttribute("currencyDto", currency);

		ExchangeRateDto exchangeRate = new ExchangeRateDto();
		exchangeRate.setC_code(c_code);

		LocalDate today = LocalDate.now(); // 오늘 날짜를 가져옴
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd", Locale.KOREA);

		// 오늘 날짜를 지정한 형식으로 포맷팅 (문자열로 변환)
		String currentDate = today.format(formatter);
		exchangeRate = exchangerateservice.exchangeRateSelect_today(c_code, currentDate);

		// 환율이 null일 경우, 하루씩 빼가며 값을 찾음
		while (exchangeRate == null) {
			today = today.minusDays(1); // 1일 빼기
			currentDate = today.format(formatter); // 새로운 날짜 포맷팅
			exchangeRate = exchangerateservice.exchangeRateSelect_today(c_code, currentDate);
		}
		System.out.println(exchangeRate);
		model.addAttribute("exchangeRateDto", exchangeRate); // 조회된 환율 정보 추가

		// 뉴스 크롤링 코드

		// 현재 날짜 가져오기
		LocalDate currentDate2 = LocalDate.now();
		String e_date = currentDate2.format(formatter); // 오늘 날짜 포맷팅

		// 하루 전 날짜 설정
		LocalDate previousDate = currentDate2.minusDays(1);
		String s_date = previousDate.format(formatter); // 하루 전 날짜 포맷팅

		// 검색할 환율 뉴스의 통화 설정
		String query = currency.getC_country(); // 기본 통화 (미국 달러)
		String s_from = s_date.replace(".", ""); // 시작 날짜에서 "."을 제거한 값
		String e_to = e_date.replace(".", ""); // 종료 날짜에서 "."을 제거한 값

		// 네이버 뉴스 검색 URL을 구성하여 요청 (첫 페이지만 크롤링)
		String address = "https://search.naver.com/search.naver?where=news&query=" + query + "+환율&ds=" + s_date + "&de="
				+ e_date + "&nso=so%3Ar%2Cp%3Afrom" + s_from + "to" + e_to + "%2Ca%3A&start=1"; // 첫 페이지 크롤링
		Document rawData = Jsoup.connect(address).timeout(5000).get(); // URL로부터 HTML 데이터를 가져옴
		System.out.println("크롤링할 주소: " + address); // 디버깅용 주소 출력

		// 뉴스 제목과 URL을 추출
		ArrayList<String> newsIcons = new ArrayList<>(); // 뉴스 아이콘 리스트
		ArrayList<String> newsNames = new ArrayList<>(); // 뉴스 이름 리스트
		ArrayList<String> newsTimes = new ArrayList<>(); // 뉴스 실시간 리스트

		ArrayList<String> newsURLs = new ArrayList<>(); // 뉴스 URL 리스트
		ArrayList<String> newsTitles = new ArrayList<>(); // 뉴스 제목 리스트
		ArrayList<String> newsTexts = new ArrayList<>(); // 뉴스 내용 리스트
		ArrayList<String> newsImgs = new ArrayList<>(); // 뉴스 이미지 리스트

		int maxNewsItems = 4; // 최대 뉴스 항목 수 설정
		for (int i = 1; i <= 20; i++) { // 총 20개 항목까지 시도
			// 각각의 뉴스 항목을 선택 (li.bx#sp_nws1, li.bx#sp_nws2, ...)
			Elements newsElements = rawData.select("li.bx#sp_nws" + i);
			//System.out.println("뉴스 항목 " + i);

			// 각 뉴스 항목에서 URL과 제목을 추출하여 리스트에 저장
			for (Element news : newsElements) {
				// 리스트가 최대 항목 수에 도달하면 루프 종료
				if (newsIcons.size() >= maxNewsItems) {
					break;
				}

				String newsIcon = news.select("a.info.press img.thumb").attr("data-lazysrc"); // 뉴스 아이콘 추출
				String newsName = news.select("a.info.press").text(); // 뉴스 이름 추출
				String newsTime = news.select("span.info").text(); // 뉴스 실시간 추출

				String newsURL = news.select("a.news_tit").attr("href"); // 뉴스 URL 추출
				String newsTitle = news.select("a.news_tit").attr("title"); // 뉴스 제목 추출
				String newsText = news.select("a.api_txt_lines.dsc_txt_wrap").text(); // 뉴스 내용 추출
				String newsImg = news.select("a.dsc_thumb img.thumb").attr("data-lazysrc"); // 뉴스 이미지 추출 a.dsc_thumb

				/*
				 * // 뉴스 항목에서 모든 img 태그를 출력하여 HTML 구조 확인 Elements imgElements =
				 * news.select("img"); for (Element img : imgElements) {
				 * System.out.println("이미지 태그 HTML: " + img.outerHtml()); }
				 */

				// 각 뉴스 URL과 제목을 출력 (디버깅용)
				/*
				System.out.println("뉴스 아이콘: " + newsIcon);
				System.out.println("뉴스 이름: " + newsName);
				System.out.println("뉴스 시간: " + newsTime);

				System.out.println("뉴스 URL: " + newsURL);
				System.out.println("뉴스 제목: " + newsTitle);
				System.out.println("뉴스 내용: " + newsText);
				System.out.println("뉴스 img: " + newsImg);
				*/
				
				newsIcons.add(newsIcon); // URL 리스트에 추가
				newsNames.add(newsName); // 제목 리스트에 추가
				newsTimes.add(newsTime); // 이미지 리스트에 추가

				newsURLs.add(newsURL); // URL 리스트에 추가
				newsTitles.add(newsTitle); // 제목 리스트에 추가
				newsTexts.add(newsText); // 내용 리스트에 추가
				newsImgs.add(newsImg); // 이미지 리스트에 추가
			}

			// 리스트가 최대 항목 수에 도달하면 외부 루프 종료
			if (newsIcons.size() >= maxNewsItems) {
				break;
			}
		}

		// 크롤링 완료 후 최종 리스트 출력 (디버깅용)
		/*
		System.out.println("최종 뉴스 아이콘 리스트: " + newsIcons);
		System.out.println("최종 뉴스 이름 리스트: " + newsNames);
		System.out.println("최종 뉴스 시간 리스트: " + newsTimes);

		System.out.println("최종 뉴스 URL 리스트: " + newsURLs);
		System.out.println("최종 뉴스 제목 리스트: " + newsTitles);
		System.out.println("최종 뉴스 내용 리스트: " + newsTexts);
		System.out.println("최종 뉴스 img 리스트: " + newsImgs);
		*/
		
		// Model 객체에 뉴스 URL과 제목을 속성으로 추가하여 JSP에 전달
		model.addAttribute("newsIcons", newsIcons);
		model.addAttribute("newsNames", newsNames);
		model.addAttribute("newsTimes", newsTimes);

		model.addAttribute("newsURLs", newsURLs);
		model.addAttribute("newsTitles", newsTitles);
		model.addAttribute("newsTexts", newsTexts);
		model.addAttribute("newsImgs", newsImgs);

		// 즐겨찾기
		UserDto dto = (UserDto) session.getAttribute("dto");
		boolean isInterestCheck = false;
		if (dto != null) {
			isInterestCheck = service.interestCheck(c_code, dto.getU_id());
		}
		model.addAttribute("isInterestCheck", isInterestCheck);

		return "main/exFinder_Currency";
	}

	@RequestMapping(value = "/interestAction", method = RequestMethod.POST)
	public ResponseEntity<String> interestAction(HttpSession session,@RequestParam String isCheck,@RequestParam String c_code) {
		String result = "FALSE";
		try {
			UserDto dto = (UserDto)session.getAttribute("dto");
			if(dto != null) {
				if(isCheck.equals("true")) {
					service.deleteInsert(dto.getU_id(),c_code);
					result = "DELETE";
				}else {
					service.interestInsert(dto.getU_id(),c_code);
					result = "INSERT";
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<>(result,HttpStatus.OK);
	}

}
