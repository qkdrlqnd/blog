package spring.sts.blog;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import spring.model.memo.MemoDAO;
import spring.model.memo.MemoDTO;
import spring.utility.blog.Utility;

@Controller
public class MemoController {

	@Autowired
	private MemoDAO dao;

	@RequestMapping(value="/memo/delete" , method=RequestMethod.GET)
	public String delete(){
			return "/memo/deleteForm";
	}
	@RequestMapping(value="/memo/delete" , method=RequestMethod.POST)
	public String delete(int memono, String col, String word, String nowPage, Model model, HttpServletRequest request){
		if(dao.delete(memono)){
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("col", col);
			model.addAttribute("word", word);
			return "redirect:./list";
		}
		else{
			return "error";
		}
	}
	
	
	
	@RequestMapping(value="/memo/update", method=RequestMethod.GET)
	public String update(int memono, MemoDTO dto, Model model){
		model.addAttribute("dto",dao.read(memono));
		return "/memo/update";
	}
	
	@RequestMapping(value="/memo/update", method=RequestMethod.POST)
	public String update(MemoDTO dto, Model model, String nowPage, String col, String word){
		if(dao.update(dto)){
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("col", col);
			model.addAttribute("word", word);
			return "redirect:./list";
		}
		else{
			return "error";
		}
		
	}
	
	
	
	
	@RequestMapping("/memo/read")
	public String read(int memono, Model model, MemoDTO dto){
		dao.upViewcnt(memono);
		dto = dao.read(memono);
		String content = dto.getContent().replaceAll("\r\n", "<br>");
		dto.setContent(content);
		model.addAttribute("dto", dto);
		return "/memo/read";
	}
	
	
	
	@RequestMapping(value="/memo/create", method=RequestMethod.GET)
	public String create(){
		
		return "/memo/create";
	}
	@RequestMapping(value="/memo/create", method=RequestMethod.POST)
	public String create(MemoDTO dto){
		
		
		if(dao.create(dto)){
			return "redirect:./list";	
		}
		else{
			return "error";
		}
		
		
	}
	
	
	
	@RequestMapping("/memo/list")
	public String list(HttpServletRequest request){
		
		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));
		
		//////����������
		int nowPage = 1 ;
		if(request.getParameter("nowPage")!=null){
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
		int recordPerPage = 5;
		
		//////DB���� �о� �� ���ۼ����� ������ ����
		int sno = ((nowPage -1)  * recordPerPage +1);
		int eno = nowPage * recordPerPage;
		
		
		Map map = new HashMap();
		map.put("col", col);
		map.put("word", word);
		map.put("sno", sno);
		map.put("eno", eno);
		
		List<MemoDTO> list = dao.list(map);
		int total = dao.total(col, word);		
		
		String paging = Utility.paging3(total, nowPage, recordPerPage, col, word);
				
		request.setAttribute("list", list);
		request.setAttribute("nowPage", nowPage);
		request.setAttribute("col", col);
		request.setAttribute("word", word);
		request.setAttribute("paging", paging);
		
		return "/memo/list";
	}
}
