package com.exfinder.service;

import java.net.URISyntaxException;
import java.net.URL;
import java.nio.file.Paths;
import java.time.Duration;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.exfinder.dao.ExchangeRateDao;
import com.exfinder.dto.ExchangeRateDto;
import com.exfinder.dto.ExchangeRate_ComparisonValueDto;
import com.exfinder.dto.NoticeExchangeRateDto;

@Service
public class ExchangeRateServiceImpl implements ExchangeRateService {

	private ExchangeRateDao dao;

	@Autowired
	public ExchangeRateServiceImpl(SqlSession sqlSession) {
		this.dao = sqlSession.getMapper(ExchangeRateDao.class);
	}

	@Override
	public ArrayList<ExchangeRateDto> exchangeRateSelect(String c_code, String start_date, String end_date)
			throws Exception {
		return dao.exchangeRateSelect(c_code, start_date, end_date);
	}

	@Override
	public int exchangeRateInsert(ExchangeRateDto dto) throws Exception {
		return dao.exchangeRateInsert(dto);
	}

	public ArrayList<ExchangeRateDto> checkExchange(String[] currency, String startDate, String endDate) {
		ArrayList<ExchangeRateDto> list = new ArrayList<>();
		WebDriver driver = null;
		try {
			URL resource = getClass().getClassLoader().getResource("drivers/chromedriver.exe");
			if (resource == null) {
				throw new RuntimeException("Chromedriver executable not found.");
			}
			String driverPath = Paths.get(resource.toURI()).toString();
			System.out.println("driverPath : " + driverPath);
			System.setProperty("webdriver.chrome.driver", driverPath);

			ChromeOptions options = new ChromeOptions();
			options.addArguments("--disable-popup-blocking"); // 팝업 안 띄움
			options.addArguments("--headless"); // 브라우저 안 띄움
			options.addArguments("--disable-gpu"); // GPU 비활성화
			options.addArguments("--blink-settings=imagesEnabled=false"); // 이미지 다운로드 비활성화

			driver = new ChromeDriver(options);

			WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(20)); // 타임아웃 늘리기
			driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(10));

			String baseUrl = "https://spot.wooribank.com/pot/Dream?withyou=FXXRT0014";
			driver.get(baseUrl);

			// 날짜 분할
			String[] sDate = startDate.split("-");
			String[] eDate = endDate.split("-");

			for (String curr : currency) {
				// 통화 선택
				WebElement currencySelect = wait.until(ExpectedConditions.elementToBeClickable(By.id("id01")));
				Select selectCurr = new Select(currencySelect);
				selectCurr.selectByValue(curr);

				// 시작 년도 선택
				Select start_Year = new Select(driver.findElement(By.id("START_DATEY")));
				start_Year.selectByValue(sDate[0]);

				// 시작 월 선택
				Select start_Month = new Select(driver.findElement(By.id("START_DATEM")));
				start_Month.selectByValue(sDate[1]);

				// 시작 일 선택
				Select start_Day = new Select(driver.findElement(By.id("START_DATED")));
				start_Day.selectByValue(sDate[2]);

				// 종료 년도 선택
				Select end_Year = new Select(driver.findElement(By.id("END_DATEY")));
				end_Year.selectByValue(eDate[0]);

				// 종료 월 선택
				Select end_Month = new Select(driver.findElement(By.id("END_DATEM")));
				end_Month.selectByValue(eDate[1]);

				// 종료 일 선택
				Select end_Day = new Select(driver.findElement(By.id("END_DATED")));
				end_Day.selectByValue(eDate[2]);

				// 조회 버튼 클릭
				WebElement searchButton = wait.until(
						ExpectedConditions.elementToBeClickable(By.xpath("//*[@id='frm']/fieldset/div/span/input")));
				searchButton.click();

				// 결과 대기 및 테이블 추출
				WebElement table = wait
						.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//*[@id='fxprint']/table")));
				WebElement tbody = table.findElement(By.tagName("tbody"));
				List<WebElement> trs = tbody.findElements(By.tagName("tr"));

				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");

				for (int i = trs.size() - 1; i >= 0; i--) {
					ExchangeRateDto dto = new ExchangeRateDto();
					List<WebElement> cells = trs.get(i).findElements(By.tagName("td"));

					dto.setRate_date(LocalDate.parse(cells.get(0).getText(), formatter));
					dto.setTts(parseDouble(cells.get(1).getText()));
					dto.setTtb(parseDouble(cells.get(2).getText()));
					dto.setCash_buy(parseDouble(cells.get(3).getText()));
					dto.setCash_sell(parseDouble(cells.get(4).getText()));
					dto.setDeal_bas_r(parseDouble(stringCut(cells.get(5).getText())));
					dto.setBase_r(parseDouble(cells.get(6).getText()));

					dto.setC_code(curr);
					list.add(dto);
				}
				System.out.println(curr + " 완료");
			}
		} catch (URISyntaxException e) {
			e.printStackTrace();
		} catch (TimeoutException e) {
			System.err.println("TimeoutException: " + e.getMessage());
		} catch (NoSuchElementException e) {
			System.err.println("NoSuchElementException: " + e.getMessage());
		} catch (Exception e) {
			System.err.println("Exception: " + e.getMessage());
		} finally {
			if (driver != null) {
				try {
					driver.quit();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return list;
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

	public static String stringCut(String input) {
		String[] keywords = { "하락", "상승" };
		for (String keyword : keywords) {
			if (input.contains(keyword)) {
				String[] parts = input.split(keyword, 2); // 두 번째 매개변수는 분할 수를 지정합니다.
				return parts[0].trim(); // 첫 번째 부분(하락 또는 상승 앞)을 반환
			}
		}
		return input.trim(); // 키워드가 없을 경우 전체 문자열 반환
	}

	@Override
	public double exchangeRateSelect_base_r(String c_code, String rate_date) {
		try {
			return dao.exchangeRateSelect_base_r(c_code, rate_date);
		} catch (Exception e) {
			return 0;
		}
	}

	@Override
	public String[] currSelect() throws Exception {
		return dao.currSelect();
	}

	@Override
	public int exchangeRate_column_checkValue(String c_code) {
		int checkValue = dao.exchangeRate_column_checkValue(c_code);

		return (checkValue >= 1) ? checkValue : 0;
	}

	@Override
	public ExchangeRateDto exchangeRateSelect_today(String c_code, String rate_date) throws Exception {
		try {
			return dao.exchangeRateSelect_today(c_code, rate_date);
		} catch (Exception e) {
			return null;
		}
	}

	@Override
	public ArrayList<ExchangeRateDto> yesterDayRate(String[] curr) throws Exception {
		LocalDate yesterDayLocal = LocalDate.now().minusDays(1);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String yesterDay = yesterDayLocal.format(formatter);
        
        String[] yDate = yesterDay.split("-");

		System.out.println("여기로 들어옴");
		ArrayList<ExchangeRateDto> list = new ArrayList<ExchangeRateDto>();

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
		
		// 시작 년도 선택
		Select start_Year = new Select(driver.findElement(By.id("SELECT_DATE_601Y")));
		start_Year.selectByValue(yDate[0]);

		// 시작 월 선택
		Select start_Month = new Select(driver.findElement(By.id("SELECT_DATE_601M")));
		start_Month.selectByValue(yDate[1]);

		// 시작 일 선택
		Select start_Day = new Select(driver.findElement(By.id("SELECT_DATE_601D")));
		start_Day.selectByValue(yDate[2]);

		Thread.sleep(300);
		try {
			WebElement tbody = driver.findElement(By.xpath("//*[@id=\"fxprint\"]/table/tbody"));

			List<WebElement> trs = tbody.findElements(By.tagName("tr"));
			for (WebElement e : trs) {
				String c_code = e.findElements(By.tagName("td")).get(0).getText();
				if (Arrays.asList(curr).contains(c_code)) {
					ExchangeRateDto dto = new ExchangeRateDto();

					dto.setTts(parseDouble(e.findElements(By.tagName("td")).get(2).getText()));
					dto.setTtb(parseDouble(e.findElements(By.tagName("td")).get(3).getText()));
					dto.setCash_buy(parseDouble(e.findElements(By.tagName("td")).get(4).getText()));
					dto.setCash_sell(parseDouble(e.findElements(By.tagName("td")).get(6).getText()));
					dto.setDeal_bas_r(parseDouble(e.findElements(By.tagName("td")).get(8).getText()));
					dto.setBase_r(parseDouble(e.findElements(By.tagName("td")).get(9).getText()));

					dto.setRate_date(yesterDayLocal);
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

	@Override
	public ArrayList<ExchangeRate_ComparisonValueDto> today_ComparisonValue() throws Exception {
		return dao.today_ComparisonValue();
	}

	@Override
	public ExchangeRate_ComparisonValueDto  today_ComparisonValue_code(String c_code) throws Exception {
		return dao.today_ComparisonValue_code(c_code);
	}

	@Override
	public int deleteAllCurr() throws Exception {
		return dao.deleteAllCurr();
	}

}
