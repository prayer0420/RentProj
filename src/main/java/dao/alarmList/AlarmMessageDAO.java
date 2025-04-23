package dao.alarmList;

import java.util.List;

import dto.AlarmMessage;

public interface AlarmMessageDAO {
	// 모든 알림 메시지 조회
    List<AlarmMessage> selectAll();
    // 알림 메시지 등록
    int insert(AlarmMessage alarm);
    // 알림 메시지 수정
    int update(AlarmMessage alarm);
    // 알림 메시지 삭제
    int delete(List<Integer> noList);
    // 알림 메시지 단건 조회 (수정용 모달)
    AlarmMessage selectOne(int no);
}
