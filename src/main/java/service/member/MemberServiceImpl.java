package service.member;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import dao.member.MemberDAO;
import dao.member.MemberDAOImpl;
import dto.LoginResult;
import dto.Member;
import utils.PageInfo;

public class MemberServiceImpl implements MemberService {

	private MemberDAO memberDao;

	public MemberServiceImpl() {
		memberDao = new MemberDAOImpl();
	}

	@Override
	public void join(Member member) throws Exception {
		// DB로부터 아이디 중복 체크
		Member smember = memberDao.selectMemberById(member.getId());
		if (smember != null)
			throw new Exception("회원가입 오류");

		// 멤버 등록(DB)
		memberDao.insertMember(member);
	}

	@Override
	public Member login(String id, String password) throws Exception {
		// DB로부터 ID일치여부 확인
		Member member = memberDao.selectMemberById(id);
		if (member == null)
			throw new Exception("로그인 오류");

		// DB로부터 password 일치여부 확인
		if (!member.getPassword().equals(password))
			throw new Exception("로그인 오류");
		return member;
	}

	@Override
	public boolean checkDoubleId(String id) throws Exception {
		// 이미 DB에있는건 중복임(false로넘김)
		Member member = memberDao.selectMemberById(id);
		if (member == null)
			return true;
		return false;
	}

	@Override
	public LoginResult KakaoLogin(String code) throws Exception {
		String token = getKakaoToken(code);
		Member member = getKakaoUserInfo(token);

		Member existing = memberDao.selectMemberById(member.getId());
	    boolean isFirstLogin = false;

		// 카카오로그인 처음만 하고, 그후에 추가한건 적용이 되어야함
	    if (existing == null) {
	        memberDao.insertMember(member);
	        isFirstLogin = true;
	        System.out.println("카카오 처음 로그인");
	        return new LoginResult(member, true);
	    } else {
	        existing.setNickname(member.getNickname());
	        existing.setProfileImage(member.getProfileImage());
	        memberDao.updateMember(existing);
	        return new LoginResult(existing, false);
	    }
	}

	public String getKakaoToken(String code) throws Exception {

		// 토큰 넘겨주기
		String tokenUrl = "https://kauth.kakao.com/oauth/token";
		URL url = new URL(tokenUrl);

		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		conn.setDoOutput(true); // 출력스트림 활성화

		StringBuilder param = new StringBuilder();
		param.append("grant_type=authorization_code");
		param.append("&client_id=26cbd2829d45a2e79ba779ab7d6c059c");
		param.append("&redirect_uri=http://localhost:8080/rent/kakao");// Redirect_URI: 임시로 join
		param.append("&code=" + code);

		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
		bw.write(param.toString());
		bw.flush();

		// 응답체크
		BufferedReader br;
		int resCode = conn.getResponseCode();
		if (resCode >= 200 & resCode <= 300) {
			// 정상
			br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			// 오류
			br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}

		StringBuilder resBuilder = new StringBuilder();
		String line;
		while ((line = br.readLine()) != null) {
			resBuilder.append(line);
		}

		br.close();
		conn.disconnect();
		System.out.println(resBuilder.toString());

		// access_token가져오기 위해 JSON parsing
		JSONParser parser = new JSONParser();
		JSONObject jsonObj = (JSONObject) parser.parse(resBuilder.toString());
		return (String) jsonObj.get("access_token");
	}

	Member getKakaoUserInfo(String token) throws Exception {
		String userUrl = "https://kapi.kakao.com/v2/user/me";
		URL url = new URL(userUrl);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		conn.setRequestProperty("Authorization", "Bearer " + token);

		BufferedReader br;
		int resCode = conn.getResponseCode();
		if (resCode >= 200 && resCode <= 300) {
			// 정상
			br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			// 오류
			br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}

		StringBuilder resBuilder = new StringBuilder();
		String line;
		while ((line = br.readLine()) != null) {
			resBuilder.append(line);
		}

		br.close();
		conn.disconnect();
		System.out.println(resBuilder.toString());

		JSONParser parser = new JSONParser();
		JSONObject jsonObj = (JSONObject) parser.parse(resBuilder.toString());
		Long idLong = (Long) jsonObj.get("id");
		String id = String.valueOf(idLong);
		JSONObject properties = (JSONObject) jsonObj.get("properties");
		String nickname = (String) properties.get("nickname");
		String profile_image = (String) properties.get("profile_image");

		Member member = new Member(id, nickname, profile_image);
		System.out.println("kakaoMember" + member);
		return member;
	}

	@Override
	public LoginResult NaverLogin(String code) throws Exception {
		String token = getNaverToken(code);
		Member member = getNaverUserInfo(token);

	    Member existing = memberDao.selectMemberById(member.getId());
	    boolean isFirstLogin = false;

		System.out.println(member);
	    if (existing == null) {
	        memberDao.insertMember(member);
	        isFirstLogin = true;
	        return new LoginResult(member, true);
	    } else {
	        existing.setNickname(member.getNickname());
	        existing.setProfileImage(member.getProfileImage());
	        memberDao.updateMember(existing);
	        return new LoginResult(existing, false);
	    }
	}

	String getNaverToken(String code) throws Exception {
		String client_id = "F6Q5T61yYsZTND6Hay0F";
		String secret_id = "AzxEWqxTXa";
		StringBuilder apiURL = new StringBuilder("https://nid.naver.com/oauth2.0/token?");
		apiURL.append("client_id=" + client_id);
		apiURL.append("&client_secret=" + secret_id);
		apiURL.append("&grant_type=authorization_code");
		apiURL.append("&state=7564");
		apiURL.append("&code=" + code);

		URL url = new URL(apiURL.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");

		// 토큰 읽기
		int resCode = conn.getResponseCode();
		BufferedReader br;
		if (resCode == 200) {
			// 정상
			br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			// 오류
			br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}

		StringBuilder resBuilder = new StringBuilder();
		String line;
		while ((line = br.readLine()) != null) {
			resBuilder.append(line);
		}

		br.close();
		conn.disconnect();

		JSONParser parser = new JSONParser();
		JSONObject jsonObj = (JSONObject) parser.parse(resBuilder.toString());
		return (String) jsonObj.get("access_token");
	}

	private Member getNaverUserInfo(String token) throws Exception {

		URL url = new URL("https://openapi.naver.com/v1/nid/me");

		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Authorization", "bearer " + token);

		BufferedReader br;
		int resCode = conn.getResponseCode();
		if (resCode == 200) {
			// 정상
			br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			// 오류
			br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}

		StringBuilder resBuilder = new StringBuilder();
		String line;
		while ((line = br.readLine()) != null) {
			resBuilder.append(line);
		}

		br.close();
		conn.disconnect();

		JSONParser parser = new JSONParser();
		JSONObject jsonObj = (JSONObject) parser.parse(resBuilder.toString());
		JSONObject response = (JSONObject) jsonObj.get("response");
		String id = (String) response.get("id");
		String nickname = (String) response.get("nickname");
		String profile_image = (String) response.get("profile_image");

		Member member = new Member(id, nickname, profile_image);
		System.out.println("naverMember" + member);
		return member;
	}

	// 관리자: 회원 목록 조회 + 페이징 처리
	@Override
	public List<Member> searchMembersWithPaging(Map<String, Object> params, PageInfo pageInfo) throws Exception {
		// 검색 조건에 맞는 총 회원 수를 DB에서 조회함
		Integer totalCnt = memberDao.selectMembersCountWithFilter(params);
		// 검색 결과가 없으면, 페이지 정보도 0으로 초기화하고 빈 리스트를 반환함
		if (totalCnt == 0) {
			pageInfo.setAllPage(0);
			pageInfo.setStartPage(0);
			pageInfo.setEndPage(0);
			return new ArrayList<>(); // 빈 리스트 반환
		}
		// 페이징 정보 계산
		// 전체 데이터 개수를 페이지당 게시물 수로 나눠서 총 페이지 수를 구함
		// 페이지 블록의 시작 페이지, 끝 페이지 계산
		Integer allPage = (int) Math.ceil((double) totalCnt / pageInfo.getPageSize());
		Integer startPage = (pageInfo.getCurPage() - 1) / 10 * 10 + 1;
		Integer endPage = startPage + 10 - 1;
		if (endPage > allPage)
			endPage = allPage;
		// PageInfo에 페이징 정보 저장
		pageInfo.setAllPage(allPage);
		pageInfo.setStartPage(startPage);
		pageInfo.setEndPage(endPage);
		pageInfo.setTotalCount(totalCnt);
		// DB 조회용 페이징 파라미터 준비 (eg. 페이지 1 → row = 0, 페이지 2 → row = 10)
		int row = (pageInfo.getCurPage() - 1) * pageInfo.getPageSize();
		params.put("row", row);
		params.put("size", pageInfo.getPageSize());
		// 최종 DAO 호출
		return memberDao.searchMembersWithPaging(params);
	}

	// 관리자정보 조회용
	@Override
	public Member selectAdmin() {
		return memberDao.selectAdmin();
	}

	// 관리자정보 수정용
	@Override
	public void updateAdminInfo(Member member) throws Exception {
		memberDao.updateAdminInfo(member);

	}
	
    //카카오 위치 요청 및 위치 업데이트
    public String updateLocationAndGetAddress(int memberNo, double lat, double lng) {
        try {
    	  String kakaoKey = "KakaoAK 26cbd2829d45a2e79ba779ab7d6c059c";
          String apiUrl = "https://dapi.kakao.com/v2/local/geo/coord2address.json?x=" + lng + "&y=" + lat;
          HttpURLConnection conn = (HttpURLConnection) new URL(apiUrl).openConnection();
          conn.setRequestMethod("GET");
          conn.setRequestProperty("Authorization", kakaoKey);

          BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
          StringBuilder sb = new StringBuilder();
          String line;
          while ((line = br.readLine()) != null) sb.append(line);
          br.close();

          String json = sb.toString();
          JsonObject jsonObj = JsonParser.parseString(json).getAsJsonObject();
          String address = jsonObj.getAsJsonArray("documents")
                                 .get(0).getAsJsonObject()
                                 .get("address").getAsJsonObject()
                                 .get("address_name").getAsString();

          memberDao.updateLocation(memberNo, lat, lng, address);
          return address;
        } catch (Exception e) {
          e.printStackTrace();
          return "";
        }
      }
    
    //회원정보 수정,업데이트
    @Override
    public void updateMember(Member member) throws Exception {
    	memberDao.updateMember(member);
    }
    
    //회원정보조회(ID로)
    @Override
    public Member getMemberById(String id) throws Exception {
        return memberDao.selectMemberById(id);
    }
    

}
