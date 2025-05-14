package com.ohot.employee.controller;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ohot.employee.service.EmployeeService;
import com.ohot.employee.vo.ApprovalLineVO;
import com.ohot.employee.vo.ApprovalVO;
import com.ohot.employee.vo.ApprovedConcertPlanVO;
import com.ohot.employee.vo.ApprovedConversionRequestVO;
import com.ohot.employee.vo.AtrzDocVO;
import com.ohot.employee.vo.AtrzLineVO;
import com.ohot.employee.vo.AtrzRefVO;
import com.ohot.employee.vo.DepartmentVO;
import com.ohot.employee.vo.EmployeeScheduleVO;
import com.ohot.vo.CustomUser;
import com.ohot.vo.EmployeeVO;
import com.ohot.vo.UsersVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/emp")
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	
	@GetMapping("/home")
	public String home(){
		log.info("직원 홈페이지 (전자결재)");
		return "employee/home";
	}
	
	@GetMapping("/treeList")
	public String treeList() {
		
		return "employee/tree";
	}
	
	@ResponseBody
	@GetMapping("/treeListAjax")
	public String treeListAjax(){
		
		List<DepartmentVO> treeList = this.employeeService.treeList();
		
		
		JSONArray jsonArray = new JSONArray();
		Set<String> deptSet = new HashSet<>();
		
		for(DepartmentVO row : treeList) {
			
			log.info("row:" + row);
			
			String deptNo = String.valueOf(row.getDeptNo());
			String upDept = (row.getUpDept() == 0) ? "#" : String.valueOf(row.getUpDept());
			String deptNm = row.getDeptNm();
			
			// json  import org.json.JSONArray; import org.json.JSONObject; 사용!
			if(!deptSet.contains(deptNo)) {
				
				
				JSONObject deptNode = new JSONObject();
				deptNode.put("id", deptNo);
				deptNode.put("parent", upDept);
				deptNode.put("text", deptNm != null ? deptNm : "(이름없음)");
				deptNode.put("icon", "fas fa-folder");
				jsonArray.put(deptNode);
				deptSet.add(deptNo);
			}
			
			//사원정보 추가
			List<EmployeeVO> empList = row.getEmployeeVOList();
			
			if(empList != null) {
				
				for(EmployeeVO emp : empList) {
					
					log.info("emp" + emp);
					
					String empNo = String.valueOf(emp.getEmpNo());
					String empNm = emp.getEmpNm();
					String position = emp.getPosition();
					String jbgdCd = emp.getJbgdCd();
					
					JSONObject empNode = new JSONObject();
					empNode.put("id", empNo);
					empNode.put("parent", deptNo);
					empNode.put("text", empNm + " (" + position + ")");
					empNode.put("icon", "fas fa-user-circle");
					
					
					JSONObject data = new JSONObject();
					String empEmail = emp.getEmpEmlAddr();
					position = emp.getPosition();
					jbgdCd = emp.getJbgdCd();
					/* deptNm = emp.getDepartmentVO().getDeptNm(); */
					String stampFileGroupNo = String.valueOf(emp.getStampFileGroupNo());
					String profileSaveLocate = emp.getProfileSaveLocate();
					
					data.put("email", empEmail);
					data.put("position", position);
					data.put("deptNm", deptNm);
					data.put("empNm", empNm);
					data.put("position", position);
					data.put("jbgdCd", jbgdCd);
					data.put("stampFileGroupNo", stampFileGroupNo);
					data.put("profileSaveLocate", profileSaveLocate);
							
					empNode.put("data", data);
					
					jsonArray.put(empNode);
				}
			}
		}
		log.info("jsonArray : " +jsonArray.toString());
		
		return jsonArray.toString();
	}
	
	@GetMapping("/atrzHome")
	public String atrzHome() {
		
		return "employee/atrz/atrzHome";
	}
	
	@GetMapping("/empCalendar")
	public String empCalendar() {
		
		return "employee/calendar/empCalendar";
	}
	
	@GetMapping("/atrzHome/form")
	public String documentList(@RequestParam(value="formNo") int formNo) {
		
		log.info("formNo : " + formNo);
		
		if(formNo == 2) {
			return "employee/document/ticketPlan";
		}else if(formNo == 1) {
			return "employee/document/goodsPlan";
		}else {
			return "employee/document/artistConversionRequest";
		}
		
	}
	
	@GetMapping("/atrzList")
	public String atrzList(
			Model model
			, @AuthenticationPrincipal CustomUser customUser) {

		// 로그인한 사원 정보 
		UsersVO usersVO = customUser.getUsersVO();
		long empNo = usersVO.getUserNo();
		
		int cntEmrgAtrz = this.employeeService.cntEmrgAtrz(empNo);
		int cntRefAtrz = this.employeeService.cntRefAtrz(empNo);
		int cntWaitAtrz = this.employeeService.cntWaitAtrz(empNo);
		int cntReadyAtrz = this.employeeService.cntReadyAtrz(empNo);
		
		model.addAttribute("cntEmrgAtrz", cntEmrgAtrz);
		model.addAttribute("cntRefAtrz", cntRefAtrz);
		model.addAttribute("cntWaitAtrz", cntWaitAtrz);
		model.addAttribute("cntReadyAtrz", cntReadyAtrz);
		
		return "employee/atrz/atrzList";
	}
	
	@ResponseBody
	@PostMapping("/atrzListAjax")
	public Map<String, Object> atrzListAjax(
			@RequestBody Map<String, Object> data
			, @AuthenticationPrincipal CustomUser customUser) {
		log.info("atrzListAjax: " + data);
	
		// 로그인한 사원 정보 
		UsersVO usersVO = customUser.getUsersVO();
		long empNo = usersVO.getUserNo();
		
		data.put("empNo", empNo);
		
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(String.valueOf(data.get("page")));
		} catch (Exception e) {
			log.warn("페이지 파싱 실패, 기본값 1 사용");
		}
	
		log.info("안담기니? 담기렴" + data);
		int size = 10;
	
		List<DepartmentVO> atrzAllList = this.employeeService.atrzAllList(data);
		log.info("search->atrzListAjax: " + atrzAllList);
		
		int total = 0;
		if (atrzAllList != null && !atrzAllList.isEmpty()) {
		    total = atrzAllList.get(0).getTotalCnt();
		}
		log.info("total 행: " + total);
	
		int totalPages = (int) Math.ceil((double) total / size);
		int startPage = Math.max(1, currentPage - 5);
		int endPage = Math.min(totalPages, currentPage + 4);
	
		log.info("이게 필요핸가?: " + totalPages + "start: " + startPage + "end: " + endPage);
	
		Map<String, Object> result = new HashMap<>();
		result.put("content", atrzAllList);
		result.put("currentPage", currentPage);
		result.put("totalPages", totalPages);
		result.put("startPage", startPage);
		result.put("endPage", endPage);
	
		return result;
	}
	
	@GetMapping("/atrzDocBox")
	public String atrzDocBox() {
			
		return "employee/atrz/atrzDocBox";
	}
	
	@ResponseBody
	@PostMapping("/atrzDocBoxAjax")
	public Map<String, Object> atrzDocBoxAjax(
			@RequestBody Map<String, Object> data
			, @AuthenticationPrincipal CustomUser customUser) {
		log.info("atrzDocBoxAjax: " + data);
	
		// 로그인한 사원 정보 
		UsersVO usersVO = customUser.getUsersVO();
		long empNo = usersVO.getUserNo();
		
		data.put("empNo", empNo);
		
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(String.valueOf(data.get("page")));
		} catch (Exception e) {
			log.warn("페이지 파싱 실패, 기본값 1 사용");
		}
	
		log.info("안담기니? 담기렴" + data);
		int size = 10;
	
		List<DepartmentVO> atrzDocBoxList = this.employeeService.atrzDocBoxList(data);
		log.info("search->atrzDocBoxList: " + atrzDocBoxList);
		
		int total = 0;
		if (atrzDocBoxList != null && !atrzDocBoxList.isEmpty()) {
		    total = atrzDocBoxList.get(0).getTotalCnt();
		}
		log.info("total 행: " + total);
	
		int totalPages = (int) Math.ceil((double) total / size);
		int startPage = Math.max(1, currentPage - 5);
		int endPage = Math.min(totalPages, currentPage + 4);
	
		log.info("이게 필요핸가?: " + totalPages + "start: " + startPage + "end: " + endPage);
	
		Map<String, Object> result = new HashMap<>();
		result.put("content", atrzDocBoxList);
		result.put("currentPage", currentPage);
		result.put("totalPages", totalPages);
		result.put("startPage", startPage);
		result.put("endPage", endPage);
	
		return result;
	}
	
	
	@GetMapping("/empProfile")
	public String empProfile() {
		
		return "employee/empProfile/profile";
	}
	
	@ResponseBody
	@PostMapping("/saveApprovalLine")
	public Map<String, Object> saveApprovalLine(@RequestBody ApprovalLineVO data) {

		log.info("approvals" + data.getApprovals());
		log.info("referrers" + data.getReferrers());
		
		List<ApprovalVO> approvalVOList = data.getApprovals();
		List<ApprovalVO> referrerVOList = data.getReferrers();
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("approvalVOList", approvalVOList);
		resultMap.put("referrerVOList", referrerVOList);
	
		return resultMap;
	}
	
	@ResponseBody
	@PostMapping("/atrzDocPost")
	public String atrzDocPost(@RequestPart("test") AtrzDocVO atrzDocVO, Model model) {
		
		log.info("atrzDocPost->atrzDocVO : " + atrzDocVO);
		
		String atrzDocNo = this.employeeService.atrzDocInsert(atrzDocVO);
		log.info("atrzDocPost->atrzDocInsert : " + atrzDocNo);
		
		return atrzDocNo;
	}
	
	@GetMapping("/atrzDocDetail")
	public String atrzDocDetail(
			@RequestParam(value="atrzDocNo") String atrzDocNo
			, Model model
			, @AuthenticationPrincipal CustomUser customUser) {
		
		// 로그인한 사원 정보 
		UsersVO usersVO = customUser.getUsersVO();
		long empNo = usersVO.getUserNo();
		
		log.info("atrzDocDetail->empNo : " + empNo);
		
		DepartmentVO atrzDocVODetail = this.employeeService.atrzDocDetail(atrzDocNo);
		List<DepartmentVO> atrzRefVOList = this.employeeService.atrzRefDetail(atrzDocNo);
		List<DepartmentVO> atrzLineVOList = this.employeeService.atrzLineDetail(atrzDocNo);
		ApprovedConcertPlanVO approvedConcertPlanVODetail = this.employeeService.aprrovedConcertPlanDetail(atrzDocNo);
		ApprovedConversionRequestVO approvedConversionRequestVODetail = this.employeeService.approvedConversionRequestDetail(atrzDocNo);
		
		// 결재할 차례인지 체크
		boolean canApprove = this.employeeService.checkCanApprove(atrzLineVOList, empNo);
		log.info("atrzDocDetail->canApprove : " + canApprove);
		
		model.addAttribute("atrzDocVODetail", atrzDocVODetail);
		model.addAttribute("atrzRefVOList", atrzRefVOList);
		model.addAttribute("atrzLineVOList", atrzLineVOList);
		model.addAttribute("approvedConcertPlanVODetail", approvedConcertPlanVODetail);
		model.addAttribute("approvedConversionRequestVODetail", approvedConversionRequestVODetail);
		
		model.addAttribute("canApprove", canApprove);
		
		return "employee/atrz/atrzDetail";
	}
	
	@ResponseBody
	@PostMapping("/atrzLineUpdate")
	public String atrzLineUpdate(@RequestBody AtrzLineVO atrzLineVO) {
	
		int result = this.employeeService.atrzLineUpdate(atrzLineVO);

		if(result != 0) {
			return "success";
		}
		
		return "fail";
	}
	
	@ResponseBody
	@PostMapping("/updateRefRead")
	public String updateRefRead(@RequestBody AtrzRefVO atrzRefVO) {
		
		log.info("updateRefRead=>atrzRefVO", atrzRefVO);
		
		int result = this.employeeService.updateRefIdntyYn(atrzRefVO);
		
		return atrzRefVO.getAtrzDocNo();
	}
	
	
	///// 스케줄 시작 //////
	@ResponseBody
	@GetMapping("/fullcalendar")
	public List<EmployeeScheduleVO> fullCalendar(@AuthenticationPrincipal CustomUser customUser
	                              , Model model
	      ) throws Exception {
	   
	   long empNo = customUser.getUsersVO().getUserNo();
	   
	   List<EmployeeScheduleVO> employeeScheduleVOList = this.employeeService.getEmployeeSchedule(empNo);
	   
	   return employeeScheduleVOList;
	}
	
	@PostMapping("/eidtEmployeeSchedule")
	public String editPersnalSchedule(EmployeeScheduleVO employeeScheduleVO) {
		
		employeeScheduleVO.setBorderColor(employeeScheduleVO.getBackgroundColor());
		
		log.info("/emp/addPersnalSchedule : " + employeeScheduleVO);
		this.employeeService.editEmployeeSchedule(employeeScheduleVO);
		
		return "redirect:/emp/home";
	}
	
	@ResponseBody
	@GetMapping("/deleteEmployeeSchedule")
	public String deleteEmployeeSchedule(int employeeScheduleNo) {
		
		log.info("employeeScheduleNo : " + employeeScheduleNo);
		
		int result = this.employeeService.deleteEmployeeSchedule(employeeScheduleNo);
		if(result > 0) {
			return "success";
		}
		
		return "fail";
	}
	
	@PostMapping("/addSchedule")
	public String addSchedule(@AuthenticationPrincipal CustomUser customUser
					,EmployeeScheduleVO employeeScheduleVO) {
		employeeScheduleVO.setBorderColor(employeeScheduleVO.getBackgroundColor());
		if(employeeScheduleVO.getType().equals("persnal")) {
			employeeScheduleVO.setEmpNo(customUser.getUsersVO().getUserNo());
			employeeScheduleVO.setDeptNo(0);
		}else {
			employeeScheduleVO.setDeptNo(customUser.getUsersVO().getEmployeeVO().getDeptNo());
		}
		this.employeeService.addEmployeeSchedule(employeeScheduleVO);
		
		return "redirect:/emp/home";
	}
	
	///// 스케줄 끝 //////
}
