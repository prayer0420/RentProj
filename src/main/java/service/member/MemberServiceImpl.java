package service.member;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import dao.member.MemberDAO;
import dao.member.MemberDAOImpl;
import dto.Member;

public class MemberServiceImpl implements MemberService {

	private MemberDAO memberDao;

	public MemberServiceImpl() {
		memberDao = new MemberDAOImpl();
	}

	@Override
	public void join(Member member) throws Exception {
		// DB로부터 아이디 중복 체크
		Member smember = memberDao.SelectMember(member.getId());
		if (smember != null)
			throw new Exception("회원가입 오류");

		// 멤버 등록(DB)
		memberDao.insertMember(member);
	}

	@Override
	public Member login(String id, String password) throws Exception {
		// DB로부터 ID일치여부 확인
		Member member = memberDao.SelectMember(id);
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
		Member member = memberDao.SelectMember(id);
		if (member == null)
			return true;
		return false;
	}

	@Override
	public Member KakaoLogin(String code) throws Exception {
		String token = getKakaoToken(code);
		System.out.println(token);
		Member member = getKakaoUserInfo(token);

		// 카카오로그인 처음만 하고, 그후에 추가한건 적용이 되어야함
		Member smember = memberDao.SelectMember(member.getId());
		System.out.println(member);
		if (smember == null) {
			memberDao.insertMember(member);
			return member;
		} else {
			smember.setNickname(member.getNickname());
			smember.setProfileImage(member.getProfileImage());
			memberDao.updateMember(smember);
			return smember;
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
	public Member NaverLogin(String code) throws Exception {
		String token = getNaverToken(code);
		Member member = getNaverUserInfo(token);
		System.out.println(member);
		System.out.println(member.getNickname());

		Member smember = memberDao.SelectMember(member.getId());
		System.out.println(member);
		if (smember == null) {
			memberDao.insertMember(member);
			return member;
		} else {
			smember.setNickname(member.getNickname());
			smember.setProfileImage(member.getProfileImage());
			memberDao.updateMember(smember);
			return smember;
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

		//관리자 회원리스트 조회용
		@Override
		public List<Member> searchMembers(Map<String, Object> params) throws Exception {
		    return memberDao.searchMembers(params);
		}

		@Override
		public List<Member> searchMembersPaging(Map<String, Object> params) {
		    return memberDao.searchMembersPaging(params);
		}
		
		@Override
		public int countMembers(Map<String, Object> params) {
		    return memberDao.countMembers(params);
		}

		//관리자정보 조회용
		@Override
		public Member selectAdmin() {
		    return memberDao.selectAdmin();
		}





}
