package service.alarm;


import java.util.List;

import dto.Alarm;


public interface FcmService {

		public void regFcmToken(String id, String fcmToken) throws Exception;
		public void sendAlarm(Alarm alarm)throws Exception;
		public void confirmAlarm(Integer num) throws Exception;
		public List<Alarm> getAlarmList(String id) throws Exception;
}
