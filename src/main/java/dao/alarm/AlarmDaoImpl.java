package dao.alarm;


import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.Alarm;
import dto.AlarmMessage;
import utils.MybatisSqlSessionFactory;

public class AlarmDaoImpl implements AlarmDao{

	SqlSession sqlSession = MybatisSqlSessionFactory.getSqlSessionFactory().openSession();
	
	@Override
	public void insetAlarm(Alarm alarm)throws Exception {
		sqlSession.insert("mapper.alarm.insertAlarm", alarm);
		sqlSession.commit();
	}

	@Override
	public List<Alarm> selectAlarmList(String id)throws Exception {
		return sqlSession.selectList("mapper.alarm.selectAlarmList", id);
	}

	@Override
	public void updateAlarmConfirm(Integer no)throws Exception {
		sqlSession.update("mapper.alarm.updateAlarmConfirm",no);
		sqlSession.commit();
	}
}