package spring.sts.blog;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import spring.model.address.AddressDAO;
import spring.model.address.AddressDTO;
import spring.utility.blog.Utility;

@Controller
public class AddressController {
	@Autowired
	private AddressDAO dao;
	
	@RequestMapping("/address/list")
	public String list(HttpServletRequest request){
		
		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));

		if(col.equals("total")){
			word="";		
		}
		
		int nowPage = 1;
		int recordPerPage = 5;
		
		if(request.getParameter("nowPage")!= null){
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
		
		int sno = ((nowPage -1) * recordPerPage) +1 ;
		int eno =  nowPage * recordPerPage;

		Map map = new HashMap();
		map.put("col", col);
		map.put("word", word);
		map.put("sno", sno);
		map.put("eno", eno);
		
		List<AddressDTO> list = dao.list(map);
		int totalRecord = dao.total(col, word);
		
		String paging = Utility.paging3(totalRecord, nowPage, recordPerPage, col, word);
		
		request.setAttribute("list", list);
		request.setAttribute("paging", paging);
		request.setAttribute("col", col);
		request.setAttribute("word", word);
		request.setAttribute("nowPage", nowPage);

		return "/address/list";
	}
	
	@RequestMapping(value="/address/create",method=RequestMethod.GET)
	public String create(){
		return "/address/createForm";
	}
	@RequestMapping(value="/address/create",method=RequestMethod.POST)
	public String create(AddressDTO dto,String col, String word, String nowPage){
		
		if(dao.create(dto)){
			return "redirect:./list";
		}else{
			return "error";
		}
	}
	@RequestMapping("/address/read")
	public String read(int no, Model model){

		model.addAttribute("dto",dao.read(no));
		return "/address/read";
	}
	
	@RequestMapping(value="/address/update",method=RequestMethod.GET)
	public String update(int no, Model model){
		model.addAttribute("dto", dao.read(no));
		return "/address/updateForm";
	}
	
	@RequestMapping(value="/address/update",method=RequestMethod.POST)
	public String update(AddressDTO dto, Model model, String col, String word, String nowPage){
		
		if(dao.update(dto)){
			model.addAttribute("col", col);
			model.addAttribute("word", word);
			model.addAttribute("nowPage", nowPage);
			return "redirect:./list";
		}
		else{
			return "error";
		}
	}
	
	@RequestMapping("/address/delete")
	public String delete(int no, Model model, String col, String word, String nowPage){
		model.addAttribute("flag", dao.delete(no));
		model.addAttribute("col", col);
		model.addAttribute("word", word);
		model.addAttribute("nowPage", nowPage);
		
		return "/address/delete";
	}
	
	
}
	
