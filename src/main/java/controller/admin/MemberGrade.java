package controller.admin;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dto.Grade;
import service.member.GradeService;
import service.member.GradeServiceImpl;

/**
 * Servlet implementation class MemberGrade
 */
@WebServlet("/memberGrade")
public class MemberGrade extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberGrade() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            GradeService gradeService = new GradeServiceImpl();
            // 전체 등급 가져오기
            List<Grade> gradeList = gradeService.getAllGrades(); 

            request.setAttribute("gradeList", gradeList);
            request.getRequestDispatcher("JSP/Admin/memberGrade.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "등급 정보를 불러오는데 실패했습니다.");
        }
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    // 요청 및 응답 인코딩 설정
	    request.setCharacterEncoding("utf-8");
	    response.setContentType("application/json; charset=utf-8");

	    try {
	        // 1. 클라이언트에서 전송된 JSON 데이터 읽기
	        BufferedReader reader = request.getReader();
	        StringBuilder jsonBuffer = new StringBuilder();
	        String line;
	        while ((line = reader.readLine()) != null) {
	            jsonBuffer.append(line);
	        }
	     // 전체 JSON 문자열
	        String json = jsonBuffer.toString(); 

	        // 2. JSON 문자열을 Grade 객체 배열로 파싱
	        Gson gson = new Gson();
	        Grade[] grades = gson.fromJson(json, Grade[].class); // JSON → Grade[]

	        // 3. 서비스 객체 생성
	        GradeService gradeService = new GradeServiceImpl();

	        // 4. 각 Grade 객체에 대해 update 실행
	        for (Grade grade : grades) {
	            gradeService.updateGrade(grade);
	        }

	        // 5. 클라이언트에 성공 응답 반환
	        response.getWriter().write("{\"status\":\"success\"}");
	    } catch (Exception e) {
	        // 에러 로그 출력 및 실패 응답 전송
	        e.printStackTrace();
	        response.setStatus(500);
	        response.getWriter().write("{\"status\":\"error\"}");
	    }
	}
}
