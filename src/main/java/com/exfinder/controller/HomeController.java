package com.exfinder.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.exfinder.dto.CurrencyDto;
import com.exfinder.service.CurrencyService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private CurrencyService service;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		LocalDate localDate = LocalDate.now().plusDays(1);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		List<CurrencyDto> list = new ArrayList<CurrencyDto>();
		try {
			int size = 0;
			while (size == 0) {
				localDate = localDate.minusDays(1);
				String today = localDate.format(formatter);

				list = service.selectExchange(today);
				size = list.size();
				System.out.println("size() : " + size);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("list", list);
		return "main/exFinder_main";
	}

	@RequestMapping(value = "/exFinder_Currency", method = RequestMethod.GET)
	public String exFinder_Currency(Model model, @RequestParam("c_code") String  c_code) throws Exception {
		CurrencyDto currency = new CurrencyDto();
		currency.setC_code("USD");
		currency = service.currency_Select(c_code);
		System.out.println(currency);
		model.addAttribute("currencyDto", currency); 
		return "main/exFinder_Currency";
	}
}
