// MyAddressServlet.java
package controller.mypage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.Member;
import dto.ParsedAddress;
import service.member.MemberService;
import service.member.MemberServiceImpl;
import utils.AddressParser;

@WebServlet("/myAddress")
public class MyAddress extends HttpServlet {

    // 배송지 조회 처리: GET 요청 처리
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        // 세션에서 로그인한 사용자 정보 가져오기
        HttpSession session = request.getSession(false);
        Member sessionMember = (Member) session.getAttribute("member");

        if (sessionMember == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        MemberService service = new MemberServiceImpl();
        try {
            // DB에서 Member 정보 조회 (배송지 포함)
            Member member = service.getMemberById(sessionMember.getId());

            // 배송지 문자열 → 파싱된 객체 리스트로 변환
            List<ParsedAddress> addressList = AddressParser.parseAddresses(member);

            // request에 담아서 JSP로 전달
            request.setAttribute("addressList", addressList);
            request.getRequestDispatcher("/JSP/MyPage/myAddress.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "배송지 조회 실패");
            request.getRequestDispatcher("/JSP/Error/error.jsp").forward(request, response);
        }
    }

    // 배송지 추가, 수정, 삭제 처리: POST 요청 처리
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        HttpSession session = request.getSession(false);
        Member sessionMember = (Member) session.getAttribute("member");

        if (sessionMember == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action"); // add / update / delete
        MemberService service = new MemberServiceImpl();

        try {
            Member member = service.getMemberById(sessionMember.getId());
            List<String> addresses = new ArrayList<>();
            if (member.getAddress1() != null) addresses.add(member.getAddress1());
            if (member.getAddress2() != null) addresses.add(member.getAddress2());
            if (member.getAddress3() != null) addresses.add(member.getAddress3());

            if ("delete".equals(action)) {
            	// 삭제할 주소 파라미터 수집
                String alias = request.getParameter("alias");
                String zipcode = request.getParameter("zipcode");
                String address = request.getParameter("address");
                String detail = request.getParameter("detail");

                // 삭제할 문자열 조합
                String toDelete = AddressParser.buildAddressString(alias, 
                				zipcode, address, detail);

                // 리스트에서 해당 주소 제거
                addresses.removeIf(a -> a.startsWith(toDelete));

            } else if ("add".equals(action) || "update".equals(action)) {
                // 입력 값 수집
                String alias = request.getParameter("alias");
                String zipcode = request.getParameter("zipcode");
                String address = request.getParameter("address");
                String detail = request.getParameter("detail");
                String recipient = request.getParameter("recipient");
                String phone = request.getParameter("phone");
                String oldAlias = request.getParameter("oldAlias");
                boolean isDefault = "true".equals(request.getParameter("isDefault"));

                // 값 검증
                if (alias == null || zipcode == null || address == null || detail == null || recipient == null || phone == null ||
                    alias.isBlank() || zipcode.isBlank() || address.isBlank() || detail.isBlank() || recipient.isBlank() || phone.isBlank()) {
                    request.setAttribute("error", "모든 항목을 입력해주세요.");
                    request.getRequestDispatcher("/JSP/Error/error.jsp").forward(request, response);
                    return;
                }

                String newAddr = alias + "@@" + zipcode + "@@" + address + "@@" + detail;

                // 기존에 같은 alias 주소 있으면 제거
                addresses.removeIf(a -> a.startsWith(oldAlias != null ? oldAlias : alias));

                if (isDefault) {
                    // 기본 배송지는 맨 앞에 추가 (address1이 됨)
                    addresses.add(0, newAddr);
                } else {
                    // 기존 리스트 끝에 추가
                    addresses.add(newAddr);
                }

                // 최대 3개 제한
                while (addresses.size() > 3) {
                    addresses.remove(addresses.size() - 1);
                }
            }

            // 다시 member에 반영
            member.setAddress1(addresses.size() > 0 ? addresses.get(0) : null);
            member.setAddress2(addresses.size() > 1 ? addresses.get(1) : null);
            member.setAddress3(addresses.size() > 2 ? addresses.get(2) : null);

            service.updateMember(member); // DB 저장
            session.setAttribute("member", member); // 세션 갱신

            response.sendRedirect(request.getContextPath() + "/myAddress");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "배송지 처리 실패");
            request.getRequestDispatcher("/JSP/Error/error.jsp").forward(request, response);
        }
    }


}
