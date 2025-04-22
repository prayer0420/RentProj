package dao.alarmList;

import java.util.List;

import controller.alarm.AlarmMessage;

public interface AlarmMessageDAO {
	// 모든 알림 메시지 조회
    List<AlarmMessage> selectAll();
    // 알림 메시지 등록
    int insert(AlarmMessage alarm);
    // 알림 메시지 일괄 삭제
    int delete(List<Integer> noList);
    
    AlarmMessage selectOne(int no);
}
