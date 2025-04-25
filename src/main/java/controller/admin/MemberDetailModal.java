package controller.admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Member;
import service.member.MemberService;
import service.member.MemberServiceImpl;

/**
 * Servlet implementation class MemberDetailModal
 */
@WebServlet("/memberDetailModal")
public class MemberDetailModal extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberDetailModal() {
        super();
        // TODO Auto-generated constructor stub
    }


    // 대여지연리스트 팝업 표출용으로 추가
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String memberId = request.getParameter("memberId");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        MemberService memberService = new MemberServiceImpl();
        
        try {
            Member member = memberService.getMemberById(memberId);
            if (member != null) {
                out.println("<p><strong>회원번호:</strong> " + member.getNo() + "</p>");
                out.println("<p><strong>등급:</strong> " + member.getGradeId() + "</p>");
                out.println("<p><strong>이름:</strong> " + member.getName() + "</p>");
                out.println("<p><strong>아이디:</strong> " + member.getId() + "</p>");
                out.println("<p><strong>닉네임:</strong> " + member.getNickname() + "</p>");
                out.println("<p><strong>전화번호:</strong> " + member.getPhone() + "</p>");
                out.println("<p><strong>주소1:</strong> " + member.getAddress1() + "</p>");
                out.println("<p><strong>주소2:</strong> " + member.getAddress2() + "</p>");
                out.println("<p><strong>주소3:</strong> " + member.getAddress3() + "</p>");
                out.println("<p><strong>거래지역1:</strong> " + member.getRegion1() + "</p>");
                out.println("<p><strong>거래지역2:</strong> " + member.getRegion2() + "</p>");
                out.println("<p><strong>거래지역3:</strong> " + member.getRegion3() + "</p>");
                out.println("<p><strong>주문횟수:</strong> " + member.getOrderCount() + "</p>");
                out.println("<p><strong>가입일:</strong> " + member.getRegDate() + "</p>");
            } else {
                out.println("<p>해당 회원을 찾을 수 없습니다.</p>");
            }
        } catch (Exception e) {
            out.println("<p>회원 정보 조회 중 오류 발생</p>");
            e.printStackTrace(out);
        }
    }
}