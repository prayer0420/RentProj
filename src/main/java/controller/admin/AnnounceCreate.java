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
import service.AnnounceService;
import service.AnnounceServiceImpl;

/**
 * Servlet implementation class AnnounceCreateServlet
 */
@WebServlet("/announceCreate")
public class AnnounceCreate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AnnounceCreate() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 // [1] 업로드 경로 및 최대 파일 크기 설정
        String path = request.getServletContext().getRealPath("upload");
        int size = 50 * 1024 * 1024; // 최대 파일 크기 50MB

        // [2] MultipartRequest를 사용해 파일 업로드 처리
        MultipartRequest multi = new MultipartRequest(request, path, size, "utf-8", new DefaultFileRenamePolicy());

        // [3] 전송된 form 데이터 꺼내기
        String title = multi.getParameter("title"); // 제목
        String content = multi.getParameter("content"); // 내용
        String imgUrl = multi.getFilesystemName("ifile"); // 업로드된 이미지 파일명
        
        // 기존 이미지 파일명이 있으면 기존 값 유지
        if (imgUrl == null) {
            imgUrl = multi.getParameter("existingImage"); // 기존 이미지 경로 유지
        }

        // [4] DTO 객체 생성 및 값 설정
        Announce announce = new Announce();
        announce.setTitle(title);
        announce.setContent(content);
        announce.setImgUrl(imgUrl); // 업로드된 이미지 경로 설정

        // [5] 서비스 호출하여 DB에 공지사항 등록
        try {
            AnnounceService service = new AnnounceServiceImpl();
            boolean success = service.createAnnounce(announce);

            // 저장 성공 시: JSON 응답
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": " + success + "}");
        } catch (Exception e) {
            e.printStackTrace();
            // 저장 실패 시: 에러 메시지 반환
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"공지사항 등록 실패\"}");
        }
    }
}