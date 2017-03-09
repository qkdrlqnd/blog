package spring.sts.blog;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import spring.model.team.TeamDAO;
import spring.model.team.TeamDTO;
import spring.utility.blog.Utility;

@Controller
public class TeamController {
	@Autowired
	private TeamDAO dao;
	

	@RequestMapping("/team/delete")
	public String delete(int no, String nowPage, String col, String word, String oldfile, Model model, HttpServletRequest request){
		String basePath = request.getRealPath("/team/storage");
		if(dao.delete(no)){
			if(oldfile != null && !oldfile.equals("member.jpg")){
				Utility.deleteFile(basePath, oldfile);
			}
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("col", col);
			model.addAttribute("word", word);
			
			return "redirect:./list";
		}
		else{
			return "error";
		}
	}
	
	
	
	
	@RequestMapping(value="team/update", method=RequestMethod.GET)
	public String update(int no, Model model){
		model.addAttribute("dto",dao.read(no));
		
		return "team/updateForm";
	}
	
	@RequestMapping(value="team/update", method=RequestMethod.POST)
	public String update(TeamDTO dto, String oldfile, HttpServletRequest request, String col, String word, String nowPage, Model model, HttpServletResponse response){
		
		String basePath = request.getRealPath("/team/storage");
		int filesize = (int)dto.getFileMF().getSize();
		String filename = "";
		
		if(filesize > 0){
			if(oldfile!=null && !oldfile.equals("member.jpg")){
				Utility.deleteFile(basePath, oldfile);
			}
			filename = Utility.saveFile(dto.getFileMF(), basePath);
		}
		dto.setFilename(filename);
		
		
		if(dao.update(dto)){
			model.addAttribute("col",col);
			model.addAttribute("word",word);
			model.addAttribute("nowPage",nowPage);
			
			return "redirect:./list"; 
		}
		else{
			return "error";
		}
		 
	}
	
	
	
	
	@RequestMapping("/team/read")
	public String read(int no, Model model){
		
		model.addAttribute("dto", dao.read(no));
		return "team/read";
		
		
	}
	

	@RequestMapping("/team/list")
	public String list(HttpServletRequest request) {
		// --寃��깋愿��젴
		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));
		if (col.equals("total"))
			word = "";

		// --�럹�씠吏뺢��젴
		int nowPage = 1;// �쁽�옱�럹�씠吏� ,蹂�寃쎄��뒫
		if (request.getParameter("nowPage") != null) {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
		int recordPerPage = 5;// �븳�럹�씠吏��떦 蹂댁뿬以� �젅肄붾뱶 媛��닔

		// DB媛��졇�삱 �닚踰� �깮�꽦
		int sno = ((nowPage - 1) * recordPerPage) + 1;
		int eno = nowPage * recordPerPage;

		Map map = new HashMap();
		map.put("col", col);
		map.put("word", word);
		map.put("sno", sno);
		map.put("eno", eno);

		int total = dao.total(col, word);
		List<TeamDTO> list = dao.list(map);
		String paging = Utility.paging3(total, nowPage, recordPerPage, col, word);

		request.setAttribute("list", list);
		request.setAttribute("col", col);
		request.setAttribute("word", word);
		request.setAttribute("nowPage", nowPage);
		request.setAttribute("paging", paging);

		return "/team/list";
	}

	@RequestMapping(value = "/team/create", method = RequestMethod.GET)
	public String create() {

		return "/team/createForm";
	}

	@RequestMapping(value="/team/create", method=RequestMethod.POST)
	public String create(TeamDTO dto, HttpServletRequest request, HttpServletResponse response) throws Throwable {
		// TODO Auto-generated method stub
		
		String basePath = request.getRealPath("/team/storage");
		
		int size = (int)dto.getFileMF().getSize();
		String filename = null;
		
		if(size > 0){
			filename = Utility.saveFile(dto.getFileMF(), basePath);
		}else{
			filename = "member.jpg";
		}
		dto.setFilename(filename);
		
		
		if(dao.create(dto)){
			return "redirect:./list";
		}
		else{
			return "error";
		}

	}
}
