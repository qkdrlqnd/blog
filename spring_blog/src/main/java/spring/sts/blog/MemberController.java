package spring.sts.blog;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.junit.runner.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import spring.model.member.MemberDAO;
import spring.model.member.MemberDTO;
import spring.utility.blog.Utility;

@Controller
public class MemberController {

	@Autowired
	private MemberDAO dao;
	
	@RequestMapping("/member/agreement")
	public String agree() {
		return "/member/agreement";
	}

	@RequestMapping(value = "/member/create", method = RequestMethod.GET)
	public String create() {
		return "/member/createForm";
	}

	@RequestMapping(value = "/member/create", method = RequestMethod.POST)
	public String create(MemberDTO dto, Model model, HttpServletRequest request) {

		String str = null;
		String viewPage = "member/prcreateProc";
		if (dao.duplicateID(dto.getId())) {
			str = "�ߺ��� ���̵��Դϴ�. �ߺ�Ȯ���ϼ���";
			request.setAttribute("str", str);
		} else if (dao.duplicateEmail(dto.getEmail())) {
			str = "�ߺ��� �̸����ּ��Դϴ�. �ߺ�Ȯ���ϼ���";
			request.setAttribute("str", str);
		} else {
			String upDir = request.getRealPath("/member/storage");

			String filename = "";
			int filesize = (int) dto.getFileMF().getSize();
			if (filesize > 0) {
				filename = Utility.saveFile(dto.getFileMF(), upDir);
			}
			dto.setFname(filename);
			boolean flag = dao.create(dto);
			
			
			if(flag){
				viewPage = "redirect:";
			}
			else{
				viewPage = "error";
			}
			
			
		}
		return viewPage;
	}
	
	@RequestMapping("/member/id_proc")
	public String id_proc(String id, Model model){
		
		boolean flag = dao.duplicateID(id);
		
		model.addAttribute("id",id);
		model.addAttribute("flag",flag);
		
		return "/member/id_proc";
	}
	@RequestMapping("/member/id_form")
	public String id_form(){
		
		return "/member/id_form";
	}
	
	@RequestMapping("/member/email_proc")
	public String email_proc(String email, Model model){
		
		boolean flag = dao.duplicateEmail(email);
		
		model.addAttribute("email",email);
		model.addAttribute("flag",flag);
		
		return "/member/email_proc";
	}
	@RequestMapping("/member/email_form")
	public String email_form(){
		
		return "/member/email_form";
	}
	
	
	@RequestMapping(value="/member/login" , method=RequestMethod.GET)
	public String login(HttpServletRequest request){
		
		/*----��Ű���� �������----------------------------*/
		String c_id = ""; // ID ���� ���θ� �����ϴ� ����, Y
		String c_id_val = ""; // ID ��

		Cookie[] cookies = request.getCookies();
		Cookie cookie = null;

		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				cookie = cookies[i];

				if (cookie.getName().equals("c_id")) {
					c_id = cookie.getValue(); // Y
				} else if (cookie.getName().equals("c_id_val")) {
					c_id_val = cookie.getValue(); // user1...
				}
			}
		}

		/*----��Ű���� ���� ��----------------------------*/

		request.setAttribute("c_id", c_id);
		request.setAttribute("c_id_val", c_id_val);
		return "/member/loginForm";
	}
	
	@RequestMapping(value="/member/login" , method=RequestMethod.POST)
	public String login(String id, String passwd, String c_id,HttpServletResponse response, HttpSession session){

		boolean flag = dao.loginCheck(id, passwd);
		String grade = null;
		if (flag) { // ȸ���ΰ��
			grade = dao.getGrade(id);
			session.setAttribute("id", id);
			session.setAttribute("grade", grade);

			Cookie cookie = null;

			if (c_id != null) { // ó������ ���� �������� null üũ�� ó��
				cookie = new Cookie("c_id", "Y"); // ���̵� ���� ���� ��Ű
				cookie.setMaxAge(120); // 2 �� ����
				response.addCookie(cookie); // ��Ű ���

				cookie = new Cookie("c_id_val", id); // ���̵� �� ���� ��Ű
				cookie.setMaxAge(120); // 2 �� ����
				response.addCookie(cookie); // ��Ű ���
			} else {
				cookie = new Cookie("c_id", ""); // ��Ű ����
				cookie.setMaxAge(0);
				response.addCookie(cookie);

				cookie = new Cookie("c_id_val", ""); // ��Ű ����
				cookie.setMaxAge(0);
				response.addCookie(cookie);
			}
			return "redirect:../";
		}
		else{
			return "/member/idPWError";
		}
		
		
		
	}
	
	
	@RequestMapping("/member/logout")
	public String logout(HttpSession session){
		session.invalidate();
		
		return "redirect:../";
	}
	
	
	@RequestMapping("/member/read")
	public String read(HttpServletRequest request, HttpSession session){
		
		//�����ڰ� list���� idŬ���ϰ� ����� ����������
		String id = (String)request.getParameter("id");
		
		//read.jsp���� ȸ����� ��ư �����ֱ� ���� ����
		String grade = (String)request.getParameter("grage");
		
		
		//�Ϲݻ���ڰ� �α��� �� �޴���Ͽ��� ���� �޴��� ��������
		if(id == null){ //�����ڰ� �ƴҋ�
			id = (String)session.getAttribute("id");
		}
		
		MemberDTO dto = dao.read(id);

		request.setAttribute("dto", dto);
		request.setAttribute("id", id);
		request.setAttribute("grade", grade);
		
		
		
		return "/member/read";
	}
	
	
	@RequestMapping(value="/member/update", method=RequestMethod.GET)
	public String update(HttpServletRequest request, HttpSession session){
		
		//�����ڰ� list���� idŬ���ϰ� ����� ����������
				String id = (String)request.getParameter("id");
				
				//�Ϲݻ���ڰ� �α��� �� �޴���Ͽ��� ���� �޴��� ��������
				if(id == null){ //�����ڰ� �ƴҋ�
					id = (String)session.getAttribute("id");
				}
				
				MemberDTO dto = dao.read(id);

				request.setAttribute("dto", dto);
				request.setAttribute("id", id);
				

		return "/member/updateFo";
	}
	
	@RequestMapping(value="/member/update", method=RequestMethod.POST)
	public String update(MemberDTO dto, String col, String word, String nowPage, Model model, HttpSession session, HttpServletRequest request){
		
		
		String id = (String) session.getAttribute("id");
		String grade = (String) session.getAttribute("grade");
		
		if(dao.update(dto)){
			if(nowPage != null && nowPage.equals("")){
				model.addAttribute("col",col);
				model.addAttribute("word",word);
				model.addAttribute("nowPage",nowPage);
				return "redirect:../admin/list";
			}else{
				
				return "redirect:../";
			}
		}
		else{
			return "error";
		}
	}
	
	
	@RequestMapping(value="/member/updateFile", method=RequestMethod.GET)
	public String updateFile(){
		
		return "/member/updateForm";
	}
	
	
	@RequestMapping(value="/member/updateFile", method=RequestMethod.POST)
	public String updateFile(String id, String oldfile, MultipartFile fileMF, String col, String word, String nowPage, HttpServletRequest request, Model model){
		
		String basePath = request.getRealPath("/member/storage");
		String filename = "member1.jpg";
		int filesize = (int)fileMF.getSize();
		if(filesize>0){
			
			filename = Utility.saveFile(fileMF, basePath);
		}
		
		if(dao.updateFile(id, filename)){
			if(oldfile!= "member1.jpg" && !oldfile.equals("member1.jgp")){
				Utility.deleteFile(basePath, oldfile);
			}
			return "redirect:../";
		}
		else{
			return "error";
		}
	}
	
	

	@RequestMapping("/admin/list")
	public String list(HttpServletRequest request) {

		// �˻�����
		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));

		if (col.equals("total")) {
			word = "";
		}

		// ����¡����
		int nowPage = 1;
		int recordPerPage = 5;

		if (request.getParameter("nowPage") != null) {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}

		// DB���� ������ ����
		int sno = ((nowPage - 1) * recordPerPage) + 1;
		int eno = nowPage * recordPerPage;

		Map map = new HashMap();
		map.put("eno", eno);
		map.put("sno", sno);
		map.put("word", word);
		map.put("col", col);

		int total = dao.total(col, word);
		List<MemberDTO> list = dao.list(map);
		Iterator<MemberDTO> iter = list.iterator();

		String paging = Utility.paging3(total, nowPage, recordPerPage, col, word);

		request.setAttribute("list", list);
		request.setAttribute("iter", iter);
		request.setAttribute("col", col);
		request.setAttribute("word", word);
		request.setAttribute("nowPage", nowPage);
		request.setAttribute("paging", paging);

		return "/admin/list";

	}
	
	
	
	
	
	
	
	
	@RequestMapping(value="/member/delete", method=RequestMethod.GET)
	public String delete(HttpSession session,  Model model){
		
		String id = (String)session.getAttribute("id");
		String oldfile = dao.getFname(id);
		
		model.addAttribute("id",id);
		model.addAttribute("oldfile", oldfile);
		
		return "/member/deleteForm";
	}
	
	
	@RequestMapping(value="/member/delete", method=RequestMethod.POST)
	public String delete(String id, String oldfile, HttpServletRequest request, HttpSession session){
		
		String basePath = request.getRealPath("/member/storage");
		if(dao.delete(id)){
			Utility.deleteFile(basePath, oldfile);
			session.invalidate();
			return "redirect:../";
		}
		else{
			return "error";
		}
		
	}
	
	
	
	
	
}
