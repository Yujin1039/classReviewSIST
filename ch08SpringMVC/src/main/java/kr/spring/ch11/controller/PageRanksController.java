package kr.spring.ch11.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.spring.ch11.vo.PageRank;

@Controller
public class PageRanksController {
	//엑셀 다운로드
	@RequestMapping("/pageRanksExcel.do")
	public ModelAndView handle() {
		List<PageRank> pageRanks = new ArrayList<PageRank>();
		pageRanks.add(new PageRank(1,"/board/list.do"));
		pageRanks.add(new PageRank(2,"/member/login.do"));
		pageRanks.add(new PageRank(3,"/cart/list.do"));
								//뷰 이름         속성명       속성값
		return new ModelAndView("pageRanks","pageRanks",pageRanks);
	}
	//JSON 문자열 처리
	//컬렉션 객체(List,Map),자바빈을 json 문자열로 변환하여 view를 생성하는 어노테이션 
	@ResponseBody
	@RequestMapping("/pageJson.do")
	public List<PageRank> parseJson(){
		List<PageRank> pageRanks = new ArrayList<PageRank>();
		pageRanks.add(new PageRank(1,"/file.do"));
		pageRanks.add(new PageRank(2,"/pageRanksExcel.do"));
		pageRanks.add(new PageRank(3,"/pageJson.do"));
				
		return pageRanks;
	}
}
