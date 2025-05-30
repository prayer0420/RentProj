package controller.mypage;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dto.Member;
import service.member.MemberService;
import service.member.MemberServiceImpl;

@WebServlet("/myInfoModify")
public class MyInfoModify extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MyInfoModify() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		String id = (String)session.getAttribute("id");
		MemberService memberService = new MemberServiceImpl();
		Member member = null;
		try {
			member = memberService.getMemberById(id);
			System.out.println(member);
			request.setAttribute("member", member);
			request.getRequestDispatcher("/JSP/MyPage/myInfoModify.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/login");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		// 파일 업로드 경로 지정
		// getRealPath("upload")는 웹 애플리케이션의 /upload 폴더에 해당하는 실제 서버 경로를 반환
		String path = request.getServletContext().getRealPath("/upload");

		// 업로드 파일의 최대 크기 (10MB)
		int maxSize = 10 * 1024 * 1024;

		// 파일 업로드 처리 (cos.jar 라이브러리 사용)
		// - 요청 객체, 저장 경로, 최대 파일 크기, 인코딩 방식, 파일 이름 중복 처리 정책 설정
		// - 파일은 지정된 경로에 자동 저장됨
		MultipartRequest multi = new MultipartRequest(request, path, maxSize, "utf-8", new DefaultFileRenamePolicy());

		// 세션 체크
		HttpSession session = request.getSession(false);
		/*
		 * if (session == null || session.getAttribute("member") == null) {
		 * response.sendRedirect(request.getContextPath() + "/login"); return; }
		 */
		String sessionId = (String)session.getAttribute("id");
		Member member = null;
		try {
			member = new MemberServiceImpl().getMemberById(sessionId);
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		
		// 업로드 후 form 필드 데이터 추출 (request가 아닌 multi에서 꺼내야 함)
		// ⚙️ 입력값 가져오되, 비어있으면 기존 값 유지
		String id = getOrDefault(multi, "id", member.getId());
		String password = getOrDefault(multi, "password", null);
		System.out.println(password);
		String confirmPassword = getOrDefault(multi, "confirmPassword", null);
		String name = getOrDefault(multi, "name", member.getName());
		String nickname = getOrDefault(multi, "nickname", member.getNickname());
		String phone = getOrDefault(multi, "phone", member.getPhone());

		// 비밀번호 확인 불일치 시 오류 처리
		if (password != null && !password.equals(confirmPassword)) {
			request.setAttribute("error", "비밀번호가 일치하지 않습니다.");
			request.getRequestDispatcher("/JSP/MyPage/myInfoModify.jsp").forward(request, response);
			return;
		}

		//  비밀번호를 입력하지 않았으면 기존 값 유지
		if (password == null || password.trim().isEmpty()) {
			password = member.getPassword();
			System.out.println("비밀번호 기존값 으로"+password);
		}

		// 프로필 이미지 처리
		String newProfileImage = multi.getFilesystemName("profileImage");
		String profileImage = member.getProfileImage();

		if (newProfileImage != null) {
			profileImage = "/upload/profile/" + newProfileImage;

			// 기존 이미지 삭제 (선택사항)
			String oldImagePath = request.getServletContext().getRealPath(member.getProfileImage());
			File oldFile = new File(oldImagePath);
			if (oldFile.exists())
				oldFile.delete();
		}

		// 업데이트할 Member 객체 생성
		Member updatedMember = new Member();
		updatedMember.setId(id);
		updatedMember.setPassword(password);
		updatedMember.setNickname(nickname);
		updatedMember.setName(name);
		updatedMember.setPhone(phone);
		updatedMember.setProfileImage(profileImage);

		// 기존 정보 유지 항목
		updatedMember.setAddress1(member.getAddress1());
		updatedMember.setAddress2(member.getAddress2());
		updatedMember.setAddress3(member.getAddress3());
		updatedMember.setGradeId(member.getGradeId());
		updatedMember.setAdminNo(member.getAdminNo());
		updatedMember.setOrderCount(member.getOrderCount());
		updatedMember.setLocation(member.getLocation());
		updatedMember.setFcmToken(member.getFcmToken());
		updatedMember.setLatitude(member.getLatitude());
		updatedMember.setLongitude(member.getLongitude());

		try {
			MemberService service = new MemberServiceImpl();
			//DB에 갱신
			service.updateMember(updatedMember);

			// 수정 완료 후 리다이렉트
			session.setAttribute("message", "개인정보가 성공적으로 수정되었습니다!");
			session.setAttribute("id", updatedMember.getId());
			response.sendRedirect(request.getContextPath() + "/myInfoModify");

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "회원 정보 수정에 실패했습니다.");
			request.getRequestDispatcher("/JSP/MyPage/myInfoModify.jsp").forward(request, response);
		}
	}

	// null 또는 빈 문자열일 경우 defaultValue를 반환하는 헬퍼 메서드
	private String getOrDefault(MultipartRequest multi, String name, String defaultValue) {
		String param = multi.getParameter(name);
		return (param == null || param.trim().isEmpty()) ? defaultValue : param;
	}
}