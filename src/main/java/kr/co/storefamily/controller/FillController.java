package kr.co.storefamily.controller;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.storefamily.model.Fill;
import kr.co.storefamily.model.Resume;
import kr.co.storefamily.model.Schedule;
import kr.co.storefamily.service.FillService;
import kr.co.storefamily.service.MypageService;

@Controller
public class FillController {

	@Autowired
	private FillService FillService;
	
	@Autowired
	private MypageService MypageService; 
	
	@RequestMapping(value="fill")
	public String fill(HttpSession session, Model model) {
		String position = (String)session.getAttribute("position");
		model.addAttribute("position", position);

		if(position.equals("직원"))
			return "redirect:/my_fill_list";
		else
			return "redirect:/my_store_fill_list";
	}

	@RequestMapping(value="my_fill_list")
	public String my_fill_list(HttpSession session, Model model) throws Exception {
		String code = (String)session.getAttribute("code");
		String id = (String)session.getAttribute("id");

		List<Fill> my_fill_list = this.FillService.my_fill_list(code,id);
		model.addAttribute("my_fill_list", my_fill_list);
		return "Fill/employee/my_fill_list";
	}
	
	@RequestMapping(value="/my_fill_apply_content")
	public String my_fill_apply_content(@RequestParam(value="bno", required = false) int bno,Model model,HttpSession session) throws Exception {
		Fill fill_apply_content = this.FillService.fill_apply_content(bno);
		String local_do = this.FillService.fill_local_do(fill_apply_content.getLocal_do());
		String local_si = this.FillService.fill_local_si(fill_apply_content.getLocal_si(),fill_apply_content.getLocal_do());
		
		String id = (String)session.getAttribute("id");
		String code = (String)session.getAttribute("code");
		int count = this.FillService.fill_apply_count(bno,id);

		List<Resume> my_resume_list = this.FillService.resume_list(id);

		int resume_bno;
		int resume_count = this.FillService.resume_count(bno,id);

		if(resume_count == 0)
			resume_bno = 0;
		else
			resume_bno = this.FillService.resume_bno(bno,id);

		List<Fill> this_apply_list = this.FillService.this_apply_list(bno);

		model.addAttribute("this_apply_list", this_apply_list);
		model.addAttribute("fill_apply_content", fill_apply_content);
		model.addAttribute("count", count);
		model.addAttribute("my_resume_list", my_resume_list);
		model.addAttribute("id", id);
		model.addAttribute("code", code);
		model.addAttribute("resume_bno", resume_bno);
		model.addAttribute("local_do", local_do);
		model.addAttribute("local_si", local_si);
		
		//리스트
		List<Fill> my_fill_list = this.FillService.my_fill_list(code,id);
		model.addAttribute("my_fill_list", my_fill_list);
		
		return "Fill/employee/my_fill_apply_content";
	}
	
	@RequestMapping(value="/fill_all_list")
	public String fill_all_list(Model model) throws Exception {
		List<Fill> fill_all_list = this.FillService.fill_all_list();
		model.addAttribute("fill_all_list", fill_all_list);
		return "Fill/common/fill_all_list";
	}

	@RequestMapping(value="fill_write")
	public String fill_write(Model model, HttpSession session) throws Exception {
		String code = (String)session.getAttribute("code");
		String id = (String)session.getAttribute("id");

		List<Schedule> my_schedule = this.FillService.my_schedule(code,id);
		List<Fill> my_fill_list = this.FillService.my_fill_list(code,id);
		
		model.addAttribute("my_fill_list", my_fill_list);

		model.addAttribute("my_schedule",my_schedule);
		model.addAttribute("fill", new Fill());
		return "Fill/employee/fill_write";
	}
	
	@RequestMapping(value="fill_resume_write")
	public String fill_resume_write(Model model, HttpSession session) throws Exception {
		String code = (String)session.getAttribute("code");
		String id = (String)session.getAttribute("id");

		List<Fill> my_fill_list = this.FillService.my_fill_list(code,id);
		
		model.addAttribute("my_fill_list", my_fill_list);

		model.addAttribute("fill", new Fill());
		return "Fill/employee/resume_write";
	}

	@RequestMapping(value="fill_write_ok")
	public String fill_write_ok(@ModelAttribute("fill_write")@Valid Fill fill) throws Exception {
		Schedule this_schedule = this.FillService.this_schedule(fill.getSchedule_bno());

		fill.setName(this_schedule.getName());
		fill.setId(this_schedule.getId());
		fill.setCode(this_schedule.getCode());
		fill.setFill_day(this_schedule.getDay());
		fill.setFill_start_time(this_schedule.getStart_time());
		fill.setFill_end_time(this_schedule.getEnd_time());
		fill.setFill_di_time(this_schedule.getDi_time());

		if(this.FillService.fill_write_ok(fill) == 1)
			return "redirect:/fill";
		else
			return "redirect:/fill_write_ok";
	}

	//내 매장 대타 리스트
	@RequestMapping(value="/my_store_fill_list")
	public String my_store_fill_list(HttpSession session, Model model) throws Exception {
		String code = (String)session.getAttribute("code");

		List<Fill> my_store_fill_list = this.FillService.my_store_fill_list(code);
		model.addAttribute("my_store_fill_list", my_store_fill_list);
		return "Fill/ceo/my_store_fill_list";
	}
	
	@RequestMapping(value="/fill_content")
	public String fill_content(@RequestParam(value="bno", required = false)int bno, Model model, HttpSession session) throws Exception {
		Fill fill_apply_content = this.FillService.fill_apply_content(bno);
		
		String id = (String)session.getAttribute("id");
		int count = this.FillService.fill_apply_count(bno,id);
		
		model.addAttribute("count", count);
		model.addAttribute("fill_apply_content", fill_apply_content);
		return "Fill/common/fill_apply_content";
	}

	@RequestMapping(value="/apply_go")
	public String apply_go(@RequestParam(value="bno", required = false)int bno, Model model, HttpSession session) throws Exception {
		Fill fill_apply_content = this.FillService.fill_apply_content(bno);
		
		String id = (String)session.getAttribute("id");
		int count = this.FillService.fill_apply_count(bno,id);
		List<Resume> my_resume_list = this.FillService.resume_list(id);
		
		int resume_bno;
		int resume_count = this.FillService.resume_count(bno,id);

		if(resume_count == 0)
			resume_bno = 0;
		else
			resume_bno = this.FillService.resume_bno(bno,id);
		
		model.addAttribute("fill_apply_content", fill_apply_content);
		model.addAttribute("my_resume_list", my_resume_list);
		model.addAttribute("count", count);
		model.addAttribute("resume_bno", resume_bno);
		return "Fill/common/apply_go";
	}
	
	@RequestMapping(value="/resume_write")
	public String resume_write() throws Exception {
		return "Fill/common/resume_write";
	}
	
	@RequestMapping(value="resume_write_ok")
	public String resume_write_ok(@ModelAttribute("resume_write")@Valid Resume resume, HttpSession session) throws Exception {
		System.out.println(resume.getTitle());
		System.out.println(resume.getStart_day());
		String id = (String)session.getAttribute("id");
		String code = (String)session.getAttribute("code");
		String name = (String)session.getAttribute("name");

		resume.setId(id);
		resume.setCode(code);
		resume.setName(name);
	
		resume.setPeriod("1");
		System.out.println(resume.getTitle());
		System.out.println(resume.getWork_place());
		System.out.println(resume.getWork_activity());

		if(this.MypageService.resume_write_ok(resume) == 1)
			return "redirect:/resume_list";
		else
			return "redirect:/resume_write";
	}

	@RequestMapping(value="/fill_apply_content")
	public String fill_apply_content(@RequestParam(value="bno", required = false) int bno,Model model,HttpSession session) throws Exception {
		Fill fill_apply_content = this.FillService.fill_apply_content(bno);
		String local_do = this.FillService.fill_local_do(fill_apply_content.getLocal_do());
		String local_si = this.FillService.fill_local_si(fill_apply_content.getLocal_si(),fill_apply_content.getLocal_do());
		
		String id = (String)session.getAttribute("id");
		String code = (String)session.getAttribute("code");
		int count = this.FillService.fill_apply_count(bno,id);

		List<Resume> my_resume_list = this.FillService.resume_list(id);

		int resume_bno;
		int resume_count = this.FillService.resume_count(bno,id);

		if(resume_count == 0)
			resume_bno = 0;
		else
			resume_bno = this.FillService.resume_bno(bno,id);

		List<Fill> this_apply_list = this.FillService.this_apply_list(bno);

		model.addAttribute("this_apply_list", this_apply_list);
		model.addAttribute("fill_apply_content", fill_apply_content);
		model.addAttribute("count", count);
		model.addAttribute("my_resume_list", my_resume_list);
		model.addAttribute("id", id);
		model.addAttribute("code", code);
		model.addAttribute("resume_bno", resume_bno);
		model.addAttribute("local_do", local_do);
		model.addAttribute("local_si", local_si);
		
		//리스트
		List<Fill> my_store_fill_list = this.FillService.my_store_fill_list(code);
		model.addAttribute("my_store_fill_list", my_store_fill_list);
		
		return "Fill/ceo/fill_apply_content";
	}

	@RequestMapping(value="fill_registrar_ok")
	public String fill_registar_ok(@RequestParam(value="bno", required = false) int bno, HttpSession session,Fill fill) throws Exception {

		String bussiness = (String)session.getAttribute("bussiness");
		String field = (String)session.getAttribute("field");
		String local_do = (String)session.getAttribute("local_do");
		String local_si = (String)session.getAttribute("local_si");

		fill.setBussiness(bussiness);
		fill.setField(field);
		
		String find_local_do = this.FillService.fill_local_do(local_do);
		String find_local_si = this.FillService.fill_local_si(local_si, local_do);
		fill.setLocal_do(find_local_do);
		fill.setLocal_si(find_local_si);
		

		if(this.FillService.fill_registrar_ok(bno) == 1)
		{
			this.FillService.fill_apply_add(fill);
			return "redirect:/fill_apply_content?bno="+bno;
		}
		else
		{
			System.out.println("g");
			return "redirect:/fill_apply_contentbno="+bno;
		}
	}

	@RequestMapping(value="fill_registrar_cancle")
	public String fill_registrar_cancle(@RequestParam(value="bno", required = false)int bno) throws Exception {
		if(this.FillService.fill_registrar_cancle(bno)==1)
			return "redirect:/fill_apply_content?bno="+bno;
		else
			return "redirect:/fill_apply_content?bno="+bno;
	}

	@RequestMapping(value="fill_apply")
	public String fill_apply(@ModelAttribute("fill_apply_content")@Valid Fill fill, HttpSession session) throws Exception {
		String id = (String)session.getAttribute("id");
		String m_name = (String)session.getAttribute("name");
		String code = (String)session.getAttribute("code");

		fill.setId(id);
		fill.setM_name(m_name);
		fill.setCode(code);
		
		String resume_title = this.FillService.resume_title(fill.getResume_bno());
		fill.setResume_title(resume_title);

		System.out.println(fill.getResume_bno());
		if(this.FillService.fill_apply(fill) == 1)
		{
			this.FillService.fill_apply_su_up(fill.getFill_bno());
			return "redirect:/fill_content?bno="+fill.getBno();
		}
		else
			return "redirect:/fill_content?bno="+fill.getBno();
	}

	@RequestMapping(value="fill_apply_cancle")
	public String fill_apply_cancle(@RequestParam(value="bno", required = false)int bno,HttpSession session) throws Exception {
		String id = (String)session.getAttribute("id");
		if(this.FillService.fill_apply_cancle(bno,id)==1)
		{
			this.FillService.fill_apply_su_down(bno);
			return "redirect:/fill_content?bno="+bno;
		}
		else
			return "redirect:/fill_content?bno="+bno;
	}

	@RequestMapping(value="fill_apply_resume_change")
	public String fill_apply_resume_change(@ModelAttribute("fill_content")@Valid Fill fill, HttpSession session) throws Exception {
		String id = (String)session.getAttribute("id");
		fill.setId(id);
		if(this.FillService.fill_apply_resume_change(fill)==1)
			return "redirect:/fill_apply_content?bno="+fill.getBno();
		else
			return "redirect:/fill_apply_content?bno="+fill.getBno();
	}

	@RequestMapping(value="fill_apply_ok")
	public String fill_apply_ok(@ModelAttribute("fill_apply_content")@Valid Fill fill, HttpSession session) throws Exception {
		Fill apply_content = this.FillService.apply_content(fill.getBno());

		if(this.FillService.fill_apply_chk_ok(fill.getBno())==1)
		{
			this.FillService.fill_apply_chk_no(fill.getFill_bno(),fill.getBno());
			this.FillService.fill_apply_ok(apply_content);
			return "redirect:/fill_apply_content?bno="+fill.getFill_bno();
		}
		else
			return "redirect:/fill_apply_content?bno="+fill.getFill_bno();

	}

	@RequestMapping(value="fill_apply_no")
	public String fill_apply_no(@ModelAttribute("fill_apply_content")@Valid Fill fill) throws Exception {
		if(this.FillService.fill_apply_no(fill.getBno()) == 1)
		{
			this.FillService.fill_apply_reset(fill);
			return "redirect:/fill_apply_content?bno="+fill.getFill_bno();
		}
		else
			return "redirect:/fill_apply_content?bno="+fill.getFill_bno();
	}

	@RequestMapping(value="apply_resume_content")
	public String apply_resume_content(@RequestParam(value="resume_bno", required = false)String resume_bno, Model model) throws Exception {
		System.out.println("apply_resume"+resume_bno);
		int bno = Integer.parseInt(resume_bno);
		Resume resume_content = this.FillService.apply_resume_content(bno);

		String[] work_place = resume_content.getWork_place().split(",");
		String[] work_activity = resume_content.getWork_activity().split(",");
		String[] period = resume_content.getPeriod().split(",");

		model.addAttribute("resume_content", resume_content);
		model.addAttribute("work_place", work_place);
		model.addAttribute("work_activity", work_activity);
		model.addAttribute("period", period);
		return "Fill/ceo/apply_resume_content";
	}
}
