package dao.alarm;


import java.util.List;

import dto.Alarm;

public interface AlarmDao  {

	void insetAlarm(Alarm alarm) throws Exception;
	void updateAlarmConfirm(Integer num) throws Exception;
	List<Alarm> selectAlarmList(String id) throws Exception;
}
