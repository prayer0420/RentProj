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
import dao.member.MemberDAO;
import dao.member.MemberDAOImpl;
import dto.Alarm;
import dto.Member;
import utils.FcmConfig;


public class FcmServiceImpl implements FcmService{
	private AlarmDao alarmDao;
	private MemberDAO memberDao;
	
	public FcmServiceImpl() {
		alarmDao = new AlarmDaoImpl();
		memberDao = new MemberDAOImpl();
	}
	
	@Override
	public void regFcmToken(String id, String fcmToken)throws Exception{
		memberDao.updateFcmToken(id,fcmToken);
	}
	
	@Override
	public void sendAlarm(Alarm alarm) throws Exception{
		Member member = memberDao.selectMemberById(alarm.getRecvId());
		if(member ==null) throw new Exception("알람 받는 사용자 오류");
		String fcmToken = member.getFcmToken();
		alarmDao.insetAlarm(alarm); //알람을 구별하기 위해 insert해서 알람번호(auto-increment)
		
		URL url = new URL("https://fcm.googleapis.com/v1/projects/test-6b1b7/messages.send");
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Authorization", "Bearer " + FcmConfig.getAccessToken());
		conn.setRequestProperty("Content-Type", "application/json; UTF-8");
		conn.setDoOutput(true);
		
		//{"message":{"token":"...", notification:{"title":"제목", "body":"내용"}, "data":{내가 원하는 데이터}
		JSONObject notification = new JSONObject();
		notification.put("title", alarm.getTitle());
		notification.put("body", alarm.getBody());
		
		JSONObject data= new JSONObject();
		data.put("title", alarm.getTitle()+"");
		data.put("body", alarm.getBody());
		data.put("num", alarm.getNum());
		data.put("sendId", alarm.getSendId());
		data.put("sendName", alarm.getSendName());
		
		JSONObject json = new JSONObject();
		JSONObject message = new JSONObject();
		message.put("token", fcmToken);
		message.put("notification", notification);
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
	public void confirmAlarm(Integer num) throws Exception{
		alarmDao.updateAlarmConfirm(num);
	}
	
	@Override
	public List<Alarm> getAlarmList(String id) throws Exception{
		return alarmDao.selectAlarmList(id);
	}
}