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
import org.springframework.web.servlet.HttpServletBean;

import spring.model.teamImage.ImageDAO;
import spring.model.teamImage.ImageDTO;
import spring.utility.blog.Utility;

@Controller
public class TeamImageController {

	@Autowired
	private ImageDAO dao;	
	
	
	@RequestMapping(value="/teamimage/reply", method=RequestMethod.GET)
	public String reply(int no, Model model){
		
		model.addAttribute("dto", dao.readReply(no));
		return "/teamimage/replyForm";
	}
	@RequestMapping(value="/teamimage/reply", method=RequestMethod.POST)
	public String reply(HttpServletRequest request, ImageDTO dto){
		
		String basePath = request.getRealPath("/teamimage/storage");
		int filesize = (int)dto.getFileMF().getSize();
		String filename = "";
		if(filesize>0){
			filename = Utility.saveFile(dto.getFileMF(), basePath);
		}
		dto.setFilename(filename);
		
		if(dao.createReply(dto)){
			return "redirect:./list";
		}
		else{
			return "error";
		}
	}
	
	
	
	
	@RequestMapping(value="/teamimage/delete", method=RequestMethod.GET)
	public String delete(int no, Model model){
		
		model.addAttribute("flag",dao.checkRefno(no));
		
		return "/teamimage/deleteForm";
	}
	@RequestMapping(value="/teamimage/delete", method=RequestMethod.POST)
	public String delete(int no, Model model ,String col, String word, String nowPage, String passwd ){
		
		Map map = new HashMap();

		map.put("no", no);
		map.put("passwd", passwd);
		
		if(dao.passwd(map)){
			if(dao.delete(no)){
				model.addAttribute("col", col);
				model.addAttribute("word", word);
				model.addAttribute("nowPage", nowPage);
				return "redirect:./list";
			}
			else{
				return "error";
			}
		}
		else{
			return "passerror";
		}
	}
	
	
	
	
	
	@RequestMapping(value="/teamimage/update", method=RequestMethod.GET)
	public String update(int no,Model model){
		model.addAttribute("dto", dao.read(no));
		return "/teamimage/updateForm";
	}
	
	@RequestMapping(value="/teamimage/update", method=RequestMethod.POST)
	public String update(ImageDTO dto,  HttpServletRequest request){
		
		String basePath = request.getRealPath("/teamimage/storage");
		int filesize = (int)dto.getFileMF().getSize();
		String oldfile = dto.getFilename();
		String filename = "";
		if(filesize>0){
			filename= Utility.saveFile(dto.getFileMF(), basePath);
			dto.setFilename(filename);
		
			if(dao.update(dto)){
				Utility.deleteFile(basePath, oldfile);
				return "redirect:./list";
			}
			else{
				return "error";
			}
		}
		else{
			return  "redirect:./list";
		}
		
		
		

	}
	
	
	@RequestMapping("/teamimage/list")
	public String list(HttpServletRequest request){

		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));
		if(col.equals("total")){
			word="";
		}
		
		int nowPage = 1;
		if(request.getParameter("nowPage")!=null)
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		int recordPerPage = 5;
		
		int sno = ((nowPage-1)*recordPerPage)+1;
		int eno = nowPage * recordPerPage;
		
		Map map = new HashMap();
		map.put("col", col);
		map.put("word", word);
		map.put("sno", sno);
		map.put("eno", eno);
		
		int totalRecord = dao.total(col, word);
		List<ImageDTO> list = dao.list(map);
		
		String paging = Utility.paging3(totalRecord, nowPage, recordPerPage, col, word);
		
		request.setAttribute("list", list);
		request.setAttribute("col", col);
		request.setAttribute("word", word);
		request.setAttribute("nowPage", nowPage);
		request.setAttribute("paging", paging);
		
		return "/teamimage/list";
	}
	
	@RequestMapping("/teamimage/read")
	public String read(int no, Model model){
		
		dao.upViewcnt(no);
		List list = dao.sumnail(no);
		String[] files = (String[])list.get(0);
		int[] noArr = (int[])list.get(1);
		
		
		model.addAttribute("files", files);
		model.addAttribute("noArr", noArr);
		
		model.addAttribute("dto",dao.read(no));
		return "/teamimage/read";
	}
	
	
	
	@RequestMapping(value="/teamimage/create",method=RequestMethod.GET)
	public String create(){
		return "/teamimage/createForm";
	}
	
	@RequestMapping(value="/teamimage/create",method=RequestMethod.POST)
	public String create(ImageDTO dto, HttpServletRequest request){
		
		String basePath = request.getRealPath("/teamimage/storage");
		int filesize = (int)dto.getFileMF().getSize();
		String filename = "";
		if(filesize>0){
			filename = Utility.saveFile(dto.getFileMF(), basePath);
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
