package dao.alarm;


import java.util.List;

import dto.Alarm;
import dto.AlarmMessage;

public interface AlarmDao  {

	void insetAlarm(Alarm alarm) throws Exception;
	void updateAlarmConfirm(Integer no) throws Exception;
	List<Alarm> selectAlarmList(String id) throws Exception;

}
