package com.exfinder.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.exfinder.dto.CurrencyDto;
import com.exfinder.service.CurrencyService;

@Controller
@RequestMapping("/currency/*")
public class CurrencyController {

	private static final Logger logger = LoggerFactory.getLogger(CurrencyController.class);

	@Autowired
	private CurrencyService service;

	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String read(@RequestParam("c_code") String c_code, @RequestParam("rate_date") String rate_date, Model model)
			throws Exception {
		logger.info("read..........", c_code, rate_date);
		CurrencyDto currency = service.read(c_code, rate_date);
		model.addAttribute("currencyDto", currency);
		return "currency/read";
	}

	@RequestMapping(value = "/listAll", method = RequestMethod.GET)
	public void listAll(Model model) throws Exception {
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
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("list", list);
	}



}
