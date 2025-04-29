package controller.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dto.Announce;
import service.announce.AnnounceService;
import service.announce.AnnounceServiceImpl;

/**
 * Servlet implementation class AnnounceUpdate
 */
@WebServlet("/announceUpdate")
public class AnnounceUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AnnounceUpdate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  // POST 방식으로 공지사항 수정 처리
	        // [1] 업로드 경로 
			String path = request.getServletContext().getRealPath("/upload"); // 서버상의 upload 폴더 경로

	        // [2] MultipartRequest를 사용해 파일 업로드 처리
	        MultipartRequest multi = new MultipartRequest(request, path, 50 * 1024 * 1024, "UTF-8", new DefaultFileRenamePolicy());


	        // [3] 전송된 form 데이터 꺼내기
	        int no = Integer.parseInt(multi.getParameter("no")); // 공지사항 번호
	        String title = multi.getParameter("title"); // 제목
	        String content = multi.getParameter("content"); // 내용
	        String imgUrl = multi.getFilesystemName("ifile"); // 업로드된 이미지 파일명
	        


	        // [4] DTO 객체 생성 및 값 설정
	        Announce announce = new Announce();
	        announce.setNo(no);
	        announce.setTitle(title);
	        announce.setContent(content);
	        
	        // 기존 이미지 파일명 처리
	        if (imgUrl == null) {
	            imgUrl = multi.getParameter("existingImage");  // 기존 이미지 경로 유지
	        } else {
	            announce.setImgUrl(imgUrl);
	        }

	        // [5] 서비스 호출하여 DB에 공지사항 수정
	        try {
	            AnnounceService service = new AnnounceServiceImpl();
	            boolean success = service.updateAnnounce(announce);

	            // 수정 성공 시: JSON 응답
	            response.setContentType("application/json");
	            response.getWriter().write("{\"success\": " + success + "}");
	        } catch (Exception e) {
	            e.printStackTrace();
	            // 수정 실패 시: 에러 메시지 반환
	            response.setContentType("application/json");
	            response.getWriter().write("{\"success\": false, \"message\": \"공지사항 수정 실패\"}");
	        }
	    }
	}
