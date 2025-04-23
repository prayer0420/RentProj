package dao.alarmList;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.AlarmMessage;
import utils.MybatisSqlSessionFactory;

//  MyBatis SqlSession을 통해 실제 DB 연산을 수행
public class AlarmMessageDAOImpl implements AlarmMessageDAO {
	
	// 알림메시지조회
	@Override
	public List<AlarmMessage> selectAll() {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
            return session.selectList("mapper.alarmMessage.selectAll");
        } finally {
            session.close();
        }
    }
	
	// 알림 메시지를 삽입
	@Override
	public int insert(AlarmMessage alarm) {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
            int result = session.insert("mapper.alarmMessage.insert", alarm);
            session.commit();
            return result;
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
            return 0;
        } finally {
            session.close();
        }
    }
	
	// 알림 메시지 수정
	@Override
	public int update(AlarmMessage alarm) {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            int result = session.update("mapper.alarmMessage.update", alarm);
            session.commit();
            return result;
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
            return 0;
        } finally {
            session.close();
        }
    }
	
    // 알림 메시지 삭제
	@Override
	public int delete(List<Integer> noList) {
		SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
		try {
            int result = session.delete("mapper.alarmMessage.delete", noList);
            session.commit();
            return result;
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
            return 0;
        } finally {
            session.close();
        }
    }

	// 알림 메시지 단건 조회
	@Override
	public AlarmMessage selectOne(int no) {
	    SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	    try {
	        return session.selectOne("mapper.alarmMessage.selectOne", no);
	    } finally {
	        session.close();
	    }
	}
	
	@Override
    public AlarmMessage selectByType(String type) {
	    SqlSession session = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
        try {
            return session.selectOne("mapper.alarmMessage.selectByType", type);
        }finally{
        	session.close();
        }
    }
}