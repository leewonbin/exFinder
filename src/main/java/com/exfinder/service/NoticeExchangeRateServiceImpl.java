package com.exfinder.service;

import java.net.URL;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.exfinder.dao.NoticeExchangeRateDao;
import com.exfinder.dto.NoticeExchangeRateDto;

@Service
public class NoticeExchangeRateServiceImpl implements NoticeExchangeRateService {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public ArrayList<NoticeExchangeRateDto> selectList() throws Exception {
		NoticeExchangeRateDao dao = sqlSession.getMapper(NoticeExchangeRateDao.class);
		return dao.selectList();
	}

	@Override
	public int insert(NoticeExchangeRateDto dto) throws Exception {
		NoticeExchangeRateDao dao = sqlSession.getMapper(NoticeExchangeRateDao.class);
		return dao.insert(dto);
	}

	@Override
	public ArrayList<NoticeExchangeRateDto> check(String[] currency) throws Exception {
		DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
		
		String nowTime = getNowTime();
		
		System.out.println("여기로 들어옴");
		ArrayList<NoticeExchangeRateDto> list = new ArrayList<NoticeExchangeRateDto>();
		
		URL resource = getClass().getClassLoader().getResource("drivers/chromedriver.exe");
		if (resource == null) {
			throw new RuntimeException("Chromedriver executable not found.");
		}
		String driverPath = Paths.get(resource.toURI()).toString();
		
		System.setProperty("webdriver.chrome.driver", driverPath);

		ChromeOptions options = new ChromeOptions();

		options.addArguments("headless"); // 브라우저 안띄움

		WebDriver driver = new ChromeDriver(options);

		String baseUrl = "https://spib.wooribank.com/pib/Dream?withyou=CMCOM0184";
		driver.get(baseUrl);

		Thread.sleep(300);
		try {
			WebElement tbody = driver.findElement(By.xpath("//*[@id=\"fxprint\"]/table/tbody"));

			List<WebElement> trs = tbody.findElements(By.tagName("tr"));
			String rate_date = driver.findElement(By.xpath("//*[@id=\"fxprint\"]/div/div/dl/dd[2]")).getText();
			for (WebElement e : trs) {
			    String c_code = e.findElements(By.tagName("td")).get(0).getText();
			    if (Arrays.asList(currency).contains(c_code)) {
			    	NoticeExchangeRateDto dto = new NoticeExchangeRateDto();

			        dto.setTts(parseDouble(e.findElements(By.tagName("td")).get(2).getText()));
			        dto.setTtb(parseDouble(e.findElements(By.tagName("td")).get(3).getText()));
			        dto.setCash_buy(parseDouble(e.findElements(By.tagName("td")).get(4).getText()));
			        dto.setCash_sell(parseDouble(e.findElements(By.tagName("td")).get(6).getText()));
			        dto.setDeal_bas_r(parseDouble(e.findElements(By.tagName("td")).get(8).getText()));
			        dto.setBase_r(parseDouble(e.findElements(By.tagName("td")).get(9).getText()));
			        
			        dto.setRate_date(LocalDate.parse(rate_date, inputFormatter));
			        dto.setAnnoTime(nowTime);
			        dto.setC_code(c_code);
			        
			        System.out.println(dto.toString());
			        list.add(dto);
			        System.out.println("값 리스트에 들어감");
			    }
			}
		} catch (Exception e) {
			return list;
		} finally {
			driver.quit();
		}
		return list;
	}
	
	private String getNowTime() {
		DateTimeFormatter timeformatter = DateTimeFormatter.ofPattern("HH:mm");
		LocalTime currentTime = LocalTime.now();
		LocalTime adjustedTime = LocalTime.of(currentTime.getHour(), 0);
        return adjustedTime.format(timeformatter);
	}

	public double isValidDouble(String str) {
		try {
			return Double.parseDouble(str);
		} catch (NumberFormatException e) {
			return -1;
		}
	}
	
	public double parseDouble(String value) {
	    String cleanedValue = value.replaceAll(",", "");
	    return isValidDouble(cleanedValue) != -1 ? isValidDouble(cleanedValue) : 0;
	}

	@Override
	public ArrayList<NoticeExchangeRateDto> nowSelect() throws Exception {
		NoticeExchangeRateDao dao = sqlSession.getMapper(NoticeExchangeRateDao.class);
		return dao.nowSelect();
	}

}
