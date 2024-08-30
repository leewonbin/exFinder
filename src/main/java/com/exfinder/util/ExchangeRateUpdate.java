package com.exfinder.util;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.Select;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.exfinder.dto.ExchangeRateDto;
import com.exfinder.service.ExchangeRateService;

public class ExchangeRateUpdate {

	public ArrayList<ExchangeRateDto> checkExchange(String curreny,String startDate,String endDate) {
		ArrayList<ExchangeRateDto> list = new ArrayList<ExchangeRateDto>();
		WebElement element = null;
		String[] sDate = startDate.split("-");
		String[] eDate = endDate.split("-");

		try {
			System.setProperty("webdriver.chrome.driver", "C://chromedriver/chromedriver.exe");

			ChromeOptions options = new ChromeOptions();

			options.addArguments("--disable-popup-blocking"); // 팝업안띄움
			options.addArguments("headless"); // 브라우저 안띄움
			options.addArguments("--disable-gpu"); // gpu 비활성화
			options.addArguments("--blink-settings=imagesEnabled=false"); // 이미지 다운 안받음
			
			WebDriver driver = new ChromeDriver(options);

			String baseUrl = "https://spot.wooribank.com/pot/Dream?withyou=FXXRT0014";
			driver.get(baseUrl);

			Thread.sleep(1000);
			
			//통화 선택
			Select selectCurr = new Select(driver.findElement(By.id("id01")));
			selectCurr.selectByValue(curreny);

			// 시작 년 선택
			Select start_Year = new Select(driver.findElement(By.id("START_DATEY")));
			
			start_Year.selectByValue(sDate[0]);
			
			// 시작 월 선택
			Select start_Month = new Select(driver.findElement(By.id("START_DATEM")));

			start_Month.selectByValue(sDate[1]);

			// 시작 일 선택
			Select start_Day = new Select(driver.findElement(By.id("START_DATED")));

			start_Day.selectByValue(sDate[2]);
			
			// 종료 년 선택
			Select end_Year = new Select(driver.findElement(By.id("END_DATEY")));
			
			end_Year.selectByValue(eDate[0]);
			
			// 종료 월 선택
			Select end_Month = new Select(driver.findElement(By.id("END_DATEM")));
			
			end_Month.selectByValue(eDate[1]);
			
			// 종료 일 선택
			Select end_Day = new Select(driver.findElement(By.id("END_DATED")));
			
			end_Day.selectByValue(eDate[2]);

			// 조회 버튼
			element = driver.findElement(By.xpath("//*[@id=\"frm\"]/fieldset/div/span/input"));
			element.click();

			// 해당 날짜로 조회 완료
			Thread.sleep(10000);

			WebElement table = driver.findElement(By.xpath("//*[@id=\"fxprint\"]/table"));
			WebElement tbody = table.findElement(By.tagName("tbody"));
			List<WebElement> trs = tbody.findElements(By.tagName("tr"));
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
			
			for(int i = trs.size()-1; i >=0; i--) {
				ExchangeRateDto dto = new ExchangeRateDto();
				String res_date = trs.get(i).findElements(By.tagName("td")).get(0).getText();
				dto.setRate_date(LocalDate.parse(res_date,formatter));
				
				String res_tts = trs.get(i).findElements(By.tagName("td")).get(1).getText();
				dto.setTts(Double.parseDouble(res_tts.replaceAll(",", "")));
				
				String res_ttb = trs.get(i).findElements(By.tagName("td")).get(2).getText();
				dto.setTtb(Double.parseDouble(res_ttb.replaceAll(",", "")));
				
				String res_cashBuy = trs.get(i).findElements(By.tagName("td")).get(3).getText();
				dto.setCash_buy(Double.parseDouble(res_cashBuy.replaceAll(",", "")));
				
				String res_cashSell = trs.get(i).findElements(By.tagName("td")).get(4).getText();
				dto.setCash_sell(Double.parseDouble(res_cashSell.replaceAll(",", "")));
				
//				String res_dealBS = trs.get(i).findElements(By.tagName("td")).get(5).getText();
//				dto.setDeal_bas_r(Double.parseDouble(res_dealBS.replaceAll(",", "")));
				
				String res_baseR = trs.get(i).findElements(By.tagName("td")).get(6).getText();
				dto.setBase_r(Double.parseDouble(res_baseR.replaceAll(",", "")));
				
				dto.setC_code(curreny);
				list.add(dto);
			}
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
}
