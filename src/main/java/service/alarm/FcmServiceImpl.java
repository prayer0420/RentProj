package service.alarm;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

import org.json.simple.JSONObject;

import dao.alarm.AlarmDao;
import dao.alarm.AlarmDaoImpl;
import dao.alarmList.AlarmMessageDAO;
import dao.alarmList.AlarmMessageDAOImpl;
import dao.member.MemberDAO;
import dao.member.MemberDAOImpl;
import dto.Alarm;
import dto.AlarmMessage;
import dto.Member;
import utils.FcmConfig;


public class FcmServiceImpl implements FcmService{
	private AlarmDao alarmDao;
	private MemberDAO memberDao;
    private AlarmMessageDAO alarmMessageDao;

	
	public FcmServiceImpl() {
		alarmDao = new AlarmDaoImpl();
		memberDao = new MemberDAOImpl();
		alarmMessageDao = new AlarmMessageDAOImpl();
	}
	
	@Override
	public void regFcmToken(String id, String fcmToken)throws Exception{
		memberDao.updateFcmToken(id,fcmToken);
	}
	
	//알림 보내기
	@Override
	public void sendAlarm(Alarm alarm) throws Exception{
		Member member = memberDao.selectMemberById(alarm.getRecvId());
		if(member ==null) throw new Exception("알람 받는 사용자 오류");
		// FCM 토큰 체크
		String fcmToken = member.getFcmToken();
		if (fcmToken == null || fcmToken.trim().isEmpty()) {
		    System.out.println("FCM 토큰이 없습니다. 알림 전송 생략");
		    return;
		}
		alarmDao.insetAlarm(alarm); //알람을 구별하기 위해 insert해서 알람번호(auto-increment)
		
		URL url = new URL("https://fcm.googleapis.com/v1/projects/test-6b1b7/messages:send");
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Authorization", "Bearer " + FcmConfig.getAccessToken());
		conn.setRequestProperty("Content-Type", "application/json; UTF-8");
		conn.setDoOutput(true);
		
		//{"message":{"token":"...", notification:{"title":"제목", "body":"내용"}, "data":{내가 원하는 데이터}
		JSONObject notification = new JSONObject();
		notification.put("title", alarm.getTitle());
		notification.put("body", alarm.getContent());
		
		JSONObject data= new JSONObject();
		data.put("title", alarm.getTitle()+"");
		data.put("body", alarm.getContent());
		data.put("type", alarm.getType());
		data.put("isActive", String.valueOf(alarm.isActive())); //  문자열
		//System.out.println(alarm.getTitle());
		JSONObject json = new JSONObject();
		JSONObject message = new JSONObject();
		
		message.put("token", fcmToken);
		//message.put("notification", notification);
		message.put("data", data);
		json.put("message", message);
		
		//메시지 발송처리
		OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
		System.out.println(json.toJSONString());
		wr.write(json.toJSONString());
		wr.flush();
		
		int responseCode = conn.getResponseCode();
		System.out.println("Response Code : " + responseCode);
		
		BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();
		
		while((inputLine = in.readLine()) !=null) {
			response.append(inputLine);
		}
		in.close();
		//응답 출력
		System.out.println(response.toString());
	}
	@Override
	public void confirmAlarm(Integer no) throws Exception{
		alarmDao.updateAlarmConfirm(no);
	}
	
	@Override
	public List<Alarm> getAlarmList(String id) throws Exception{
		return alarmDao.selectAlarmList(id);
	}
	
	//회원가입 알림 보내기
	 @Override
	    public void sendSignupAlarm(String recvId) throws Exception {
	        Member member = memberDao.selectMemberById(recvId);
	        if (member == null) throw new Exception("사용자 없음");

	        AlarmMessage template = alarmMessageDao.selectByType("SIGNUP");
	        if (template == null) throw new Exception("가입 알림 템플릿 없음");

	        String filledTitle = template.getTitle().replace("${id}", member.getId());
	        String filledContent = template.getContent().replace("${id}", member.getId());

	        Alarm alarm = new Alarm(
	            template.getType(),
	            recvId,
	            filledTitle,
	            filledContent,
	            true
	        );
        	System.out.println("회원가입 알림 전송");
	        sendAlarm(alarm);
	    }
	 
	 //모든 알람 확인처리
	 @Override
	 public void confirmAllAlarms(String recvId) throws Exception {
	 	alarmDao.updateAlarmConfirmAll(recvId);
	 }
	 
}