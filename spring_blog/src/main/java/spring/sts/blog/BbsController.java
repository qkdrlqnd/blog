package spring.sts.blog;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.rmi.CORBA.Util;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import spring.model.bbs.BbsDAO;
import spring.model.bbs.BbsDTO;
import spring.utility.blog.Utility;

@Controller
public class BbsController {

	@Autowired
	private BbsDAO dao;
	
	
	@RequestMapping(value="/bbs/delete",method=RequestMethod.GET)
	public String delete(){
		return "/bbs/deleteForm";
	}
	@RequestMapping(value="/bbs/delete",method=RequestMethod.POST)
	public String delete(int bbsno, Model model, String passwd, String oldfile, HttpServletRequest request){
		
		String basePath = request.getRealPath("/bbs/storage");
		
		Map map = new HashMap();
		map.put("bbsno", bbsno);
		map.put("passwd", passwd);
		boolean flag = dao.checkRefno(bbsno);
		model.addAttribute("flag", flag);
		
		if(flag){
				model.addAttribute("flag",flag);
				return "/bbs/deleteForm";
		}
		else{
			if(dao.passCheck(map)){
				if(dao.delete(bbsno)){
					Utility.deleteFile(basePath, oldfile);
					return "redirect:./list";
				}
				else {
					return "error";
				}
			}else{
				return "passError";
			}
		}
	}
	
	
	@RequestMapping(value="/bbs/reply",method=RequestMethod.GET)
	public String reply(int bbsno, Model model){
		
		model.addAttribute("dto", dao.readReply(bbsno));
		
		return "/bbs/replyForm";
	}
	@RequestMapping(value="/bbs/reply",method=RequestMethod.POST)
	public String reply(int bbsno, BbsDTO dto, Model model, HttpServletRequest request){
	
		
		String basePath = request.getRealPath("/bbs/storage");
		
		int filesize = (int)dto.getFileMF().getSize();
		String filename ="";
		
		if(filesize>0){
			filename = Utility.saveFile(dto.getFileMF(), basePath);
		}
		dto.setFilename(filename);
		dto.setFilesize(filesize);
		Map map = new HashMap();
		map.put("grpno", dto.getGrpno());
		map.put("ansnums", dto.getAnsnum());
		
		if(dao.createReply(dto)){

			return "redirect:./list";
		}
		else{
			Utility.deleteFile(basePath, filename);
			return "error";
		}
	}
	
	@RequestMapping(value="/bbs/create", method=RequestMethod.GET)
	public String create(){
		return "/bbs/createForm";
	}
	@RequestMapping(value="/bbs/create", method=RequestMethod.POST)
	public String create(Model model, BbsDTO dto, HttpServletRequest request){
		
		
		String basePath = request.getRealPath("/bbs/storage");
		
		int filesize = (int)dto.getFileMF().getSize();
		String filename ="";
		
		if(filesize>0){
			filename = Utility.saveFile(dto.getFileMF(), basePath);
		}
		dto.setFilename(filename);
		dto.setFilesize(filesize);
		
		if(dao.create(dto)){
			return "redirect:./list";
		}
		else{
			Utility.deleteFile(basePath, filename);
			return "error";
		}
	}
	
	
	
	
	@RequestMapping(value="/bbs/update",method=RequestMethod.GET)
	public String update(int bbsno, Model model){
		model.addAttribute("dto", dao.read(bbsno));
		return "/bbs/updateForm";
	}
	@RequestMapping(value="/bbs/update",method=RequestMethod.POST)
	public String update(int bbsno, Model model ,BbsDTO dto, String oldfile ,String col,String word, String nowPage, HttpServletRequest request){
		
		String basePath = request.getRealPath("/bbs/storage");
		
		int filesize = (int)dto.getFileMF().getSize();
		String filename = "";
		
		if(filesize>0){
			filename = Utility.saveFile(dto.getFileMF(), basePath);
		}
		dto.setFilename(filename);
		dto.setFilesize(filesize);
		Map map = new HashMap();
		map.put("bbsno", dto.getBbsno());
		map.put("passwd", dto.getPasswd());

		boolean pflag = dao.passCheck(map);
		
		
		if(pflag){
			if(dao.update(dto)){
				Utility.deleteFile(basePath, oldfile);
				model.addAttribute("col", col);
				model.addAttribute("word", word);
				model.addAttribute("nowPage", nowPage);
				
				return "redirect:./list";
			}else{
				return "error";
			}
		}
		else{
			if(filesize>0){
				Utility.deleteFile(basePath, filename);
			}
			return "passwdError";
		}
	}
	
	
	
	
	@RequestMapping("/bbs/read")
	public String read(int bbsno, BbsDTO dto, Model model){
		
		dao.upViewcnt(bbsno);
		dto = dao.read(bbsno);
		model.addAttribute("dto", dto);
 
		return "/bbs/read";
	}
	
	
	
	
	
	
	@RequestMapping("/bbs/list")
	public String list(HttpServletRequest request, HttpServletResponse response){
		
		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));

		if(col.equals("total")){
			word="";
		}
		
		int nowPage = 1;
		if(request.getParameter("nowPage")!=null){
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
		
		int recordPerPage=5;
		
		int sno = ((nowPage - 1 )* recordPerPage +1);
		int eno = nowPage * recordPerPage;
		
		Map map = new HashMap();
		map.put("col", col);
		map.put("word", word);
		map.put("eno", eno);
		map.put("sno", sno);

		List<BbsDTO> list = dao.list(map);
		
		int totalRecord = dao.total(col, word);
		
		String paging = Utility.paging3(totalRecord, nowPage, recordPerPage, col, word);
		
	
		
		request.setAttribute("list", list);
		request.setAttribute("col", col);
		request.setAttribute("word", word);
		request.setAttribute("nowPage", nowPage);
		request.setAttribute("paging", paging);
	

		
		return "/bbs/list";
		
	}
	
	
}
